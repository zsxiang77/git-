//
//  AccessoriesViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"

@interface AccessoriesViewController : BaseViewController

@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)UITableView  *main_tabelView;
@property(nonatomic,strong)NSArray *chuanZhiArray;
@property(nonatomic,strong)NSMutableArray *tianJiaArray;

@end

@interface AccessoriesViewController (Net)
-(void)postrequest_methodList;


@end
