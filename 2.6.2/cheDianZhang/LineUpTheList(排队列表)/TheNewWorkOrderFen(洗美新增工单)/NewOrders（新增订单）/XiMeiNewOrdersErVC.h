//
//  XiMeiNewOrdersErVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "XiMeiNewOrdersModer.h"
#import "TheNewWorkOrderModel.h"
#import "XiMeiNewOrdersErCell1.h"
#import "XiMeiNewOrdersErCell2.h"
#import "XiMeiNewOrdersErCell3.h"
#import "XiMeiNewOrdersErCell4.h"
#import "XiMeiNewOrdersErModel.h"
#import "YYModel.h"
#import "XiMeiXinZengZuiZongModel.h"


@interface XiMeiNewOrdersErVC : BaseViewController

@property(nonatomic,strong)UITableView *main_tabelView;

@property(nonatomic,strong)XiMeiNewOrdersErModel *huoQuServiceData;

@property(nonatomic,strong)NSMutableArray *service_commodArray;


@property(nonatomic,strong)XiMeiNewOrdersModer *chuZhiModel;
@property(nonatomic,strong)Users_carsModel *zhuModel;

@property(nonatomic,strong)XiMeiXinZengZuiZongModel *zuiZongModel;

-(void)jiSuanZongEQian;


@end



@interface XiMeiNewOrdersErVC (Net)
-(void)postREQUEST_METHODWithService_id:(NSString *)service_id;
-(void)postREQUEST_METHODWithTiaoJiao;
@end
