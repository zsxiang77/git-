//
//  XiMeiNewOrdersErCell4.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiMeiNewOrdersErModel.h"

@interface XiMeiNewOrdersErCell4 : UITableViewCell

@property(nonatomic,strong)UILabel *zuoLabel;

@property(nonatomic,strong)UIButton *jiaButton;
@property(nonatomic,strong)UIButton *jianButton;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)Service_commods *model;

@property(nonatomic,strong)void (^shuLiangXiuGai)(Service_commods *model);
@property(nonatomic,strong)void (^jiaHuoJianDianJiBlock)(void);

@end
