//
//  AITBuyView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITBuyView.h"
#import "CheDianZhangCommon.h"

@implementation AITBuyView

-(instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        
        UIView *zhanSView = [[UIView alloc]init];
        zhanSView.backgroundColor = [UIColor whiteColor];
        [zhanSView.layer setMasksToBounds:YES];
        [zhanSView.layer setCornerRadius:32/4];
        [self addSubview:zhanSView];
        [zhanSView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(kWindowW-40);
            make.height.mas_equalTo(383/2);
        }];
        
        UIImageView *touImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"AIT_daGou")];
        [zhanSView addSubview:touImageView];
        [touImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zhanSView);
            make.top.mas_equalTo(35/2);
            make.width.height.mas_equalTo(128/2);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"订购信息提交成功";
        [zhanSView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zhanSView);
            make.top.mas_equalTo(touImageView.mas_bottom).mas_equalTo(10);
        }];
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = @"工作人员会在1-2工作日内与您联系请保持电话畅通";
        label2.textAlignment = NSTextAlignmentCenter;
        label2.numberOfLines = 0;
        label2.textColor = [UIColor grayColor];
        label2.font = [UIFont systemFontOfSize:12];
        [zhanSView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zhanSView);
            make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(200);
        }];
        
        self.daoLabel = [[UILabel alloc]init];
        [zhanSView addSubview:self.daoLabel];
        self.daoLabel.textColor = [UIColor grayColor];
        self.daoLabel.font = [UIFont systemFontOfSize:12];
        [self.daoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zhanSView);
            make.top.mas_equalTo(label2.mas_bottom).mas_equalTo(10);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(dissMissView)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)dissMissView
{
    self.hidden = YES;
    self.fanHuiPopBlock();
}

@end
