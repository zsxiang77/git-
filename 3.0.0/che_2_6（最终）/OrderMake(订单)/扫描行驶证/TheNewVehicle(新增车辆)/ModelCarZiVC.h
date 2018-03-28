//
//  ModelCarZiVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "ErMenModel.h"
#import "TheNewWorkOrderModel.h"
#import "CarInfoModel.h"
#import "XiMeiXinZengZuiZongModel.h"

@interface ModelCarZiVC : BaseViewController
@property(nonatomic,strong)UITableView *main_tabelView;
@property(nonatomic,strong)ErMenModel *chuZhiModel;

@property(nonatomic,strong)XiMeiXinZengZuiZongModel *xiMeiZuiZhongModel;//洗美新增车辆


@property(nonatomic,strong)CarInfoDataAdaptCarsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)BaseViewController *superViewController;

@end
