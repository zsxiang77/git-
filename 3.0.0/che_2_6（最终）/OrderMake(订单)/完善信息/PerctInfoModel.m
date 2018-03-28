//
//  PerctInfoModel.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "PerctInfoModel.h"

@implementation PerctInfoModel

- (void)buildDataSourceWithModel:(PerctInfoDataModel *)model
{
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:model.schedule.count];
    for (PerctInfoDataScheduleModel *schModel in model.schedule) {
        PerctInfoCellModel *cellM = [[PerctInfoCellModel alloc] initWithModel:schModel];
        [datas addObject:cellM];
    }
//    PerctInfoCellModel *cm = datas.lastObject;
//    cm.isHiddenLine = YES;
    
    _dataSource = [datas copy];
    
    _progress = model.inspect_percent / 100.f;
    _isNoUserID = model.user_id < 1;
}

@end


@implementation PerctInfoCellModel
- (instancetype)initWithModel:(PerctInfoDataScheduleModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        _iconName = [NSString stringWithFormat:@"info_%@",model.key];
        _title = model.name;
        _perct = @"已完善";
        _number = [NSString stringWithFormat:@"%ld%%", model.percent];
        if (model.percent > 50) {
            _numberColor = [UIColor colorWithHexString:@"62AC0D"];
        }
        else if (model.percent < 50) {
            _numberColor = [UIColor colorWithHexString:@"FF383D"];
        }
        else {
            _numberColor = [UIColor colorWithHexString:@"E38D00"];
        }
    }
    return self;
}

@end

@implementation PerctInfoDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"schedule" : [PerctInfoDataScheduleModel class]};
}
@end
@implementation PerctInfoDataScheduleModel
@end
