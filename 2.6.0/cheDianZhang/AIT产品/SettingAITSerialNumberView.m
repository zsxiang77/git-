//
//  SettingAITSerialNumberView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/10.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "SettingAITSerialNumberView.h"
#import "CheDianZhangCommon.h"

@implementation SettingAITSerialNumberView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        UIView *mainView = [[UIView alloc]init];
        mainView.backgroundColor = [UIColor whiteColor];
        [mainView.layer setMasksToBounds:YES];
        [mainView.layer setCornerRadius:3];
        [self addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(401/2);
            make.centerY.mas_equalTo(self);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.font = [UIFont systemFontOfSize:17];
        label1.text = @"AIT产品设置完成";
        [mainView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(mainView);
            make.top.mas_equalTo(10);
        }];
        
        UIImageView *zhongImah = [[UIImageView  alloc]initWithImage:DJImageNamed(@"09_test")];
        [mainView addSubview:zhongImah];
        [zhongImah mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(mainView);
            make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(10);
            make.width.height.mas_equalTo(47);
        }];
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.font = [UIFont systemFontOfSize:31/2];
        label2.textColor = UIColorFromRGBA(0xf9b42d, 1);
        label2.text = @"请插入AIT产品开始检测";
        [mainView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(mainView);
            make.top.mas_equalTo(zhongImah.mas_bottom).mas_equalTo(8);
        }];
        
        UILabel *label3 = [[UILabel alloc]init];
        label3.font = [UIFont systemFontOfSize:12];
        label3.textColor = UIColorFromRGBA(0x9b9b9b, 1);
        label3.text = @"检测过程中，请不要拔下AIT设备！";
        [mainView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(mainView);
            make.top.mas_equalTo(label2.mas_bottom).mas_equalTo(8);
        }];
        
        
        self.queDingBt = [[UIButton alloc]init];
        self.queDingBt.titleLabel.font = [UIFont systemFontOfSize:31/2];
        [self.queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
        [self.queDingBt setTitleColor:kNavBarColor forState:(UIControlStateNormal)];
        [mainView addSubview:self.queDingBt];
        [self.queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(38);
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [mainView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.queDingBt.mas_top).mas_equalTo(0);
        }];
    }
    return self;
}


@end
