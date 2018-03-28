//
//  VINNewAlertView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VINNewAlertView : UIView

@property(nonatomic,strong)void (^quXiaobtBlock)(void);
@property(nonatomic,strong)void (^queRenBtBlock)(void);

@property(nonatomic,strong)UIButton *quXiaobt;
@property(nonatomic,strong)UIButton *queRenBt;
@property(nonatomic,strong)UILabel *quXiaoLabel;
@property(nonatomic,strong)UILabel *maLabel;
@property(nonatomic,strong)UILabel *maLabel2;
@property(nonatomic,strong)UILabel *maLabel3;

-(instancetype)initWithTitleWithmessage:(NSString *)manage cancelButtonTitle:(NSString *)title otherButtonTitle:(NSString *)titleEr;

-(void)show;
-(void)dissMIssView;
-(void)daoJiShi;

@end
