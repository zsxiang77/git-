//
//  XiMeiNewOrdersErCell3.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiMeiNewOrdersErModel.h"
#import "NumberKeyboard.h"
#import "XiMeiNewOrdersErVC.h"

@interface XiMeiNewOrdersErCell3 : UITableViewCell<NumKeyboardDelegate>

@property(nonatomic,strong)UILabel *zuoLabel;
@property(nonatomic,strong)UILabel *youLabel;
@property(nonatomic,strong)UITextField *mainTextField;

@property(nonatomic,strong)Service_commods *model;

@property(nonatomic,strong)UIViewController *superViewColler;

@end
