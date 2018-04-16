//
//  HuanBackView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "HuanBackView.h"
#import "CheDianZhangCommon.h"

#define SELF_WIDTH CGRectGetWidth(self.bounds)
#define SELF_HEIGHT CGRectGetHeight(self.bounds)

@implementation HuanBackView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    drawArc(context, CGPointMake(SELF_WIDTH/2, SELF_HEIGHT/2), kRGBColor(244, 245, 246), SELF_WIDTH / 2);
    
    //drawFan(context, CGPointMake(SELF_WIDTH/2, SELF_HEIGHT/2),2.2*M_PI,0.8*M_PI , [UIColor greenColor], SELF_WIDTH / 2.5+5);
    drawFan(context, CGPointMake(SELF_WIDTH/2, SELF_HEIGHT/2),2.1*M_PI,0.9*M_PI , kRGBColor(244, 245, 246), SELF_WIDTH / 2.5-15);
    
}

@end
