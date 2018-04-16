//
//  PopInsuranceListModel.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "PopInsuranceListModel.h"

@implementation PopInsuranceListModel
- (void)buildDataSourceWithModels:(NSArray<PopInsuranceDataModel *> *)models
{
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:models.count];
    for (PopInsuranceDataModel *model in models) {
        PopInsuranceListCellModel *cellM = [[PopInsuranceListCellModel alloc] initWithModel:model];
        [datas addObject:cellM];
    }
    
    PopInsuranceListCellModel *customModel = [[PopInsuranceListCellModel alloc] init];
    customModel.isCustom = YES;
    [datas addObject:customModel];
    
    _dataSource = [datas copy];
}
@end

@implementation PopInsuranceListCellModel : NSObject
- (instancetype)initWithModel:(PopInsuranceDataModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        _iconURL = [NSURL URLWithString:model.images];
        _name = model.name;
    }
    return self;
}
@end

@implementation PopInsuranceDataModel : NSObject

@end
