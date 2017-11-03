//
//  LicenseInformationVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "LicenseInformationVC.h"
#import "IDCardCameraViewController.h"

@interface LicenseInformationVC ()

@end

@implementation LicenseInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"车牌信息" withBackButton:YES];
    
    UILabel *titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 40)];
    titiLabel.font = [UIFont systemFontOfSize:14];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.backgroundColor = kRGBColor(230, 230, 230);
    titiLabel.text = @"1、填入行驶证信息";
    [self.view addSubview:titiLabel];
    
    UILabel *titiLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight+40, kWindowW, 40)];
    titiLabel2.font = [UIFont systemFontOfSize:14];
    titiLabel2.textAlignment = NSTextAlignmentCenter;
    titiLabel2.textColor = [UIColor grayColor];
    titiLabel2.text = @"为了方便记录信息请扫描行驶证";
    [self.view addSubview:titiLabel2];
    
    UIImageView *tuPianImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"driving_license_img.jpg")];
    [self.view addSubview:tuPianImageView];
    [tuPianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(titiLabel2.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(kWindowW-60);
    }];
    
    
    
    UIButton *saoMiaoZhengJianBt = [[UIButton alloc]init];
    [saoMiaoZhengJianBt addTarget:self action:@selector(saoMiaoZhengJianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [saoMiaoZhengJianBt setTitle:@"扫描行驶证" forState:(UIControlStateNormal)];
    [saoMiaoZhengJianBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    saoMiaoZhengJianBt.backgroundColor = kNavBarColor;
    [saoMiaoZhengJianBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [saoMiaoZhengJianBt.layer setCornerRadius:3];
    [self.view addSubview:saoMiaoZhengJianBt];
    [saoMiaoZhengJianBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(tuPianImageView.mas_bottom).mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
    
    
    UIButton *saoMiaoZhengJianBt2 = [[UIButton alloc]init];
    [saoMiaoZhengJianBt2 addTarget:self action:@selector(saoMiaoZhengJianBt2Chick:) forControlEvents:(UIControlEventTouchUpInside)];
    [saoMiaoZhengJianBt2 setTitle:@"填写行驶证信息" forState:(UIControlStateNormal)];
    [saoMiaoZhengJianBt2 setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [saoMiaoZhengJianBt2.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [saoMiaoZhengJianBt2.layer setCornerRadius:3];
    [saoMiaoZhengJianBt2.layer setBorderWidth:0.5];//设置边界的宽度
    //设置按钮的边界颜色
    [saoMiaoZhengJianBt2.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    [self.view addSubview:saoMiaoZhengJianBt2];
    [saoMiaoZhengJianBt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(saoMiaoZhengJianBt.mas_bottom).mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
}

-(void)saoMiaoZhengJianBtChick:(UIButton *)senser
{
    [self initCameraWithRecogOrientation:0];
}
-(void)saoMiaoZhengJianBt2Chick:(UIButton *)senser
{
    FillInformationViewController *vc = [[FillInformationViewController alloc]init];
    vc.zhuModel  = self.zhuModel;
    vc.chuanZhiDict = [[XinShiZheng_carsModel alloc]init];
    vc.zuiZhongModel = self.zuiZhongModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) initCameraWithRecogOrientation: (int)recogOrientation
{
    //IDCardCameraViewController适配了iPad、iPhone，支持程序旋转
    IDCardCameraViewController *cameraVC = [[IDCardCameraViewController alloc] init];
    cameraVC.zhuModel = self.zhuModel;
    cameraVC.recogType = 6;
    cameraVC.typeName = @"中国行驶证";
    cameraVC.recogOrientation = recogOrientation;
    cameraVC.zuiZhongModel = self.zuiZhongModel;
    [self.navigationController pushViewController:cameraVC animated:YES];
}

@end
