//
//  WriteSaoMiaoView.h
//  cheDianZhang
//
//  Created by lcc on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WritePersonalInputTFView.h"

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface WriteSaoMiaoView : UIView

@property (nonatomic, strong) WritePersonalInputTFView *send_mobile_tf;
@property (nonatomic, strong) WritePersonalInputTFView *send_name_tf;
@property (nonatomic, strong) WritePersonalInputTFView *send_id_car_tf;

@property (nonatomic, strong) WritePersonalInputTFView *send_addr_tf;
@property (nonatomic, strong) WritePersonalInputTFView *send_sex_tf;
@property (nonatomic, strong) WritePersonalInputTFView *send_nation_tf;
@property (nonatomic, strong) WritePersonalInputTFView *send_birth_tf;

@property (nonatomic, strong) NSString *send_mobile;
@property (nonatomic, strong) NSString *send_name;
@property (nonatomic, strong) NSString *send_id_card;

@property (nonatomic, strong) NSString *send_addr;//地址
@property (nonatomic, strong) NSString *send_sex;//性别
@property (nonatomic, strong) NSString *send_nation;//名族
@property (nonatomic, strong) NSString *send_birth;//生日

@property (nonatomic, copy) void (^scanIDCard)(void);

@property (nonatomic, copy) void (^birth_tfChickBack)(void);
@property (nonatomic, copy) void (^sex_tfChickBack)(void);

@end
