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

@interface ModelCarViewController : BaseViewController
@property(nonatomic,strong)Users_carsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)BaseViewController *superViewController;



@property(nonatomic,strong)NSMutableArray *zhuArray;

@property(nonatomic,strong)UITableView *main_tabelView;

@end


@interface ModelCarViewController (Net)
-(void)getReMenNetWork;

@end
