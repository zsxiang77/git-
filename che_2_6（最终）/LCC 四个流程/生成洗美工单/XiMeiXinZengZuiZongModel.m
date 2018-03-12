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
        self.miaoShuArray = [[NSArray alloc]init];
        self.plate_color = @"蓝色";
        self.send_mobile = @"";
        self.send_name = @"";
        self.send_id_card = @"";
        
        self.car_brand = @"";
        self.car_type = @"";
        self.cars_spec = @"";
        
    }
    return self;
}

@end

@implementation Car_zongModel

-(instancetype)init
{
    if (self = [super init]) {
        self.user_id = @"";
        self.is_unit = @"";
        self.mobile = @"";
        self.realname = @"";
        self.car_number = @"";
    }
    return self;
}

@end




