//
//  MaintenanceProjecPartstBackCell.h
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "MaintenanceProjectPartstModel.h"
@interface MaintenanceProjecPartstBackCell : BaseTableViewCell
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) void (^changePartst)(MaintenanceProjectPartstModel *partsModel, NSArray *partsArr);;
@end
