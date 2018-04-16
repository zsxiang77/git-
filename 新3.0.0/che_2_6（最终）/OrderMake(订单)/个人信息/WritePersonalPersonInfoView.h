//
//  WritePersonalPersonInfoView.h
//  cheDianZhang
//
//  Created by sykj on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WritePersonalViewController.h"
#import "WriteSaoMiaoView.h"
#import "WritePersonalInputTFView.h"

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface WritePersonalPersonInfoView : UIView

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *store_alias;
@property (nonatomic, strong) NSString *id_car;

@property (nonatomic, strong) NSString *addr;//地址
@property (nonatomic, strong) NSString *sex;//性别
@property (nonatomic, strong) NSString *nation;//名族
@property (nonatomic, strong) NSString *birth;//生日

@property (nonatomic, strong) WritePersonalInputTFView *mobile_tf;
@property (nonatomic, strong) WritePersonalInputTFView *store_alias_tf;
@property (nonatomic, strong) WritePersonalInputTFView *id_car_tf;

@property (nonatomic, strong) WritePersonalInputTFView *addr_tf;
@property (nonatomic, strong) WritePersonalInputTFView *sex_tf;
@property (nonatomic, strong) WritePersonalInputTFView *nation_tf;
@property (nonatomic, strong) WritePersonalInputTFView *birth_tf;


@property (nonatomic, strong) WriteSaoMiaoView *sendInfoView;
@property (nonatomic, weak) WritePersonalViewController *viewController;
@property (nonatomic, copy) void (^scanIDCard)(void);

@property (nonatomic, copy) void (^userInfoChangeCallBack)(void);

@property (nonatomic, copy) void (^birth_tfChickBack)(void);
@property (nonatomic, copy) void (^sex_tfChickBack)(void);

//@property(nonatomic, copy) void (^textFieldValueChangeCallBack)(UITextField *textField);

@end
