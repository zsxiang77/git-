//
//  ScanDrivingLicenseModel.h
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheNewWorkOrderModel.h"
#import "CarInfoModel.h"

@class ScanDrivingLicenseDataModel;

@interface ScanDrivingLicenseModel : NSObject
@property (nonatomic, strong) ScanDrivingLicenseDataModel *model;
///请求下来的历史vin
@property (nonatomic, copy) NSString *oldCarvin;
@end

@interface ScanDrivingLicenseDataModel : NSObject

- (void)buildModelWithScanDrivingLicenseDataModel:(XinShiZheng_carsModel *)model;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *car_body_color;
@property (nonatomic, copy) NSString *car_brand;
@property (nonatomic, copy) NSString *car_number;
///车辆类型 1 小型车 2大中型客车 3大型货车 9 其他
@property (nonatomic, assign) NSInteger cartype;
@property (nonatomic, copy) NSString *carvin;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *issue_date;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *register_date;
@property (nonatomic, copy) NSString *use_character;
///发动机号
@property (nonatomic, copy) NSString *engine_number;
@property (nonatomic, strong) NSArray<CarInfoDataAdaptCarsModel *> *adapt_cars;

@property (nonatomic, copy) NSString *imagesLocal;
@property (nonatomic, assign) BOOL isLocalImage;
@end
