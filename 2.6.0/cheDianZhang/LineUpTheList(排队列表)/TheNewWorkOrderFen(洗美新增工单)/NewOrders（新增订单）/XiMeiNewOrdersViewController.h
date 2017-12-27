//
//  XiMeiNewOrdersViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheNewWorkOrderModel.h"
#import "XiMeiXinZengZuiZongModel.h"


@interface XiMeiNewOrdersViewController : BaseViewController


@property(nonatomic,strong)XiMeiXinZengZuiZongModel *zuiZongModel;
@property(nonatomic,strong)Users_carsModel *zhuModel;

@end
