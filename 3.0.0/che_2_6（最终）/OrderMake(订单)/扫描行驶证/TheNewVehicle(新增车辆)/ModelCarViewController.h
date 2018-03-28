//
//  ModelCarViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "ModelCarReMenCell.h"
#import "ModelCarJiBenCell.h"
#import "UIImageView+WebCache.h"
#import "ModelCarZiVC.h"
#import "TheNewWorkOrderModel.h"
#import "XiMeiXinZengZuiZongModel.h"
#import "CarInfoModel.h"

@interface ModelCarViewController : BaseViewController

@property(nonatomic,strong)XiMeiXinZengZuiZongModel *xiMeiZuiZhongModel;//洗美新增车辆

@property(nonatomic,strong)CarInfoDataAdaptCarsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)BaseViewController *superViewController;
@property(nonatomic,strong)NSArray  *huanCunArray;



@property(nonatomic,strong)NSMutableArray *zhuArray;

@property(nonatomic,strong)UITableView *main_tabelView;
#pragma mark - 缓存
- (void)saveuserCheXXi:(NSArray *)array;

@end


@interface ModelCarViewController (Net)
-(void)getReMenNetWork;

-(void)postcars_brand;

@end
