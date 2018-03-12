//
//  SuccessfulOrderViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "SuccessfulOrderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "AITDetectView.h"
#import "AITIntroduceViewController.h"
#import "SettingAITSerialNumberVC.h"
#import "UIImage+Video.h"

@interface SuccessfulOrderViewController ()

@end

@implementation SuccessfulOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订单成功" withBackButton:NO];

    
    UIView *erweiView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+10, kWindowW, 150)];
    erweiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:erweiView];
    
    
    UIImageView *wechatImageView = [[UIImageView alloc] init];
    wechatImageView.image = [UIImage qrCodeImageWithContent:KISDictionaryHaveKey(self.chuZhiDict, @"query_url") codeImageSize:130 red:0 green:0.658 blue:1];//重绘二维码,使其显示清晰
    [erweiView addSubview:wechatImageView];
    [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(erweiView);
        make.height.with.mas_equalTo(130);
    }];
    
    UIButton *fanHuiBt = [[UIButton alloc]init];
    [fanHuiBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [fanHuiBt.layer setCornerRadius:3];
    fanHuiBt.backgroundColor = kZhuTiColor;
    [fanHuiBt setTitle:@"返回工作台" forState:(UIControlStateNormal)];
    [fanHuiBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [fanHuiBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:fanHuiBt];
    [fanHuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(erweiView.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    
    UIButton *daYingBt = [[UIButton alloc]init];
    daYingBt.hidden = YES;
    [daYingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [daYingBt.layer setCornerRadius:3];
    daYingBt.backgroundColor = kZhuTiColor;
    [daYingBt setTitle:@"打印二维码" forState:(UIControlStateNormal)];
    [daYingBt addTarget:self action:@selector(daYingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [daYingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:daYingBt];
    [daYingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    
    
    if ([KISDictionaryHaveKey(self.chuZhiDict, @"ait_switch") boolValue] == YES) {
        AITDetectView *aITDetectView = [[AITDetectView alloc]initWithFrame:CGRectMake(0, kWindowH-190, kWindowW, 190)];
        [self.view addSubview:aITDetectView];
        [self.view bringSubviewToFront:aITDetectView];
        [aITDetectView setYeMianYangShiWith:[KISDictionaryHaveKey(self.chuZhiDict, @"is_ait") boolValue]];
//        [aITDetectView setYeMianYangShiWith:NO];
        kWeakSelf(weakSelf)
        aITDetectView.buyAitBtChickBlock = ^{
            AITIntroduceViewController *vc = [[AITIntroduceViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        aITDetectView.settingAitBtChickBlock = ^{
            SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)queDingBtChick:(UIButton *)sender
{
    
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.navigationController popToRootViewControllerAnimated:NO];
    [delegate.tabBarController setSelectedIndex:0];
//    delegate.tabBarController.hidesBottomBarWhenPushed = NO;
//    [(UINavigationController*)self.tabBarController.selectedViewController popToViewController:[[(UINavigationController*)self.tabBarController.selectedViewController viewControllers] objectAtIndex:index-2] animated:YES];
//
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 蓝牙打印
-(void)daYingBtChick:(UIButton *)sender
{
}


@end
