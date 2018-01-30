//
//  XiMeiDetailHeaderView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "RCLabel.h"
#import "TheWorkModel.h"

@interface XiMeiDetailHeaderView : UIView

-(instancetype)initWithModel:(TheWorkModel *)chuanzhiModel;

@property(nonatomic,strong)UILabel *topCarNumberLa;

@property(nonatomic,strong)UIImageView *topMianImageView;
@property(nonatomic,strong)UILabel *topLeiXinLabel;
@property(nonatomic,strong)UILabel *topShuoMLabel;
@property(nonatomic,strong)UILabel *topStateLabel;
@property(nonatomic,strong)UIImageView *stateImageView;
@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UIButton *jieCheInformetionBt;

@property(nonatomic,strong)UIImageView *erWeiMaImageView;
@property(nonatomic,strong)UILabel *dingDanText;

@property(nonatomic,strong)UISwitch *suoDanSwitch;

@property(nonatomic,assign)CGFloat jiSuanHeight;
@property(nonatomic,strong)RCLabel *aitXianShiLabel;
@property(nonatomic,strong)UIImageView *aitBiaoZhiIm;
@property(nonatomic,strong)UILabel *aitNumberLabel;
@property(nonatomic,strong)UILabel *aitYouLabel;
@property(nonatomic,strong)UIButton *aitTiaoZhuanBt;


@property(nonatomic,strong)UIScrollView *zuoYouScrollView;

@property(nonatomic,strong)void (^erWeiMaButtonBlock)(void);
@property(nonatomic,strong)void (^chaKaButtonBlock)(void);
@property(nonatomic,strong)void (^suoDanSwitchBlock)(UISwitch *sender);

-(void)sheZHiBuJuWithXiangMu:(NSArray *)subjects withHaoCaiArray:(NSArray *)comm_imgs withSouDan:(BOOL)suoDan;

@end
