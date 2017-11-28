//
//  CarInformeTionCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheDianZhangCommon.h"
#import "TheNewWorkOrderModel.h"

@interface CarInformeTionCell : UITableViewCell

@property(nonatomic,strong)UIView *yingYView;

@property(nonatomic,strong)UIImageView *xuanZhongBt;

@property(nonatomic,strong)UILabel *carNumeberLabel;
@property(nonatomic,strong)UILabel *cheColorLabel;
@property(nonatomic,strong)UILabel *colorLabel;
@property(nonatomic,strong)UIButton *shanChuButton;


@property(nonatomic,strong)UIView *shangView;
@property(nonatomic,strong)UIView *xiaView;

@property(nonatomic,strong)Users_carsModel *chuLiModel;

@property(nonatomic,strong)void (^shanChuButtonBlock)(Users_carsModel *chuLiModel);
@property(nonatomic,strong)void (^tiaoZhuanAitBlock)(void);


@end
