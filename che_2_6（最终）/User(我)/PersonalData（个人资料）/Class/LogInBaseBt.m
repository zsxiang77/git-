//
//  LogInBaseBt.m
//  DaJiang365
//
//  Created by 周岁祥 on 16/3/8.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import "LogInBaseBt.h"
#import "UIImage+ImageWithColor.h"

@implementation LogInBaseBt
+(void)zhuTiButton:(UIButton *)sender
{
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sender.layer setMasksToBounds:YES];
    [sender.layer setCornerRadius:4];
    sender.backgroundColor = kZhuTiColor;
}
+(void)shiZhiBt:(UIButton *)sender
{
    [sender.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [sender.layer setCornerRadius:3];
    [sender.layer setBorderWidth:0.5];//设置边界的宽度
    //设置按钮的边界颜色
    [sender.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
}
+(void)shiZhilabel:(UILabel *)label
{
    [label.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [label.layer setCornerRadius:3];
}
+(void)shiZhiBtWithBackgroundRed:(UIButton *)sender
{
    [sender.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [sender.layer setCornerRadius:3];
    [sender setBackgroundImage:[UIImage imageWithUIColor:kNavBarColor] forState:(UIControlStateNormal)];
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sender setBackgroundImage:[UIImage imageWithUIColor:kRGBColor(245, 86, 115)] forState:(UIControlStateHighlighted)];
}

/**
 *  倒计时按钮
 */
+ (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color withButton:(UIButton *)sender{
//    倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    每秒执行一次
    dispatch_source_set_timer(source,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(source);
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.backgroundColor = mColor;
                [sender setTitle:title forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        } else {
//            int seconds = timeOut % 60;
            NSInteger seconds = timeOut;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.backgroundColor = color;
                [sender setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(source);
    
}
+ (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color withButton:(UIButton *)sender mainTextColor:(UIColor *)mainTextColor countTextColor:(UIColor *)countTextColor
{
    
    //    倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //    每秒执行一次
    dispatch_source_set_timer(source,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(source);
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.backgroundColor = mColor;
                [sender setTitleColor:mainTextColor forState:(UIControlStateNormal)];
                [sender setTitle:title forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                
            });
        } else {
            //            int seconds = timeOut % 60;
            NSInteger seconds = timeOut;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.backgroundColor = color;
                [sender setTitleColor:mainTextColor forState:(UIControlStateNormal)];
                [sender setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(source);
}

+(void)sheZhiYanZhengMaDateWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color withButton:(UIButton *)sender mainTextColor:(UIColor *)mainTextColor countTextColor:(UIColor *)countTextColor
{
//    kWeakSelf(weakSelf)
    //    倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //    每秒执行一次
    dispatch_source_set_timer(source,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(source);
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.backgroundColor = mColor;
                [sender setTitleColor:mainTextColor forState:(UIControlStateNormal)];
                [sender setTitle:title forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        } else {
            //            int seconds = timeOut % 60;
            NSInteger seconds = timeOut;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.backgroundColor = color;
                [sender.layer setBorderColor:[kRGBColor(102, 102, 102) CGColor]];
                [sender setTitleColor:countTextColor forState:(UIControlStateNormal)];
                [sender setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(source);
}

/**
 *  textField
 */
+(void)setTextField:(UITextField *)textField
{
    textField.borderStyle = UITextBorderStyleNone;
    [textField setBackground:[DJImageNamed(@"input_bg") resizableImageWithCapInsets:[self inWithsets] resizingMode:(UIImageResizingModeStretch)]];
}

+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}
#pragma mark - 图片复用函数
+(UIEdgeInsets)inWithsets
{
    CGFloat top = 15; // 顶端盖高度
    CGFloat bottom = 15 ; // 底端盖高度
    CGFloat left = 15; // 左端盖宽度
    CGFloat right = 15; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return insets;
}


@end
