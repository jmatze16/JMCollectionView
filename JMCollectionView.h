//
//  JMCollectionView.h
//  CarePics2
//
//  Created by John Matze on 2/5/17.
//  Copyright © 2017 Seaboden Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMCollectionView;
@protocol JMCollectionViewCollectionDelegate <NSObject>   //define delegate protocol

/***********************************************************************
 ** Defined delegate methods to be implemented within another class. Similar
 ** to UITableView
 ************************************************************************/
@required
//Deleges called for every networking call

//Called when a single tap occurs on a cell
- (void)JMCollectionView:(JMCollectionView *)collectionView didSelectCell:(UIView *)cell atIndex:(NSUInteger)index;
//Called when a double tap occurs on a cell
- (void)JMCollectionView:(JMCollectionView *)collectionView didDoubleTapCell:(UIView *)cell atIndex:(NSUInteger)index;
//Called when a long press occurs on a cell
- (void)JMCollectionView:(JMCollectionView *)collectionView didLongpressCell:(UIView *)cell atIndex:(NSUInteger)index;

@end

@protocol JMCollectionViewDataSource <NSObject>   //define data source protocol

/***********************************************************************
 ** Define data source methods to be implemented within another class
 ************************************************************************/
@required
//Deleges called for every networking call
- (UIView *)JMCollectionView:(JMCollectionView *)collectionView viewForRowAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfRowsInJMCollectionView:(JMCollectionView *)collectionView;
- (CGSize)sizeForRowsInJMCollectionView:(JMCollectionView *)collectionView;

@end

@interface JMCollectionView : UIScrollView

@property (nonatomic, weak) id <JMCollectionViewCollectionDelegate> collectionDelegate; //define MyClassDelegate as delegate
@property (nonatomic, weak) id <JMCollectionViewDataSource> dataSource; //define MyClassDelegate as delegate

- (void)refreshCells;//Repositions the cells
- (void)reloadData;//Calls back to the dataSource to get more data
- (UIView *)cellAtIndex:(NSUInteger)index;

@end
