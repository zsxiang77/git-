//
//  SegmentButtonsView.h
//  adult
//
//  Created by shen yan ping on 15/11/6.
//  Copyright (c) 2015年 AiMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentButtonsView : UIView

@property(nonatomic, copy)NSArray* buttonArray;
@property(nonatomic, retain)UIView* bottomView;
@property(nonatomic, assign)NSUInteger selectIndex;//当前button index
@property(nonatomic, copy)void (^buttonIndex)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame buttonArray:(NSArray*)buttons bottomView:(UIView*)bomView;
- (instancetype)initWithFrame2:(CGRect)frame buttonArray:(NSArray*)buttons bottomView:(UIView*)bomView;

- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray*)buttons;

- (void)SGBscrollViewDidEndDecelerating:(NSInteger)page;
- (void)SGBscrollViewDidScroll:(UIScrollView *)scrollView;
- (void)SGBscrollViewDidScroll2:(UIScrollView *)scrollView;

//强制选中
- (void)setButtonSelectedWithIndex:(NSInteger)index;
@end
