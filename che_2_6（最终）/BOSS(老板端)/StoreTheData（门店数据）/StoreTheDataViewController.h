//
//  StoreTheDataViewController.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "UMMobClick/MobClick.h"

@interface StoreTheDataViewController : BOSSBaseViewController

@property(nonatomic,strong)UITableView * renWuTableView;
@property(nonatomic,strong)UITableView * renYuanTableView;//人员
@property(nonatomic,strong)UITableView * peiJianTableView;//配件
@property(nonatomic,strong)UITableView * shouRuTableView;//收入
@end
