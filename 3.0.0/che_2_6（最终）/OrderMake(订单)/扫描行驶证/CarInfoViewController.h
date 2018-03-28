//
//  CarInfoViewController.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//  扫描行驶证, 选择车辆类型

#import "BaseViewController.h"
#import "ScanDrivingLicenseModel.h"
#import "CarInfoModel.h"

@interface CarInfoViewController : BaseViewController
@property (nonatomic, strong) ScanDrivingLicenseDataModel *licenseDataModel;
@property (nonatomic, copy) NSString *vin;
@property (nonatomic, copy) NSString *ordercode;
@property (nonatomic, assign) BOOL isNeedRequestVinData;

- (void)sendCarInfoWithModel:(CarInfoDataAdaptCarsModel *)model;
@end
