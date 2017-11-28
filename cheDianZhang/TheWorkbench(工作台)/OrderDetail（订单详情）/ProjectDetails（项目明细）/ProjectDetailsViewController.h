//
//  ProjectDetailsViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailViewController.h"
#import "AITHTMLViewController.h"

@interface ProjectDetailsViewController : BaseViewController

@property(nonatomic,strong)NSMutableArray *chuanRuArray;
@property(nonatomic,strong)UITableView *main_tableView;

@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *tiaoZhuanordercode;

@property(nonatomic,strong)BaseViewController *suerViewController;


@end
