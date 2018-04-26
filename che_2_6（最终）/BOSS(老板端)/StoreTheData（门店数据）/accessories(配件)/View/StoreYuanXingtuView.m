//
//  StoreYuanXingtuView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreYuanXingtuView.h"

#define PI 3.14159265358979323846
@implementation StoreYuanXingtuView
{
    NSArray * Arrays;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self==[super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        Arrays = @[@"0.25",@"0.35",@"0.2",@"0.1",@"0.1"];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 30);//线的宽度
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
    CGContextAddArc(context, self.frame.size.width/2, 150, 120, 0, 2*PI, 0); //添加一个
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);//填充颜色
    for (int i = 0 ; i< Arrays.count; i++) {
        CGFloat endRedg = 2*PI*[Arrays[i] floatValue];
        CGFloat startRedeg =0*i+2*PI*[Arrays[i] floatValue];
        CGContextDrawPath(context, kCGPathStroke); //绘制路径
    }
    
    
   
    
}
@end
