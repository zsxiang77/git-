//
//  StoreRenYuanDeileVC.h
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "StoreRenyuanModel.h"
#import "StoreDetliModel.h"
#import "StoreCellHeaderView.h"
@interface StoreRenYuanDeileVC : BOSSBaseViewController
@property(nonatomic,strong)listModel * chaunzhiStr;
@property(nonatomic,strong)NSString * yearStrzhi;
@property(nonatomic,strong)NSString * monthStrzhi;
@property(nonatomic,strong)StoreDetliModel * chaunzhiModel;
@property(nonatomic,strong)UITableView * mainTable;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong) StoreCellHeaderView * headerview;
@end
