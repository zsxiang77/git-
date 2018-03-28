//
//  MaintenanceProjecPartstCell.h
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MaintenanceProjectPartstModel.h"
@interface MaintenanceProjecPartstCell : BaseTableViewCell
@property (nonatomic, strong) void (^changePartst)(MaintenanceProjectPartstModel *partsModel);
@end
