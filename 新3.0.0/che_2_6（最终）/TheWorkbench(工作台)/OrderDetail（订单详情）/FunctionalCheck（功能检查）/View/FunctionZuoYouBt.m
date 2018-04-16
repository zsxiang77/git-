//
//  FunctionZuoYouBt.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FunctionZuoYouBt.h"

@implementation FunctionZuoYouBt

-(instancetype)initWithFrame:(CGRect)frame withZuoTitle:(NSString *)zuoStr withYouStr:(NSString *)youStr
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:0.5];
        [self.layer setBorderColor:kLineBgColor.CGColor];
        [self.layer setCornerRadius:15];
        self.dianJiSelect = NO;
        
        zuoBeiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 93/2, 30)];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)kRGBColor(255, 105, 112).CGColor,  (__bridge id)kRGBColor(255, 56, 61).CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, 93/2, 30);
        [zuoBeiView.layer addSublayer:gradientLayer];
        [zuoBeiView.layer setMasksToBounds:YES];
        [zuoBeiView.layer setCornerRadius:15];
        [self addSubview:zuoBeiView];
        
        youBeiView = [[UIView alloc]initWithFrame:CGRectMake(39, 0, 93/2, 30)];
        CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
        gradientLayer2.colors = @[(__bridge id)kRGBColor(156, 214, 31).CGColor,  (__bridge id)kRGBColor(98, 172, 13).CGColor];
        gradientLayer2.locations = @[@0.3, @1.0];
        gradientLayer2.startPoint = CGPointMake(0, 0);
        gradientLayer2.endPoint = CGPointMake(1.0, 0);
        gradientLayer2.frame = CGRectMake(0, 0, 93/2, 30);
        [youBeiView.layer addSublayer:gradientLayer2];
        [youBeiView.layer setMasksToBounds:YES];
        [youBeiView.layer setCornerRadius:15];
        [self addSubview:youBeiView];
        
        zuoBeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 93/2, 30)];
        zuoBeiLabel.font = [UIFont systemFontOfSize:14];
        zuoBeiLabel.textColor = kRGBColor(74, 74, 74);
        zuoBeiLabel.text = zuoStr;
        zuoBeiLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:zuoBeiLabel];
        
        youBeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(39, 0, 93/2, 30)];
        youBeiLabel.font = [UIFont systemFontOfSize:14];
        youBeiLabel.textColor = kRGBColor(74, 74, 74);
        youBeiLabel.text = youStr;
        youBeiLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:youBeiLabel];
        
        
        dianDianBt = [[UIButton alloc]init];
        [dianDianBt addTarget:self action:@selector(dianDianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:dianDianBt];
        [self bringSubviewToFront:dianDianBt];
        [dianDianBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)dianDianBtChick:(UIButton *)sender
{
    self.dianJiSelect = !self.dianJiSelect;
    [self setBuJuOrZhuangTai];
    self.dianJiSelectBlock(self.dianJiSelect);
}
-(void)setBuJuOrZhuangTai{
    if (self.dianJiSelect) {
        zuoBeiView.hidden = YES;
        youBeiView.hidden = NO;
        zuoBeiLabel.textColor = kRGBColor(74, 74, 74);
        youBeiLabel.textColor = [UIColor whiteColor];
    }else{
        zuoBeiView.hidden = NO;
        youBeiView.hidden = YES;
        zuoBeiLabel.textColor = [UIColor whiteColor];
        youBeiLabel.textColor = kRGBColor(74, 74, 74);
    }
}
@end

