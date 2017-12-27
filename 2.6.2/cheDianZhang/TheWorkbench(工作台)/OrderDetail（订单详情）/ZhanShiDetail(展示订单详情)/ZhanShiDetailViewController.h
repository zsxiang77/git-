//
//  ZhanShiDetailViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiXiuZhanShiView.h"
#import "WeiXiuZhanShiModel.h"
#import "CarInformationViewController.h"
#import "AITProductInformationVC.h"
#import "OrderDetailModel.h"

@interface ZhanShiDetailViewController : BaseViewController
{
    BOOL        shiGongZhanHe;
    BOOL        zhiJianZhanHe;
    BOOL        pingJiaZhanHe;
    NSMutableArray *_xiangMuMingXiArrayCun;
    NSMutableArray *_peiJianMingXiArrayCun;
}
@property(nonatomic,strong)TheWorkModel  *chuanZhiModel;
@property(nonatomic,strong)WeiXiuZhanShiModel *zhuModel;
@property(nonatomic,strong)WeiXiuZhanShiView  *headerViwe;
@property(nonatomic,strong)UITableView *mainTableView;

@end


@interface ZhanShiDetailViewController (Net)
-(void)setrequest_methodwithOrdercodevarchar:(TheWorkModel *)model;
-(void)postpeiJianMingXiWithModel:(TheWorkModel *)model;
-(void)postrequest_methodMingXiWithModel:(TheWorkModel *)model;

@end
