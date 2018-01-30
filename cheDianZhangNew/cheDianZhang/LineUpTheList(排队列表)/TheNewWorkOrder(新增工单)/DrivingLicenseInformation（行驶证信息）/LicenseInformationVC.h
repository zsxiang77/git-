//
//  LicenseInformationVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "FillInformationViewController.h"
#import "Car_zongModel.h"

@interface LicenseInformationVC : BaseViewController

@property(nonatomic,strong)Users_carsModel *zhuModel;

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@end
