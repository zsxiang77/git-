//
//  StoresDateYuanView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoresDateYuanView.h"
#import "UIImage+ImageWithColor.h"
#import "BOSSCheDianZhangCommon.h"

#define xiaoAnNiuBanJie (245/2)

@implementation StoresDateYuanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setCornerRadius:245/2];
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i<12; i++) {
            UIButton *databt = [[UIButton alloc]init];
            [databt setTitle:[NSString stringWithFormat:@"%d",i+1] forState:(UIControlStateNormal)];
            [databt.layer setCornerRadius:36/2];
            [databt.layer setMasksToBounds:YES];
            [databt setBackgroundImage:[UIImage imageWithUIColor:kColorWithRGB(16, 174, 255, 0.23)] forState:(UIControlStateSelected)];
            [databt setBackgroundImage:[UIImage imageWithUIColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
            databt.tag = 3000+i;
            [databt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
            [databt addTarget:self action:@selector(datebtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:databt];
            if (i == 8) {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake(36/2-xiaoAnNiuBanJie, 245/2-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 9)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
//                    CGFloat gouy = ((245/2)*(245/2))/();
                    CGPoint poin = CGPointMake((245/2)/3-xiaoAnNiuBanJie, (245/2)/3*2-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 10)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3*2-xiaoAnNiuBanJie, (245/2)/3*1-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 11)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake(245/2-xiaoAnNiuBanJie, 36/2-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 0)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3*4-xiaoAnNiuBanJie, (245/2)/3-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 1)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3*5-xiaoAnNiuBanJie, (245/2)/3*2-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 2)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake(245-36/2-xiaoAnNiuBanJie, 245/2-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 3)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3*5-xiaoAnNiuBanJie, (245/2)/3*4-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 4)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3*4-xiaoAnNiuBanJie, (245/2)/3*5-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 5)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake(245/2-xiaoAnNiuBanJie, 245-36/2-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 6)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3*2-xiaoAnNiuBanJie, (245/2)/3*5-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }else if(i == 7)
            {
                [databt mas_makeConstraints:^(MASConstraintMaker *make) {
                    CGPoint poin = CGPointMake((245/2)/3-xiaoAnNiuBanJie, (245/2)/3*4-xiaoAnNiuBanJie);
                    make.center.mas_equalTo(poin);
                    make.width.height.mas_equalTo(36);
                }];
            }
        }
    }
    return self;
}

-(void)datebtChick:(UIButton *)sender
{
    for (int i = 0; i<12; i++) {
        UIButton *bt = [self viewWithTag:3000+i];
        bt.selected = NO;
    }
    sender.selected = !sender.selected;
}
@end
