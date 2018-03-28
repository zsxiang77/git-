//
//  CarCheckModel.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarCheckModel.h"

@interface CarCheckModel ()
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *icons;
@end

@implementation CarCheckModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _names = @[@"智能检测", @"外观检查",
                   @"车内检查", @"功能检查"];
        _icons = @[@"car_check_AIT", @"car_check_outward",
                   @"car_check_inside", @"car_check_function"];
    }
    return self;
}

- (void)buildDataSourceWithModel:(CarCheckDataModel *)model
{
    _model = model;
    _hasBrainpower = model.ait_switch;
    
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:_names.count];
    
    int index = _hasBrainpower ? 0 : 1;

    for (int i = index; i < 4; i++) {
        CarCheckCellModel *model = [[CarCheckCellModel alloc] init];
        model.name = _names[i];
        model.iconName = _icons[i];
        [datas addObject:model];
    }
    CarCheckCellModel *cm = datas.lastObject;
    cm.isHiddenLine = YES;
    _dataSource = [datas copy];
}

@end

@implementation CarCheckCellModel

@end

@implementation CarCheckDataModel

@end
