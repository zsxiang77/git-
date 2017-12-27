//
//  VersionUpdate.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "VersionUpdate.h"
#import "CheDianZhangCommon.h"

@implementation VersionUpdate

-(instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        UIView *zhuView = [[UIView alloc]init];
        zhuView.backgroundColor = [UIColor whiteColor];
        [zhuView.layer setMasksToBounds:YES];
        [zhuView.layer setCornerRadius:5];
        [self addSubview:zhuView];
        [zhuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(kWindowW-40);
            make.height.mas_equalTo(550/2);
        }];
        zhuLabel = [[UILabel alloc]init];
        zhuLabel.backgroundColor = kNavBarColor;
        zhuLabel.textColor = [UIColor whiteColor];
        zhuLabel.font = [UIFont systemFontOfSize:15];
        zhuLabel.textAlignment = NSTextAlignmentCenter;
        [zhuView addSubview:zhuLabel];
        [zhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        
        UILabel *la1 = [[UILabel alloc]init];
        la1.font = [UIFont systemFontOfSize:14];
        la1.text = @"更新内容";
        [zhuView addSubview:la1];
        [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(zhuLabel.mas_bottom).mas_equalTo(10);
        
        }];
        
        zhuScrollView = [[UIScrollView alloc]init];
        [zhuView addSubview:zhuScrollView];
        [zhuScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            
            make.top.mas_equalTo(la1.mas_bottom).mas_equalTo(10);
            make.bottom.mas_equalTo(-65);
        }];
        
        
        UIButton *liJiBt = [[UIButton alloc]init];
        [liJiBt addTarget:self action:@selector(liJiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        liJiBt.backgroundColor = kNavBarColor;
        [liJiBt setTitle:@"立即更新" forState:(UIControlStateNormal)];
        [liJiBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [liJiBt.layer setMasksToBounds:YES];
        [liJiBt.layer setCornerRadius:3];
        [zhuView addSubview:liJiBt];
        [liJiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(45);
        }];
    }
    return self;
}

-(void)liJiBtChick:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%BD%A6%E5%BA%97%E9%95%BF-%E8%AE%A9%E9%97%A8%E5%BA%97%E7%BB%8F%E8%90%A5%E6%9B%B4%E7%AE%80%E5%8D%95/id1298987528?mt=8"]];
}

-(void)setYeMianArray:(NSArray *)array withbanBen:(NSString *)string
{
    zhuLabel.text = [NSString stringWithFormat:@"版本升级 %@",string];
    UIView *neirongView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-60, 50)];
    [zhuScrollView addSubview:neirongView];
    CGFloat hei = 0;
    if (array.count > 0) {
        for (int i = 0; i<array.count; i++) {
            UILabel *la = [[UILabel alloc]init];
            la.font = [UIFont systemFontOfSize:14];
            la.numberOfLines = 0;
            la.tag = 700+i;
            la.textColor = [UIColor grayColor];
            la.text = array[i];
            [neirongView addSubview:la];
            if (i == 0) {
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.mas_equalTo(0);
                }];
                hei += la.frame.size.height;
            }else{
                UILabel *dingweiL = [neirongView viewWithTag:700+i-1];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(0);
                    make.top.mas_equalTo(dingweiL.mas_bottom).mas_equalTo(10);
                }];
                hei += la.frame.size.height+10;
            }
        }
    }
    neirongView.frame = CGRectMake(0, 0, kWindowW-60, hei);
    zhuScrollView.contentSize = CGSizeMake(kWindowW-60, hei);
}

@end
