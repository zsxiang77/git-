//
//  WeiXiuZhanShiView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheWorkModel.h"
#import "WeiXiuZhanShiModel.h"
#import "UIImageView+WebCache.h"

@interface WeiXiuZhanShiView : UIView
@property(nonatomic,strong)UILabel *topCarNumberLa;
@property(nonatomic,strong)UILabel *topStateLa;
@property(nonatomic,strong)UILabel *timeLa;
@property(nonatomic,strong)UILabel *topShuoMLabel;
@property(nonatomic,strong)UILabel *topStateLabel;
@property(nonatomic,strong)UILabel *aitLabel;

@property(nonatomic,strong)UIImageView *topMianImageView;
@property(nonatomic,strong)UIImageView *stateImageView;
@property(nonatomic,strong)UIImageView *aitImageView;



-(instancetype)initWithModel:(TheWorkModel *)chuanzhiModel withWeiXiuZhanShiModel:(WeiXiuZhanShiModel *)mdeo;

@end
