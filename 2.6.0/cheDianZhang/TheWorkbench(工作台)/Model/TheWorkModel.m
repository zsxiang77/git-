//
//  TheWorkModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/31.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkModel.h"

@implementation TheWorkModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ordercode")];
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.cars_spec = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cars_spec")];
    self.service = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"service")];
    self.queue_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"queue_id")];
    self.add_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"add_time")];
    self.status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"status")];
    self.class_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"class_name")];
    self.brand_img = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"brand_img")];
    self.ait_report = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ait_report")];
    self.is_lock = [KISDictionaryHaveKey(dict, @"is_lock") integerValue];
    
    self.ait_switch = [KISDictionaryHaveKey(dict, @"ait_switch") boolValue];
    
    self.shanChuState = NO;
}

@end
