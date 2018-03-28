//
//  CarInfoModel.h
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarInfoDataModel, CarInfoDataAdaptCarsModel;

@interface CarInfoModel : NSObject
- (void)buildDataSourceWithModel:(CarInfoDataModel *)model;
@property (nonatomic, strong) CarInfoDataModel *model;

@property (nonatomic, strong) NSArray *dataSource;
@end

@interface CarInfoCellModel : NSObject
- (instancetype)initWithModel:(CarInfoDataAdaptCarsModel *)model;
@property (nonatomic, strong) CarInfoDataAdaptCarsModel *model;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isHiddenLine;
@end

@interface CarInfoDataModel : NSObject
@property (nonatomic, strong) NSArray<CarInfoDataAdaptCarsModel *> *adapt_cars;
@end

@interface CarInfoDataAdaptCarsModel : NSObject
@property (nonatomic, copy) NSString *spec;
@property (nonatomic, copy) NSString *spec_id;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *brand_img;
@end
