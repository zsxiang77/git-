//
//  AITDetectView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheDianZhangCommon.h"

@interface AITDetectView : UIView

@property(nonatomic,strong)UIImageView *xuanZhuanImageView;
@property(nonatomic,strong)UILabel *shiFouKeYongLabel;
@property(nonatomic,strong)UIButton *shouQiBt;
@property(nonatomic,strong)void (^buyAitBtChickBlock)(void);
@property(nonatomic,strong)void (^settingAitBtChickBlock)(void);

-(void)setYeMianYangShiWith:(BOOL)sender;
@end
