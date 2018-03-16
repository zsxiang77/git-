//
//  LCBottomView.h
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "kehuXuQiuViewController.h"

@interface LCBottomView : UIView
@property (nonatomic, strong) void (^sendMessage)(id model);
@property (nonatomic, strong) void (^nextStep)(void);

@property(nonatomic,strong)UIImageView *fuCengImageView;

@property(nonatomic,strong)NSString *yuYingZhuanHStr;

@property(nonatomic,strong)kehuXuQiuViewController *superViewController;

- (void)hidenKeyboard;
@end
