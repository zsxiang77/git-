//
//  StoreYuanXingtuView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreYuanXingtuView.h"
#import "CPArcModel.h"
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
        //[self setupLabelWithModel:model strokeStart:strokeStart]; // 添加label
        strokeStart = shapeLayer.strokeEnd;
    }
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
