//
//  AccessoryEquipmentVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "AccessoryEquipmentModel.h"


@interface AccessoryEquipmentVC : BaseViewController
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSString *chuaOrdercode;

@property(nonatomic,assign)BOOL  shiFouFanHui;

@end
