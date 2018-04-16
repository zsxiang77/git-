//
//  KDWaterWaveView.m
//  test
//
//  Created by wangdong on 2018/4/2.
//  Copyright © 2018年 ingkee. All rights reserved.
//

#import "KDWaterWaveView.h"

@interface KDWaterWaveView ()
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;

@property (nonatomic, strong) CAShapeLayer  *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer  *secondWaveLayer;
@property (nonatomic, strong) CAShapeLayer  *thirdWaveLayer;
@end

@implementation KDWaterWaveView {
    
    CGFloat waveAmplitude;  // 波纹振幅
    CGFloat waveCycle;      // 波纹周期
    CGFloat waveSpeed;      // 波纹速度
    CGFloat waveGrowth;     // 波纹上升速度
    
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;           // 波浪x位移
    CGFloat currentWavePointY; // 当前波浪上市高度Y（高度从大到小 坐标系向下增长）
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        [self setUp];
        self.hidden = YES;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        [self setUp];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    waterWaveHeight = self.frame.size.height/2 + 2;
    waterWaveWidth  = self.frame.size.width;
    if (waterWaveWidth > 0) {
        waveCycle =  5 * M_PI / waterWaveWidth;
    }
    
    
    currentWavePointY = self.frame.size.height / 2;
    
    if (_firstWaveLayer == nil) {
        // 创建第一个波浪Layer
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    if (_secondWaveLayer == nil) {
        // 创建第二个波浪Layer
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    
    if (!_thirdWaveLayer) {
        self.thirdWaveLayer = [CAShapeLayer layer];
        self.thirdWaveLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:self.thirdWaveLayer];
    }
    
    if (_waveDisplaylink == nil) {
        // 启动定时调用
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(getCurrentWave:)];
        [_waveDisplaylink setPaused:YES];
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)setUp
{
    waterWaveHeight = self.frame.size.height/2 + 2;
    waterWaveWidth  = self.frame.size.width;
    
    waveGrowth = 0.85;
    waveSpeed = 0.2/M_PI;
    
    [self resetProperty];
}

- (void)resetProperty
{
    currentWavePointY = self.frame.size.height / 2;
    
    offsetX = 0;
}


-(void)startWave{
    self.hidden = NO;
    [_waveDisplaylink setPaused:NO];
}
-(void)stopWave{
    self.hidden = YES;
    [self.waveDisplaylink setPaused:YES];
}
- (void)reset
{
    [self stopWave];
    [self resetProperty];
    
    if (_waveDisplaylink) {
        [_waveDisplaylink invalidate];
        
        _waveDisplaylink = nil;
    }
    
    if (_firstWaveLayer) {
        [_firstWaveLayer removeFromSuperlayer];
        _firstWaveLayer = nil;
    }
    
    if (_secondWaveLayer) {
        [_secondWaveLayer removeFromSuperlayer];
        _secondWaveLayer = nil;
    }
}

-(void)animateWave
{
    waveAmplitude = 15;
}

-(void)getCurrentWave:(CADisplayLink *)displayLink{
    
    [self animateWave];
    
    if ( waveGrowth > 0 && currentWavePointY > 2 * waterWaveHeight) {
        // 波浪高度未到指定高度 继续上涨
        currentWavePointY -= waveGrowth;
    }else if (waveGrowth < 0 && currentWavePointY < 2 * waterWaveHeight){
        currentWavePointY -= waveGrowth;
    }
    
    // 波浪位移
    offsetX += waveSpeed;
    
    [self setCurrentFirstWaveLayerPath];
    
    [self setCurrentSecondWaveLayerPath];
    
    [self setCurrentThirdWaveLayerPath];
    
    
}

-(void)setCurrentFirstWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = waveAmplitude * sin(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth + 2, self.frame.size.height + 2);
    CGPathAddLineToPoint(path, nil, -2, self.frame.size.height + 2);
    CGPathCloseSubpath(path);
    
    self.firstWaveLayer.lineWidth = 1.0f;
    self.firstWaveLayer.strokeColor = [UIColor redColor].CGColor;
    
    _firstWaveLayer.path = path;
    
    CGPathRelease(path);
}

-(void)setCurrentSecondWaveLayerPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = waveAmplitude * cos(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth + 2, self.frame.size.height + 2);
    CGPathAddLineToPoint(path, nil, -2, self.frame.size.height + 2);
    CGPathCloseSubpath(path);
    
    self.secondWaveLayer.lineWidth = 1.0f;
    self.secondWaveLayer.strokeColor = [UIColor blueColor].CGColor;
    
    _secondWaveLayer.path = path;
    
    CGPathRelease(path);
}
- (void)setCurrentThirdWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = waveAmplitude * sin(waveCycle * x - offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth + 2, self.frame.size.height + 2);
    CGPathAddLineToPoint(path, nil, -2, self.frame.size.height + 2);
    CGPathCloseSubpath(path);
    
    self.thirdWaveLayer.lineWidth = 1.0f;
    self.thirdWaveLayer.strokeColor = [UIColor greenColor].CGColor;
    
    self.thirdWaveLayer.path = path;
    
    CGPathRelease(path);
}


- (void)dealloc{
    [self reset];
}
@end
