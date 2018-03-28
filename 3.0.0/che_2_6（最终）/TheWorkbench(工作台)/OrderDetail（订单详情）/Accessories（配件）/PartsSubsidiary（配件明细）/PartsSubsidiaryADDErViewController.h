//
//  PartsSubsidiaryADDErViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "MJChiBaoZiHeader.h"
#import "OrderDetailModel.h"
#import "PartsSubsidiaryADDErCell.h"
#import "AccessoriesViewController.h"
#import "MaintenanceProjectPartstModel.h"

@interface PartsSubsidiaryADDErViewController : BaseViewController

@property(nonatomic,strong)BaseViewController *suerViewController;
@property(nonatomic,strong)MaintenanceProjectPartstModel *chuanZhiPartModel;

@property(nonatomic,strong)void (^changePartst)(OrderDetailPartsModel *model,NSString *chuanZhiClassid);

@property(nonatomic,strong)NSDictionary *chuanRumodel;

@property(nonatomic,strong)NSString   *chuanZhiClassid;

@property(nonatomic,assign)NSInteger      pageIndex;

@end
