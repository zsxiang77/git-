//
//  OrderDetailHeaderView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheWorkModel.h"

@interface OrderDetailHeaderView : UIView
-(instancetype)initWithModel:(TheWorkModel *)chuanzhiModel;

@property(nonatomic,strong)UILabel *topCarNumberLa;

@property(nonatomic,strong)UIImageView *topMianImageView;
@property(nonatomic,strong)UILabel *topLeiXinLabel;
@property(nonatomic,strong)UILabel *topShuoMLabel;
@property(nonatomic,strong)UILabel *topStateLabel;
@property(nonatomic,strong)UIImageView *stateImageView;
@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UIImageView *erWeiMaImageView;
@property(nonatomic,strong)UILabel *dingDanText;

@property(nonatomic,strong)UISwitch *suoDanSwitch;

@property(nonatomic,strong)UILabel *weiXiuFAnLabel;

@property(nonatomic,strong)void (^erWeiMaButtonBlock)(void);
@property(nonatomic,strong)void (^jieCheInformetionBtBlock)(NSInteger tag);

@end
