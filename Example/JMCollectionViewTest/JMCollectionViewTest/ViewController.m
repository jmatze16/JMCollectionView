//
//  ViewController.m
//  JMCollectionViewTest
//
//  Created by John Matze on 2/6/17.
//  Copyright © 2017 Seaboden. All rights reserved.
//

#import "ViewController.h"
#import "JMCollectionView.h"
#import "SamplePictureView.h"

@interface ViewController () <JMCollectionViewDataSource,JMCollectionViewCollectionDelegate>

@property (nonatomic, strong) JMCollectionView * collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews
{
    [self.collectionView setFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height - 30)];
}

- (JMCollectionView *)collectionView
{
    if (_collectionView)
        return _collectionView;
    _collectionView = [[JMCollectionView alloc] init];
    _collectionView.collectionDelegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    return _collectionView;
}

- (void)JMCollectionView:(JMCollectionView *)collectionView didSelectCell:(UIView *)cell atIndex:(NSUInteger)index
{
    NSLog(@"Single Tap");
}

- (void)JMCollectionView:(JMCollectionView *)collectionView didDoubleTapCell:(UIView *)cell atIndex:(NSUInteger)index
{
    NSLog(@"Double Tap");
}

- (void)JMCollectionView:(JMCollectionView *)collectionView didLongpressCell:(UIView *)cell atIndex:(NSUInteger)index
{
    NSLog(@"Tap/Hold");
}

- (UIView *)JMCollectionView:(JMCollectionView *)collectionView viewForRowAtIndex:(NSUInteger)index
{
    SamplePictureView * cell = (SamplePictureView *)[collectionView cellAtIndex:index];
    if (!cell)
        cell = [[SamplePictureView alloc] init];
    
    return cell;
}

- (NSUInteger)numberOfRowsInJMCollectionView:(JMCollectionView *)collectionView
{
    return 30;
}

- (CGSize)sizeForRowsInJMCollectionView:(JMCollectionView *)collectionView
{
    //Landscape mode
    if (self.view.frame.size.width > self.view.frame.size.height)
    {
        return CGSizeMake(self.view.frame.size.width*.25,self.view.frame.size.width*.3);
    }
    else //Portrate mode
    {
        return CGSizeMake(self.view.frame.size.width*.3,self.view.frame.size.width*.38);
    }
}

@end
