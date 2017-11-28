//
//  NewOrderDetailTiJiaoView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "OrderDetailViewController.h"
#import "NumberKeyboard.h"

@interface NewOrderDetailTiJiaoView : UIView<UITextFieldDelegate,NumKeyboardDelegate>
@property(nonatomic,strong)NSString *zhiBaoStr;

@property(nonatomic,strong)UILabel *jinChangLabei;
@property(nonatomic,strong)UITextField *chuChangTextField;
@property(nonatomic,strong)BaseViewController *superViewController;


@end
