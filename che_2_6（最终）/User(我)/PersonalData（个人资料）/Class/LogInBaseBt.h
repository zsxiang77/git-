//
//  LogInBaseBt.h
//  DaJiang365
//
//  Created by 周岁祥 on 16/3/8.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"


@interface LogInBaseBt : NSObject
+(void)shiZhilabel:(UILabel *)label;
+(void)zhuTiButton:(UIButton *)sender;
+(void)shiZhiBt:(UIButton *)sender;
+(void)shiZhiBtWithBackgroundRed:(UIButton *)sender;
/**
 *  倒计时按钮
 */
+ (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color withButton:(UIButton *)sender;
+ (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color withButton:(UIButton *)sender mainTextColor:(UIColor *)mainTextColor countTextColor:(UIColor *)countTextColor;



+(void)sheZhiYanZhengMaDateWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color withButton:(UIButton *)sender mainTextColor:(UIColor *)mainTextColor countTextColor:(UIColor *)countTextColor;
/**
 *  textField
 */
+(void)setTextField:(UITextField *)textField;
+(UIEdgeInsets)inWithsets;
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;


@end
