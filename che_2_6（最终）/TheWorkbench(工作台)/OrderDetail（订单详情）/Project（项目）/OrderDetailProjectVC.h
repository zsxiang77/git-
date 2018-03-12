//
//  OrderDetailProjectVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"
#import "PaiGongModel.h"
#import "OrderDetailProjectPGView.h"

@interface OrderDetailProjectVC : BaseViewController

@property(nonatomic,strong)OrderDetailProjectPGView  *orderDetailProjectPGView;

@property(nonatomic,strong)NSMutableArray *paiGongArray;
@property(nonatomic,strong)NSMutableArray *xuanZhongPaiGongArray;

@property(nonatomic,strong)NSArray *chuanZhiArray;
@property(nonatomic,strong)NSMutableArray *tianJiaArray;

@property(nonatomic,strong)UITableView  *main_tabelView;

@property(nonatomic,strong)NSString    *ordercode;


@end


@interface OrderDetailProjectVC (PaiG)
-(void)postrequest_methodList;

@end
