//
//  RepairSecondModel.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "RepairSecondModel.h"

@implementation RepairSecondModel
- (void)buildDataSourceWithModel:(RepairSecondDataModel *)model
{
    _model = model;
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:model.list.count];
    for (RepairSecondDataListModel *listModel in model.list) {
        RepairSecondCellModel *cellM = [[RepairSecondCellModel alloc] initWithModel:listModel];
        [datas addObject:cellM];
    }
    
    RepairSecondCellModel *lastM = datas.lastObject;
    lastM.isHiddenLine = YES;
    
    _dataSource = [datas copy];
}

@end

@implementation RepairSecondCellModel : NSObject
- (instancetype)initWithModel:(RepairSecondDataListModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        _title = model.name;
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"工时费："];
        str1.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        str1.color = [UIColor colorWithHexString:@"858488"];
        
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", model.fee]];
        str2.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        str2.color = [UIColor redColor];
        
        NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"    工时：%@", model.hour]];
        str3.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        str3.color = [UIColor colorWithHexString:@"858488"];
        
        [str1 appendAttributedString:str2];
        [str1 appendAttributedString:str3];
        
        _desc = [str1 copy];
    }
    return self;
}
@end


@implementation RepairSecondDataModel : NSObject
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [RepairSecondDataListModel class]};
}
@end

@implementation RepairSecondDataListModel : NSObject

@end
