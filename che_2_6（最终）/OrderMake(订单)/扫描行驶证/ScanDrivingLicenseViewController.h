//
//  ScanDrivingLicenseViewController.h
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//  扫描行驶证

#import "BaseViewController.h"
#import "TheNewWorkOrderModel.h"
#import "ScanDrivingView.h"

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@interface ScanDrivingLicenseViewController : BaseViewController

@property(nonatomic,strong)UITextField *chePaiTextField;

@property (nonatomic, copy) NSString *ordercode;
@property (nonatomic, copy) ScanDrivingView *scanDrivingView;//车牌不符合提示View


@end
