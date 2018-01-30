//
//  CarInspectionViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "CarInspectionModel.h"
#import "AccessoryEquipmentModel.h"
#import "AccessoryEquipmentVC.h"
#import "Car_zongModel.h"


@interface CarInspectionViewController : BaseViewController


@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@end
