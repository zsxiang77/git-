//
//  PopTimePickerView.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopTimePickerView : UIView

@property (nonatomic, strong) NSDate *currDate;
@property (nonatomic, strong, readonly) UIDatePicker *datePicker;

@property(nonatomic, copy) void (^didSecectedDataCallBack)(NSDate *date);


- (void)showWithDate:(NSDate *)date;

@end
