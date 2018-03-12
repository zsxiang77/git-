//
//  AITCheckModel.m
//  测试
//
//  Created by sykj on 2018/1/31.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "AITCheckModel.h"

@implementation AITCheckModel
- (void)buildDataSourceWithModel:(CarCheckDataModel *)model
{
    _model = model;
    
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:model.ait_list.count];
    for (NSString *title in model.ait_list) {
        AITCheckCellModel *cellM = [[AITCheckCellModel alloc] init];
        cellM.title = title;
        cellM.isSelected = NO;
        [datas addObject:cellM];
    }
    AITCheckCellModel *firstCM = datas.firstObject;
    firstCM.isSelected = YES;
    
    AITCheckCellModel *lastCM = datas.lastObject;
    lastCM.isHiddenLine = YES;
    
    _dataSource = [datas copy];
}
@end


@implementation AITCheckCellModel

@end
