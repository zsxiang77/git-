//
//  OrderDetailHeaderView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
#import "UIImageView+WebCache.h"
#import "OrderDetailYuanView.h"

@interface OrderDetailHeaderView : UIView
{
    UILabel *dingDanHaoLabel;
    UILabel *dateLabel;
    UILabel *chePaiLabel;
    UILabel *leiXieLabel;
    UIImageView *zhuangTaiImageView;
    UILabel *zhuangTaiLabel;
    
    UIImageView *cheImageView;
    UILabel     *cheLeiXLabel;
    UILabel *songNameLabel;
    UILabel *vinLabel;
    
    UIView *zuo3View;//环形View
    
    OrderDetailYuanView *banYuanView;
    
    UILabel *jinduLabel;
//    ait
    UIButton  *aitButton;
    UIImageView *aitImageView;
    UILabel *aitLabel;
    UIImageView *aitDianJiImageView;
    
    UIImageView *tuiJianImageView;
    UILabel *tuiJianLabel;
    
    
}

-(void)refreshData:(OrderDetailModel *)model;

@property(nonatomic,strong)UIView *view5;

@property(nonatomic,strong)void (^tuijianXMChickBlcok)(void);
@property(nonatomic,strong)void (^aitTiaoZhuanBlcok)(void);
@property(nonatomic,strong)void (^aitjieShaoBtChickBlock)(void);

@property(nonatomic,strong)void (^wanShanXXiChcickBlock)(void);

@property(nonatomic,strong)UILabel *heJiLabel;

@end
