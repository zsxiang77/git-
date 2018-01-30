//
//  CarYearViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheNewWorkOrderModel.h"
#import "TheNewWorkOrderVC.h"

@interface CarYearViewController : BaseViewController

@property(nonatomic,strong)UITableView *main_tabelView;
@property(nonatomic,strong)NSDictionary *chuZhiModel;

@property(nonatomic,strong)Users_carsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)BaseViewController *superViewController;

@end
