//
//  Car_zongModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "Car_zongModel.h"

@implementation Car_zongModel

-(instancetype)init
{
    if (self = [super init]) {
        self.user_id = @"";
        self.target_id = @"";
        self.image_info = [[NSMutableArray alloc]init];
        self.image_info_sum = [[NSMutableArray alloc]init];
        self.exist = @"";
        self.abnormal = @"";
        self.gas = @"";
        self.repairmile = @"";
        self.remark = @"";
        self.repairnature = @"";
        self.repair_describe = @"";
        self.repairtype = @"";
        self.imagec = @"";
        self.goods_remark = @"";
        self.upload = [[NSMutableDictionary alloc]init];;
        self.unit_full_name = @"";
        self.deliver_mobile = @"";
        self.deliver_name = @"";
        self.is_unit = @"";
        self.mobile = @"";
        self.realname = @"";
    }
    return self;
}

@end
