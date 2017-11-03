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



@interface ScanViewController ()


@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setTopViewWithTitle:@"扫一扫" withBackButton:NO];
    m_mainTopTitle = @"扫一扫";
    self.view.backgroundColor = kNavBarColor;
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(1);
    }];
    
    
    UIButton *scanCheButton = [[UIButton alloc]init];
    [scanCheButton addTarget:self action:@selector(scanCheButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:scanCheButton];
    [scanCheButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
        make.bottom.mas_equalTo(line.mas_top).mas_equalTo(-10);
    }];
    
    UIImageView *scanCheImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"icon_saochepai")];
    [self.view addSubview:scanCheImageView];
    [scanCheImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(scanCheButton);
        make.top.mas_equalTo(scanCheButton);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(107);
    }];
    UILabel *scanCheLabel = [[UILabel alloc]init];
    scanCheLabel.textColor = [UIColor whiteColor];
    scanCheLabel.text = @"扫描车牌";
    [self.view addSubview:scanCheLabel];
    [scanCheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(scanCheButton);
        make.top.mas_equalTo(scanCheImageView.mas_bottom).mas_equalTo(15);
    }];
    [self.view bringSubviewToFront:scanCheButton];
    
    
    UIButton *scanButton = [[UIButton alloc]init];
    [self.view addSubview:scanButton];
    [scanButton addTarget:self action:@selector(scanButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
        make.top.mas_equalTo(line.mas_bottom).mas_equalTo(20);
    }];
    UIImageView *scanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"icon_saoerweima")];
    [self.view addSubview:scanImageView];
    [scanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(scanButton);
        make.top.mas_equalTo(scanButton);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(107);
    }];
    UILabel *scanLabel = [[UILabel alloc]init];
    scanLabel.textColor = [UIColor whiteColor];
    scanLabel.text = @"扫二维码";
    [self.view addSubview:scanLabel];
    [scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(scanButton);
        make.top.mas_equalTo(scanImageView.mas_bottom).mas_equalTo(15);
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
    QrCodeScanningViewController *vc = [[QrCodeScanningViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
