//
//  AITDetectView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITDetectView.h"


@implementation AITDetectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *touImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Combine_Shape")];
        touImageView.frame = CGRectMake(0, 0, kWindowW, 31);
        [self addSubview:touImageView];
        
        UIView *xiaBackView = [[UIView alloc]init];
        xiaBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:xiaBackView];
        [xiaBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.top.mas_equalTo(touImageView.mas_bottom).mas_equalTo(-1);
        }];
        
        
        UILabel *touLabel = [[UILabel alloc]init];
        touLabel.font = [UIFont systemFontOfSize:14];
        touLabel.text = @"关于AIT检测设备";
        touLabel.textColor = kZhuTiColor;
        [self addSubview:touLabel];
        [touLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX).mas_equalTo(-10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
        self.shouQiBt = [[UIButton alloc]init];
        [self.shouQiBt addTarget:self action:@selector(shouQiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.shouQiBt];
        [self.shouQiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(200);
        }];
        
        self.xuanZhuanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"10_arrow")];
        [self addSubview:self.xuanZhuanImageView];
        [self.xuanZhuanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(touLabel);
            make.left.mas_equalTo(touLabel.mas_right).mas_equalTo(2);
            make.width.height.mas_equalTo(15);
        }];
        
        self.shiFouKeYongLabel = [[UILabel alloc]init];
        self.shiFouKeYongLabel.font = [UIFont systemFontOfSize:12];
        self.shiFouKeYongLabel.textColor = UIColorFromRGBA(0xD0021B, 1);
        self.shiFouKeYongLabel.text = @"AIT产品插入汽车可直接检测";
        [self addSubview:self.shiFouKeYongLabel];
        [self.shiFouKeYongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(36);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.font = [UIFont systemFontOfSize:12];
        label1.text = @"若您未购买AIT设备，您可以：";
        [self addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.shiFouKeYongLabel.mas_bottom).mas_equalTo(15);
        }];
        
        UIButton *buyAitBt = [[UIButton alloc]init];
        buyAitBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [buyAitBt addTarget:self action:@selector(buyAitBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [buyAitBt setTitle:@"购买AIT产品" forState:(UIControlStateNormal)];
        [buyAitBt setTitleColor:UIColorFromRGBA(0xf5a723, 1.0) forState:(UIControlStateNormal)];
        [buyAitBt setImage:DJImageNamed(@"10_buy") forState:(UIControlStateNormal)];
        buyAitBt.imageEdgeInsets = UIEdgeInsetsMake(5, -5, 5, 5);
        [buyAitBt.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [buyAitBt.layer setMasksToBounds:YES];
        [buyAitBt.layer setCornerRadius:3];
        [buyAitBt.layer setBorderWidth:1];
        [buyAitBt.layer setBorderColor:UIColorFromRGBA(0xf5a723, 1.0).CGColor];
        [self addSubview:buyAitBt];
        [buyAitBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(5);
            make.width.mas_equalTo(176);
            make.height.mas_equalTo(30);
        }];
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.font = [UIFont systemFontOfSize:12];
        label2.text = @"或设置已有AIT设备序列号：";
        [self addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(buyAitBt.mas_bottom).mas_equalTo(10);
        }];
        
        UIButton *settingAitBt = [[UIButton alloc]init];
        settingAitBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [settingAitBt addTarget:self action:@selector(settingAitBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [settingAitBt setTitle:@"设置AIT产品序列号" forState:(UIControlStateNormal)];
        [settingAitBt setTitleColor:UIColorFromRGBA(0x53cb8c, 1.0) forState:(UIControlStateNormal)];
        [settingAitBt setImage:DJImageNamed(@"10_serial") forState:(UIControlStateNormal)];
        settingAitBt.imageEdgeInsets = UIEdgeInsetsMake(5, -5, 5, 5);
        [settingAitBt.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [settingAitBt.layer setMasksToBounds:YES];
        [settingAitBt.layer setCornerRadius:3];
        [settingAitBt.layer setBorderWidth:1];
        [settingAitBt.layer setBorderColor:UIColorFromRGBA(0x53cb8c, 1.0).CGColor];
        [self addSubview:settingAitBt];
        [settingAitBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(label2.mas_bottom).mas_equalTo(5);
            make.width.mas_equalTo(176);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

-(void)buyAitBtChick:(UIButton *)sender
{
    self.buyAitBtChickBlock();
}
-(void)settingAitBtChick:(UIButton *)sender
{
    self.settingAitBtChickBlock();
}

-(void)setYeMianYangShiWith:(BOOL)sender
{
    self.shouQiBt.selected = !sender;
    if (sender == YES) {
        self.shiFouKeYongLabel.text = @"该车型可使用AIT设备，请插入设备进行检测";
        self.shiFouKeYongLabel.textColor = UIColorFromRGBA(0xf5a723, 1.0);
        [UIView animateWithDuration:0.2 animations:^{
            self.xuanZhuanImageView.transform = CGAffineTransformMakeRotation(0);
            self.frame = CGRectMake(0, kWindowH-190, kWindowW, 190);
        } completion:^(BOOL finished) {
        }];
        
    }else{
        self.shiFouKeYongLabel.text = @"AIT产品插入汽车可直接检测";
        self.shiFouKeYongLabel.textColor = [UIColor redColor];
        [UIView animateWithDuration:0.2 animations:^{
            self.xuanZhuanImageView.transform = CGAffineTransformMakeRotation(M_PI);
            self.frame = CGRectMake(0, kWindowH-30, kWindowW, 190);
        } completion:^(BOOL finished) {
        }];
    }
}

-(void)shouQiBtChick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        [UIView animateWithDuration:0.2 animations:^{
            self.xuanZhuanImageView.transform = CGAffineTransformMakeRotation(M_PI);
            self.frame = CGRectMake(0, kWindowH-30, kWindowW, 190);
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.xuanZhuanImageView.transform = CGAffineTransformMakeRotation(0);
            self.frame = CGRectMake(0, kWindowH-190, kWindowW, 190);
        } completion:^(BOOL finished) {
        }];
    }
}

@end
