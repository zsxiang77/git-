//
//  HWCalendar.h
//  HWCalendar
//
//  Created by wqb on 2017/1/12.
//  Copyright © 2017年 hero_wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQNumberSlideView.h"

@class HWCalendar;

@protocol HWCalendarDelegate <NSObject>

- (void)calendar:(HWCalendar *)calendar didClickSureButtonWithDate:(NSString *)date;

@end

@interface HWCalendar : UIView<YQNumberSlideViewDelegate,UIGestureRecognizerDelegate>
{
    UIView * zuoYouButton;
    UIView *yueView;
}

@property(nonatomic,strong) YQNumberSlideView *yueSlideView;
@property(nonatomic,strong) YQNumberSlideView *nianSlideView;

@property (nonatomic, assign) BOOL showTimePicker; //default is NO. doesn't show timePicker

@property (nonatomic, weak) id<HWCalendarDelegate> delegate;

@property(nonatomic,assign)BOOL  shiFouNianShuaXin;

- (void)show;
- (void)dismiss;

@end
