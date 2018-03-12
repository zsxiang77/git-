//
//  JobBoardMenuView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/10.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOSSCheDianZhangCommon.h"


@protocol JobBoardMenuViewDelegate;

@interface JobBoardMenuView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic ,retain) UIView*                 contentView;
@property(nonatomic ,assign) id<JobBoardMenuViewDelegate> myDelegate;
@property(nonatomic ,assign) NSInteger               selectTag;
@property(nonatomic ,retain) NSArray                 *topButtonArray;


- (void)setMainViewWithArray:(NSArray*)topArray;

- (void)selfViewTouch:(id)sender;//隐藏
- (void)displayView;//显示
- (void)setButtonSelectWithIndex:(NSInteger)selectIndex;

@end


@protocol JobBoardMenuViewDelegate <NSObject>


- (void)playTypeSelectWithTag:(NSInteger)buttonTag view:(JobBoardMenuView*)selfView;
- (void)playTypeCancel:(JobBoardMenuView*)selfView;

@end

