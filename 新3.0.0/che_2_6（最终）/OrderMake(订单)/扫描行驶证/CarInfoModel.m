//
//  CarInfoModel.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarInfoModel.h"

@implementation CarInfoModel
- (void)buildDataSourceWithModel:(CarInfoDataModel *)model
{
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:model.adapt_cars.count];
    for (CarInfoDataAdaptCarsModel *cars in model.adapt_cars) {
        CarInfoCellModel *cellM = [[CarInfoCellModel alloc] initWithModel:cars];
        [datas addObject:cellM];
    }
    CarInfoCellModel *lastCM = datas.lastObject;
    lastCM.isHiddenLine = YES;
    
    _dataSource = [datas copy];
}
@end

@implementation CarInfoCellModel : NSObject
- (instancetype)initWithModel:(CarInfoDataAdaptCarsModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        _title = [NSString stringWithFormat:@"%@ %@ %@", model.brand, model.type, model.spec];
    }
    return self;
}
@end

@implementation CarInfoDataModel : NSObject
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"adapt_cars" : [CarInfoDataAdaptCarsModel class]};
}
@end

@implementation CarInfoDataAdaptCarsModel : NSObject

@end
