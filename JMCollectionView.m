//
//  JMCollectionView.h
//  CarePics2
//
//  Created by John Matze on 2/5/17.
//  Copyright © 2017 Seaboden Software. All rights reserved.
//

#import "JMCollectionView.h"

@interface JMCollectionView ()

@property (nonatomic, strong) NSMutableArray * cellValues;
@property (nonatomic) CGSize cellSize;

@end


@implementation JMCollectionView

@synthesize collectionDelegate;
@synthesize dataSource;

- (id)init
{
    self = [super init];
    [self setScrollEnabled:YES];
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self reloadData];
}

- (void)refreshCells
{
    self.cellSize = [self.dataSource sizeForRowsInJMCollectionView:self];
    int collumns = floorf(self.frame.size.width/self.cellSize.width);

    CGFloat padding = 0;
    if (collumns > 1)
    {
        CGFloat remainingSpace = self.frame.size.width - (self.cellSize.width*collumns);
        padding = remainingSpace/(collumns+1);
    }
    else
    {
        padding = (self.frame.size.width - self.cellSize.width)/2;
    }

    for (int i = 0; i < self.cellValues.count; i++)
    {
        UIView * cell = [self.cellValues objectAtIndex:i];
        if (collumns == 0)
            [cell setFrame:CGRectMake(0, 0, self.cellSize.width, self.cellSize.height)];
        else
        {
            CGFloat xIndex = i%collumns;
            CGFloat yIndex = floorf(i/collumns);
            [cell setFrame:CGRectMake(xIndex * self.cellSize.width + (xIndex * padding) + padding, yIndex*self.cellSize.height, self.cellSize.width, self.cellSize.height)];
        }
    }

    if (self.cellValues.count > 0)
    {
        UIView * lastView = [self.cellValues objectAtIndex:self.cellValues.count-1];
        [self setContentSize:CGSizeMake(self.frame.size.width, lastView.frame.origin.y + lastView.frame.size.height + 20)];
    }
}

- (void)reloadData
{
    NSUInteger numberOfRows = [self.dataSource numberOfRowsInJMCollectionView:self];

    NSMutableArray * newCells = [[NSMutableArray alloc] init];

    for (NSUInteger i = 0; i < numberOfRows; i++)
    {
        UIView * viewAtRow = [self.dataSource JMCollectionView:self viewForRowAtIndex:i];
        if (self.cellValues.count > i)
        {
            UIView * oldView = [self.cellValues objectAtIndex:i];
            [oldView removeFromSuperview];
            //Remove notifications and gesture recognizers
            [[NSNotificationCenter defaultCenter] removeObserver:oldView];
            for(UITapGestureRecognizer * recognizer in oldView.gestureRecognizers)
            {
                [oldView removeGestureRecognizer:recognizer];
            }
        }
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [viewAtRow addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [viewAtRow addGestureRecognizer:doubleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];

        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressOccured:)];
        [viewAtRow addGestureRecognizer:longPress];

        [self addSubview:viewAtRow];
        [newCells addObject:viewAtRow];
    }

    self.cellValues = newCells;
    [self refreshCells];
}

- (UIView *)cellAtIndex:(NSUInteger)index
{
    if (self.cellValues.count > index)
        return [self.cellValues objectAtIndex:index];
    return nil;
}

- (void)singleTap:(UITapGestureRecognizer *)tgr
{
    UIView * cell = tgr.view;
    if ([self.collectionDelegate respondsToSelector:@selector(JMCollectionView:didSelectCell:atIndex:)])
        [self.collectionDelegate JMCollectionView:self didSelectCell:cell atIndex:[self.cellValues indexOfObject:cell]];
}

- (void)doubleTap:(UITapGestureRecognizer *)tgr
{
    UIView * cell = tgr.view;
    if ([self.collectionDelegate respondsToSelector:@selector(JMCollectionView:didDoubleTapCell:atIndex:)])
        [self.collectionDelegate JMCollectionView:self didDoubleTapCell:cell atIndex:[self.cellValues indexOfObject:cell]];
}

- (void)longPressOccured:(UILongPressGestureRecognizer *)lpr
{
    UIView * cell = lpr.view;
    if ([self.collectionDelegate respondsToSelector:@selector(JMCollectionView:didLongpressCell:atIndex:)])
        [self.collectionDelegate JMCollectionView:self didLongpressCell:cell atIndex:[self.cellValues indexOfObject:cell]];
}

- (NSMutableArray *)cellValues
{
    if (_cellValues)
        return _cellValues;
    _cellValues = [[NSMutableArray alloc] init];
    return _cellValues;
}

@end
