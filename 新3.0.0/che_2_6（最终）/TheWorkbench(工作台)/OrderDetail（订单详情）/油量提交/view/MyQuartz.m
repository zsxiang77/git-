//
//  MyQuartz.m
//  Quartz2DTest
//
//  Created by user on 13-5-24.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "MyQuartz.h"
#define ZHONXINWEIZHI ((kWindowH*704)/(1293+41))

@implementation MyQuartz

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();//获得当前view的图形上下文(context)
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 0);
    /*画矩形*/
    CGContextSetFillColorWithColor(context, kColorWithRGB(255, 255, 255, 0.9).CGColor);//填充颜色
//    CGContextFillRect(context,CGRectMake(0, 0, self.frame.size.width, 704/2-15));//填充框
//    CGContextDrawPath(context, kCGPathFillStroke);//绘画路s径
    
    CGPoint sPoints[6];//坐标点
    sPoints[0] =CGPointMake(0, 0);
    sPoints[1] =CGPointMake(self.frame.size.width, 0);
    sPoints[2] =CGPointMake(self.frame.size.width, ZHONXINWEIZHI-15);
    sPoints[3] =CGPointMake(self.frame.size.width-10, ZHONXINWEIZHI);;
    sPoints[4] =CGPointMake(10, ZHONXINWEIZHI);
    sPoints[5] =CGPointMake(0, ZHONXINWEIZHI-15);
    
    CGContextAddLines(context, sPoints, 6);//添加线
    CGContextClosePath(context);//封起来
    
    //下view
    CGPoint bomSPoint[6];
    bomSPoint[0] = CGPointMake(10, ZHONXINWEIZHI+1);
    bomSPoint[1] = CGPointMake(self.frame.size.width-10, ZHONXINWEIZHI+1);
    bomSPoint[2] = CGPointMake(self.frame.size.width, ZHONXINWEIZHI+1+10);
    bomSPoint[3] = CGPointMake(self.frame.size.width, self.frame.size.height);
    bomSPoint[4] = CGPointMake(0, self.frame.size.height);
    bomSPoint[5] = CGPointMake(0, ZHONXINWEIZHI+1+10);
    CGContextAddLines(context, bomSPoint, 6);//添加线
    CGContextClosePath(context);//封起来
    
    
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}
@end
