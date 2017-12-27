//
//  PartsSubsidiaryViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailViewController.h"
#import "PartsSubsidiaryCell.h"
#import "PartsSubsidiaryADDViewController.h"

@interface PartsSubsidiaryViewController : BaseViewController

@property(nonatomic,strong)NSMutableArray *chuanRuArray;
@property(nonatomic,strong)UITableView *main_tableView;

@property(nonatomic,strong)NSString *ordercode;

@property(nonatomic,strong)BaseViewController *suerViewController;

@property(nonatomic,strong)UIButton *quanXuanBt;

@end
