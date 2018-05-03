//
//  StoreYuanXingtuView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreYuanXingtuView.h"
#import "CPArcModel.h"
/**
 *  角度转换成弧度
 */
#define k_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
/**
 *  弧度转角度
 */
#define k_RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#define k_ProgressLabel_Width  40.0
#define k_ProgressLabel_Height 80.0
// 调整圆环和文字距离
#define k_Radius_Coefficient   2.1

@implementation StoreYuanXingtuView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self ==[super initWithFrame:frame]){
        CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        UIView *centerView = [[UIView alloc]init];
        centerView.backgroundColor = [UIColor yellowColor];
        centerView.frame = CGRectMake(0, 0, self.frame.size.width/2+20, 256/2);
        centerView.center = center;
        [centerView.layer setMasksToBounds:YES];
        [centerView.layer setCornerRadius:256/4];
        [centerView.layer setBorderWidth:0.5];
        [centerView.layer setBorderColor:kLineBgColor.CGColor];
        [self addSubview:centerView];
        
        gundongView = [[UIView alloc]init];
        gundongView.backgroundColor = [UIColor redColor];
        gundongView.frame = CGRectMake(0, 0, 256/2, 256/2);
        [gundongView.layer setMasksToBounds:YES];
        [gundongView.layer setCornerRadius:256/4];
        [centerView addSubview:gundongView];
        self.isSelectXuan = YES;
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
  action:@selector(handleSwipe:)];
            recognizer.direction = UISwipeGestureRecognizerDirectionRight; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
             [gundongView addGestureRecognizer:recognizer];
            //向左轻扫手势
           recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self                                                          action:@selector(handleSwipe:)];
             recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
             [gundongView addGestureRecognizer:recognizer];
        
    }
    return self;
}
- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        CPArcModel *model = self.arcs[0];
         CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x,center.y)
                                                     radius:model.radius
                                                 startAngle:0
                                                   endAngle:M_PI * 2
                                                  clockwise:NO];
    }
    return _bezierPath;
}
- (void)setArcs:(NSArray<CPArcModel *> *)arcs {
    _arcs = arcs;
    CGFloat strokeStart = 0.0f;
    for (CPArcModel *model in arcs) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = self.bezierPath.CGPath;
        shapeLayer.strokeColor = model.color.CGColor; // 弧度颜色
        shapeLayer.fillColor = [UIColor clearColor].CGColor; // 内部填充色
        shapeLayer.lineWidth = model.width; // 线宽
        shapeLayer.lineCap = kCALineCapButt;
        shapeLayer.strokeStart = strokeStart+0.003;
        shapeLayer.strokeEnd = model.progress + strokeStart; // 占圆环的比例
        [self.layer addSublayer:shapeLayer];
        [self setupLabelWithModel:model strokeStart:strokeStart]; // 添加label
        strokeStart = shapeLayer.strokeEnd;
    }
}
- (void)setupLabelWithModel:(CPArcModel *)model strokeStart:(CGFloat)strokeStart {
    
    CGFloat angle = 360 * (strokeStart + model.progress / 2.0); // 角度
    CGFloat radius = model.radius;
    CGFloat radians = 0; // 初始化弧度
    CGFloat x = 0;
    CGFloat y = 0;
    CGPoint point = self.center;
    NSTextAlignment textAlignment = NSTextAlignmentCenter;
    if (angle <= 90) {
        radians = k_DEGREES_TO_RADIANS(angle); // 角度转成弧度
        CGFloat currentX = cos(radians) * radius;
        CGFloat currentY = sin(radians) * radius;
        x = point.x + currentX;
        y = point.y - currentY;
    } else if (angle <= 180) {
        radians = k_DEGREES_TO_RADIANS(180 - angle);
        CGFloat currentX = cos(radians) * radius;
        CGFloat currentY = sin(radians) * radius;
        x = point.x - currentX ;
        y = point.y - currentY ;

    } else if (angle <= 270) {
        radians = k_DEGREES_TO_RADIANS(angle - 180);
        CGFloat currentX = cos(radians) * radius;
        CGFloat currentY = sin(radians) * radius;
        x = point.x - currentX;
        y = point.y + currentY;

    } else {
        radians = k_DEGREES_TO_RADIANS(360 - angle);
        CGFloat currentX = cos(radians) * radius;
        CGFloat currentY = sin(radians) * radius;
        x = point.x + currentX;
        y = point.y + currentY;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, k_ProgressLabel_Width, k_ProgressLabel_Height)];
    //label.backgroundColor = [UIColor grayColor];
    label.center = CGPointMake(x,y);
    label.textAlignment = textAlignment;
    label.textColor = [UIColor blackColor];
    label.numberOfLines =2;
    label.text = [NSString stringWithFormat:@"名字\n%.0f%%", model.progress * 100.0];
    label.font = [UIFont systemFontOfSize:12];
    [self addSubview:label];
    
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)sender
{
    if(self.isSelectXuan){
        self.isSelectXuan = NO;
        [UIView animateWithDuration:0.4 animations:^{
                gundongView.frame = CGRectMake(self.frame.size.width/2+20-256/2, 0, 256/2, 256/2);
        }];
    
    }else{
        [UIView animateWithDuration:0.4 animations:^{
               gundongView.frame = CGRectMake(0, 0, 256/2, 256/2);
        }];
        self.isSelectXuan = YES;
    }
}


@end
