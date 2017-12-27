//
//  AITProductInformationVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/9.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITProductInformationVC.h"
#import "SettingAITSerialNumberVC.h"
#import "BuyAITProductsViewController.h"

@interface AITProductInformationVC ()

@end

@implementation AITProductInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"AIT产品信息" withBackButton:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"AIT产品插入汽车可直接检测";
    label1.textColor = UIColorFromRGBA(0x337bf3, 1);
    label1.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(kNavBarHeight+27);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"还没有AIT产品？点击购买";
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(18);
    }];
    
    UIImageView *jianTouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"06_arrow")];
    [self.view addSubview:jianTouImageView];
    [jianTouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(label2.mas_bottom).mas_equalTo(9);
        make.width.mas_equalTo(25/2);
        make.height.mas_equalTo(28/2);
    }];
    
    UIView *zhongView = [[UIView alloc]init];
    zhongView.backgroundColor = [UIColor whiteColor];
    zhongView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    zhongView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    zhongView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    zhongView.layer.shadowRadius = 4;//阴影半径，默认3
    [zhongView.layer setCornerRadius:4];
    [self.view addSubview:zhongView];
    [zhongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(jianTouImageView.mas_bottom).mas_equalTo(37/2);
        make.height.mas_equalTo(148);
    }];
    
    UILabel *labelZhong = [[UILabel alloc]init];
    labelZhong.text = @"购买AIT产品";
    labelZhong.textColor = UIColorFromRGBA(0xf5a623, 1);
    labelZhong.font = [UIFont systemFontOfSize:14];
    [zhongView addSubview:labelZhong];
    [labelZhong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(zhongView);
        make.bottom.mas_equalTo(-(103)/2);
    }];
    
    UIImageView *gouMaiImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"06_buy")];
    [zhongView addSubview:gouMaiImageView];
    [gouMaiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(zhongView);
        make.bottom.mas_equalTo(labelZhong.mas_top).mas_equalTo(-10);
        make.width.mas_equalTo(55/2);
        make.height.mas_equalTo(62/2);
    }];
    
    UIButton *gouMaiBt = [[UIButton alloc]init];
    [gouMaiBt addTarget:self action:@selector(gouMaiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [zhongView addSubview:gouMaiBt];
    [gouMaiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"已有AIT产品，未设置序列号";
    label3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(zhongView.mas_bottom).mas_equalTo(55/2);
    }];
    
    UIButton *settingBt = [[UIButton alloc]init];
    settingBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [settingBt.layer setMasksToBounds:YES];
    [settingBt.layer setBorderWidth:1];
    [settingBt.layer setCornerRadius:3];
    [settingBt.layer setBorderColor:UIColorFromRGBA(0x00d383, 1).CGColor];
    [settingBt setTitleColor:UIColorFromRGBA(0x00d383, 1) forState:(UIControlStateNormal)];
    [settingBt setTitle:@"点击设置序列号" forState:(UIControlStateNormal)];
    [settingBt addTarget:self action:@selector(settingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:settingBt];
    [settingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(label3.mas_bottom).mas_equalTo(15);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(31);
    }];
}

-(void)settingBtChick:(UIButton *)sender
{
    SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gouMaiBtChick:(UIButton *)sender
{
    
    BuyAITProductsViewController *vc = [[BuyAITProductsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
