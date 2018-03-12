//
//  HomeRightBottomButton.m
//  DaJiang365
//
//  Created by shenYanPing on 17/5/30.
//  Copyright © 2017年 泰宇. All rights reserved.
//

#import "HomeRightBottomButton.h"

@interface HomeRightBottomButton ()
{
    BOOL    isShow;
}

@end
@implementation HomeRightBottomButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        isShow =YES;

        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        animation1.fromValue = [NSNumber numberWithFloat:1];
        animation1.toValue = [NSNumber numberWithFloat:0.9];
        animation1.duration = 0.5f;
        animation1.autoreverses = YES;
        animation1.repeatCount = HUGE_VALF;
        animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];    //动画速度设置
        animation1.fillMode = kCAFillModeForwards;
        animation1.removedOnCompletion = NO;
        [self.imageView.layer addAnimation:animation1 forKey:@"animation_hearte"];
    }
    return self;
}

- (BOOL)isShowStatus
{
    return isShow;
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (void)animationWithRotation0_45
{
    if (self == nil) {
        return;
    }
    if (![self isShowStatus]) {
        return;
    }
    isShow = NO;
    
    [self setAnchorPoint:CGPointMake(1, 0) forView:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:0];
    self.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [UIView commitAnimations];
}

- (void)animationWithRotation45_0
{
    if (self == nil) {
        return;
    }
    isShow = YES;
    
    [self setAnchorPoint:CGPointMake(1, 0) forView:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:0];
    self.transform = CGAffineTransformMakeRotation(0);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationWithRotation0_45];
    });
}

- (void)animationWithRotation0_10
{
    if (self == nil) {
        return;
    }
    if (![self isShowStatus]) {
        return;
    }
    isShow = NO;
    
    [self setAnchorPoint:CGPointMake(1, 0) forView:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:0];
    self.transform = CGAffineTransformMakeTranslation ( 40, 0 );
    [UIView commitAnimations];
}

- (void)animationWithRotation10_0
{
    if (self == nil) {
        return;
    }
    isShow = YES;
    
    [self setAnchorPoint:CGPointMake(1, 0) forView:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatCount:0];
    self.transform = CGAffineTransformMakeTranslation (0, 0);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationWithRotation10_0];
    });
}
@end
