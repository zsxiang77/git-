//
//  EnvironmentModel.m
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "EnvironmentModel.h"

@implementation EnvironmentModel
- (void)buildDataSourceWithModel:(EnvironmentDataModel *)model
{
    _model = model;
    
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:model.projects.count];
    for (EnvironmentProjectsModel *proModel in model.projects) {
        EnvironmentSectionModel *sectionModel = [[EnvironmentSectionModel alloc] initWithModel:proModel];
        [sections addObject:sectionModel];
    }
    _dataSource = [sections copy];
}
@end

@implementation EnvironmentSectionModel
- (instancetype)initWithModel:(EnvironmentProjectsModel *)model
{
    self = [super init];
    if (self) {
        
        _title = model.project;
        NSMutableArray *datas = [NSMutableArray arrayWithCapacity:model.list.count];
        for (EnvironmentProjectsListModel *listM in model.list) {
            EnvironmentCellModel *cellM = [[EnvironmentCellModel alloc] initWithModel:listM];
            [datas addObject:cellM];
        }
        
        EnvironmentCellModel *cellModel = datas.lastObject;
        cellModel.isHiddenLine = YES;
        
        _rows = [datas copy];
    }
    return self;
}
@end

@implementation EnvironmentCellModel

- (instancetype)initWithModel:(EnvironmentProjectsListModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        _title = model.item;
        _isIdleSpeed = [model.item isEqualToString:@"怠速"];
        
        UIColor *textColor = [UIColor colorWithHexString:@"858488"];
        if (model.value > model.limit) {
            _valueType = EnvironmentValueTypeUp;
            textColor = [UIColor colorWithHexString:@"001A00"];
        } else if (model.value < model.limit) {
            _valueType = EnvironmentValueTypeDown;
            textColor = [UIColor colorWithHexString:@"2A3F3F"];
        } else {
            _valueType = EnvironmentValueTypeEqual;
        }
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"限值：%lf 测量值：", model.limit]];
        str1.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        str1.color = [UIColor colorWithHexString:@"858488"];
        
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lf", model.value]];
        str2.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        str2.color = textColor;
        
        [str1 appendAttributedString:str2];
        
        _desc = [str1 copy];
    }
    return self;
}

@end


@implementation EnvironmentDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"projects" : [EnvironmentProjectsModel class]};
}
@end

@implementation EnvironmentProjectsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [EnvironmentProjectsListModel class]};
}
@end

@implementation EnvironmentProjectsListModel
@end
