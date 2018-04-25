//
//  JXCircleSlider.m
//  JXCircleSlider
//
//  Created by JackXu on 15/6/23.
//  Copyright (c) 2015年 BFMobile. All rights reserved.
//

#import "JXCircleSlider.h"
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

@implementation JXCircleSlider{
    CGFloat radius;
    UIImageView *biaoCengImageView;
}

-(id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _lineWidth = 10;
        _senderWidth= 54/2;
        _angle = 180;
        radius = self.frame.size.width/2 - _lineWidth/5 - _lineWidth*2;
        self.backgroundColor = [UIColor clearColor];
        biaoCengImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Group 2")];
        biaoCengImageView.frame = CGRectMake(0, self.frame.size.height/2-92/4, 92/2, 92/2);
        [self addSubview:biaoCengImageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
//    //1.绘制灰色的背景
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, radius, M_PI,0 , 0);
    CGContextSetLineWidth(context, _senderWidth);
    // 2. 创建一个渐变色
    // 创建RGB色彩空间，创建这个以后，context里面用的颜色都是用RGB表示
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 渐变色的颜色
    NSArray *colorArr = @[
                          (id)kRGBColor(149,229,108).CGColor,
                          (id)kRGBColor(98,219,153).CGColor
                          ];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorArr, NULL);
    // 释放色彩空间
    CGColorSpaceRelease(colorSpace);
    colorSpace = NULL;
    // ----------以下为重点----------
    // 3. "反选路径"
    // CGContextReplacePathWithStrokedPath
    // 将context中的路径替换成路径的描边版本，使用参数context去计算路径（即创建新的路径是原来路径的描边）。用恰当的颜色填充得到的路径将产生类似绘制原来路径的效果。你可以像使用一般的路径一样使用它。例如，你可以通过调用CGContextClip去剪裁这个路径的描边
    CGContextReplacePathWithStrokedPath(context);
    // 剪裁路径
    CGContextClip(context);
    // 4. 用渐变色填充
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, rect.size.height / 2), CGPointMake(rect.size.width, rect.size.height / 2), 0);
    // 释放渐变色
    CGGradientRelease(gradient);
//    //2.绘制进度
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2,radius, ToRad(_angle),0, 0);
    [kRGBColor(229,229,229) setStroke];
    CGContextSetLineWidth(context, _senderWidth);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextDrawPath(context, kCGPathStroke);
}
-(CGPoint)pointFromAngle:(int)angleInt{
    //中心点
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - _lineWidth*2.5, self.frame.size.height/2 - _lineWidth*2.5);
    //根据角度得到圆环上的坐标
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(ToRad(angleInt)));
    result.x = round(centerPoint.x + radius * cos(ToRad(angleInt)));
    CGPoint newPoint = CGPointMake(result.x, result.y);
    if (result.y>=115) {
        newPoint.y = 115;
    }
    return result;
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    //获取触摸点
    CGPoint lastPoint = [touch locationInView:self];
    //使用触摸点来移动小块
    [self movehandle:lastPoint];
    //发送值改变事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)movehandle:(CGPoint)lastPoint{
    //获得中心点
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2,
                                      self.frame.size.height/2);
    //计算中心点到任意点的角度
    float currentAngle = AngleFromNorth(centerPoint,
                                        lastPoint,
                                        NO);
    int angleInt = floor(currentAngle);
    //保存新角度
    self.angle = angleInt;
    if (self.angle>180) {
        //重新绘制
        CGPoint handleCenter =  [self pointFromAngle: (self.angle)];
        biaoCengImageView.frame = CGRectMake(handleCenter.x,handleCenter.y, 92/2, 92/2);
        [self setNeedsDisplay];
    }
}
-(void)changeAngle:(int)angle{
    _angle = angle;
     [self sendActionsForControlEvents:UIControlEventValueChanged];
    if (self.angle>180) {
        //重新绘制
        CGPoint handleCenter =  [self pointFromAngle: (self.angle)];
        biaoCengImageView.frame = CGRectMake(handleCenter.x,handleCenter.y, 92/2, 92/2);
        [self setNeedsDisplay];
    }
}
//从苹果是示例代码clockControl中拿来的函数
//计算中心点到任意点的角度
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    return (result >=0  ? result : result + 360.0);
}

@end
