//
//  SCDDanViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "SCDDanViewController.h"
#import "WritePersonalViewController.h"

@interface SCDDanViewController ()

@end

@implementation SCDDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"生成工单" withBackButton:YES];
    
    UIImageView  *tupianImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"AIT_daGou")];
    [self.view addSubview:tupianImageView];
    [tupianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(kNavBarHeight+77/2);
        make.width.height.mas_equalTo(60);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.font = [UIFont boldSystemFontOfSize:17];
    label1.text = @"下单完成";
    label1.textColor = kRGBColor(74, 74, 74);
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(tupianImageView.mas_bottom).mas_equalTo(10);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"请客户准备好身份证、行驶证，需记录车辆信息\n登记完成后客户即可到休息区休息";
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = kRGBColor(133, 133, 133);
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(28);
    }];
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    [self.view addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
}

-(void)queDingBtChick:(UIButton *)sender
{
    WritePersonalViewController *vc = [[WritePersonalViewController alloc] init];
    vc.ordercode = self.ordercode;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
