//
//  XiMeiXinZengZuiZongModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiXinZengZuiZongModel.h"

@implementation XiMeiXinZengZuiZongModel

-(instancetype)init
{
    if (self = [super init]) {
        self.shiFoNiMing = NO;
        self.mobile = @"";
        self.realname = @"";
        self.service_name = @"";
        self.service_fee = @"";
        self.cars_detail = @"";
        self.user_id = @"";
        self.spec_id = @"";
        self.targetid = @"";
        self.car_number = @"";
        self.hour = @"";
        self.commod_price = @"";
        self.commod_id = @"";
        self.count = @"";
        self.is_orignal = @"";
        self.remark = @"";
        self.source = @"";
        self.recommend = @"";
    }
    return self;
}

@end
