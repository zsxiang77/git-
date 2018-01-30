//
//  SalesStaffViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/29.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "AITHTMLViewController.h"

@interface SalesStaffViewController : BaseViewController

@property(nonatomic,strong)NSString  *chuanName;

@property(nonatomic,strong)UITableView *main_tableView;
@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *tiaoZhuanordercode;

@property(nonatomic,assign)NSInteger operLeiXin;
@property(nonatomic,strong)BaseViewController *superViewController;

@end
