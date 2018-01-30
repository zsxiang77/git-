//
//  ConstructionPersonnelErVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"
#import "ConstructionPersonnelViewController.h"
#import "AITHTMLViewController.h"

@interface ConstructionPersonnelErVC : BaseViewController
{
    UIButton   *quanXuanBt;
}

@property(nonatomic,strong)UITableView *main_tableView;
@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *tiaoZhuanordercode;

@property(nonatomic,strong)NSArray *chuanRuArra;

@property(nonatomic,strong)BaseViewController *superViewController;

@end
