//
//  CarYearViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheNewWorkOrderModel.h"
#import "CarInfoModel.h"
#import "XiMeiXinZengZuiZongModel.h"

@interface CarYearViewController : BaseViewController

@property(nonatomic,strong)XiMeiXinZengZuiZongModel *xiMeiZuiZhongModel;//洗美新增车辆

@property(nonatomic,strong)UITableView *main_tabelView;
@property(nonatomic,strong)NSDictionary *chuZhiModel;

@property(nonatomic,strong)CarInfoDataAdaptCarsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)BaseViewController *superViewController;

@end
