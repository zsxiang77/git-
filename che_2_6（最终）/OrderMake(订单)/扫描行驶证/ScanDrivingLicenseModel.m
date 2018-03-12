//
//  ScanDrivingLicenseModel.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "ScanDrivingLicenseModel.h"

@implementation ScanDrivingLicenseModel

@end

@implementation ScanDrivingLicenseDataModel
- (void)buildModelWithScanDrivingLicenseDataModel:(XinShiZheng_carsModel *)model
{
    self.car_number = model.carno;
    self.engine_number = model.engine_number;
    self.model = model.carno;
    self.owner = model.owner;
    self.carvin = model.carvin;
    self.model = model.model;
    self.use_character = model.use_character;
    self.issue_date = model.issue_date;
    self.register_date = model.register_date;
    self.address = model.address;
    self.images = model.images;
    self.imagesLocal = model.imagesLocal;
    self.isLocalImage = YES;

}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"adapt_cars" : [CarInfoDataAdaptCarsModel class]};
}
@end

