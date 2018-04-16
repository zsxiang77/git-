//
//  OrderDetailViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheWorkModel.h"
#import "OrderDetailHeaderView.h"
#import "OrderDetailModel.h"
#import "AITHTMLViewController.h"
#import "MaintenanceProjectViewController.h"

@interface OrderDetailViewController : BaseViewController

@property(nonatomic,strong)UITableView  *main_tabelView;
@property(nonatomic,strong)OrderDetailHeaderView *tableHeaderView;
@property(nonatomic,strong)OrderDetailModel  *mainData;
@property(nonatomic,strong)TheWorkModel  *chuanZhiModel;

@property(nonatomic,strong)NSMutableArray *mainDataArray;

@end

@interface OrderDetailViewController (Net)
-(void)postorder_basicwithShuaXin:(BOOL)shuaX;

//计算总额
-(CGFloat)jiSuanZongE;
//项目总额
-(CGFloat)jiSuanSubjectsZongE;
//配件总额
-(CGFloat)jiSuanPartsZongE;
//洗美项目总额
-(CGFloat)jiSuanServicesZongE;
//洗美配件总额
-(CGFloat)jiSuanCommodsZongE;

@end
