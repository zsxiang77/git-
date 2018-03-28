//
//  CarInspectionErVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "CarInspectionModel.h"

@interface CarInspectionErVC : BaseViewController

@property(nonatomic,strong)CarInspectionModel *chuRuMoel;

@property(nonatomic,strong)void (^tianJianWenTiChick)(CarInspectionModel *model);


@end
