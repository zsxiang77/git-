//
//  WeiXiuZhanShiModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "WeiXiuZhanShiModel.h"
#import "CheDianZhangCommon.h"

@implementation WeiXiuZhanShiModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.order_info = KISDictionaryHaveKey(dict, @"order_info");
    self.is_lock = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_lock")];
    self.is_free = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_free")];
    self.lock_staff = KISDictionaryHaveKey(dict, @"lock_staff");
    self.subjects = KISDictionaryHaveKey(dict, @"subjects");
    self.users_info = KISDictionaryHaveKey(dict, @"users_info");
    self.comm_info = KISDictionaryHaveKey(dict, @"comm_info");
    self.comm_imgs = KISDictionaryHaveKey(dict, @"comm_imgs");
    self.service_info = KISDictionaryHaveKey(dict, @"service_info");
    self.holder_info = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"holder_info")];
    self.staff_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_name")];
    self.pre_holder = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"pre_holder")];
    
    self.seller = KISDictionaryHaveKey(dict, @"seller");
    self.operation = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"operation")];
    self.repair_mileage = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"repair_mileage")];
    self.remark = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"remark")];
    self.inspector = KISDictionaryHaveKey(dict, @"inspector");
    self.media_images = KISDictionaryHaveKey(dict, @"media_images");
    self.ait = KISDictionaryHaveKey(dict, @"ait");
    self.is_builder = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_builder")];
    self.builder_info = KISDictionaryHaveKey(dict, @"builder_info");
    self.is_comment = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_comment")];
    self.comment = KISDictionaryHaveKey(dict, @"comment");
    
    
}

@end
