//
//  ScanViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ScanViewController.h"
#import "QrCodeScanningViewController.h"
#import "PlateIDCameraViewController.h"
#import "WorkOrderTypeVC.h"
#import "NewVehicleVC.h"



@interface ScanViewController ()


@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setTopViewWithTitle:@"扫一扫" withBackButton:NO];
    m_mainTopTitle = @"扫一扫";
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"saoYiSao_back.jpg")];
    backImageView.frame = CGRectMake(0, 0, kWindowW, kWindowH-[self getTabBarHeight]);
    [self.view addSubview:backImageView];
    
    UIView *dingWeiView = [[UIView alloc]init];
    [self.view addSubview:dingWeiView];
    [dingWeiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(backImageView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(50);
    }];
    
    
    UIView *scanCheView = [[UIView alloc]init];
    [self.view addSubview:scanCheView];
    [scanCheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kWindowW*0.6);
        make.bottom.mas_equalTo(dingWeiView.mas_top).mas_equalTo(-10);
        make.centerX.mas_equalTo(self.view);
    }];
    UIButton *scanCheButton = [[UIButton alloc]init];
    [scanCheButton addTarget:self action:@selector(scanCheButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [scanCheButton setBackgroundImage:DJImageNamed(@"scan_chePai") forState:(UIControlStateNormal)];
    [scanCheView addSubview:scanCheButton];
    [scanCheButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [scanCheView bringSubviewToFront:scanCheButton];
    
    
//    =================
    UIView *addGongDanView = [[UIView alloc]init];
    [self.view addSubview:addGongDanView];
    [addGongDanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kWindowW*0.6);
        make.top.mas_equalTo(dingWeiView.mas_bottom).mas_equalTo(10);
        make.centerX.mas_equalTo(self.view);
    }];

    UIButton *scanButton = [[UIButton alloc]init];
    [addGongDanView addSubview:scanButton];
    [scanButton addTarget:self action:@selector(scanButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [scanButton setBackgroundImage:DJImageNamed(@"scan_kaiDan") forState:(UIControlStateNormal)];
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.view bringSubviewToFront:scanButton];
    
}
-(void)scanCheButtonChick:(UIButton *)sender
{
    PlateIDCameraViewController *vc = [[PlateIDCameraViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)scanButtonChick:(UIButton *)sender
{
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/order/channels",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            NewVehicleVC *vc = [[NewVehicleVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.chuanZhiArray = KISDictionaryHaveKey(adData, @"channels");
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
    
//    QrCodeScanningViewController *vc = [[QrCodeScanningViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
