//
//  CPHFWeiHeaderView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/18.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobBoardDetailModel.h"

@interface CPHFWeiHeaderView : UIView
{
    UILabel *nameLabel;
    UIImageView   *jingJiImageView;
    UIImageView   *zhongYaoImageView;
    
    UILabel *statusLabel;
    UILabel *fuzeRenLabel;
    UILabel *m_daoQiLabel;
    
    UILabel *m_remainLabel;
    
    UIImageView *m_remainTupianImageView;
    UILabel *m_remainTupianLabel;
    
    
    UIView *m_pingJieView;
}

@property(nonatomic,strong)void (^nianJianTiXingBlcok)(void);//年检提醒

-(void)refreshData:(JobBoardDetailModel *)model;

-(void)refreshDataNianJian:(JobBoardDetailModel *)model withZhanHe:(BOOL)zhanHe;


@property(nonatomic,strong)JobBoardInfoModel *zhuModel;


@end
