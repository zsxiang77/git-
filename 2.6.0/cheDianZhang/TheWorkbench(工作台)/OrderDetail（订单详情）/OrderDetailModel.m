//
//  OrderDetailModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderDetailModel.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailModel

-(void)setDangQIanWIthData:(NSDictionary *)dict
{
    if (!self.media_images) {
        self.media_images = [[NSArray alloc]init];
    }
    self.media_images  = KISDictionaryHaveKey(dict, @"media_images");
    self.ait  = KISDictionaryHaveKey(dict, @"ait");
    self.ait_switch  = [KISDictionaryHaveKey(dict, @"ait_switch") boolValue];
    self.comm_imgs = KISDictionaryHaveKey(dict, @"comm_imgs");
    self.comm_info = KISDictionaryHaveKey(dict, @"comm_info");
    self.holder_info = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"holder_info")];
    self.inspector = KISDictionaryHaveKey(dict, @"inspector");
    self.is_free = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_free")];
    self.is_lock = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_lock")];
    self.lock_staff = KISDictionaryHaveKey(dict, @"lock_staff");
    self.operation = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"operation")];
    NSDictionary *oreDict = KISDictionaryHaveKey(dict, @"order_info");
    Order_info *mdoel = [[Order_info alloc]init];
    [mdoel setDangQIanWIthData:oreDict];
    self.order_info = mdoel;
    self.pre_holder = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"pre_holder")];
    self.remark = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"remark")];
    self.repair_mileage = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"repair_mileage")];
    self.seller = KISDictionaryHaveKey(dict, @"seller");
    self.staff_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_name")];
    self.subjects = KISDictionaryHaveKey(dict, @"subjects");
    self.users_info = KISDictionaryHaveKey(dict, @"users_info");
}

@end

@implementation Order_info

-(void)setDangQIanWIthData:(NSDictionary *)dict
{
    
    self.advance_price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"advance_price")];
    self.brand_img = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"brand_img")];
    self.car_brand = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_brand")];
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.car_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_type")];
    self.cars_spec = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cars_spec")];
    self.class_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"class_name")];
    self.create_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"create_type")];
    self.need_pay = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"need_pay")];
    self.order_url = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"order_url")];
    self.ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ordercode")];
    self.price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"price")];
    self.repair_mileage = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"repair_mileage")];
    self.service = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"service")];
    self.source = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"source")];
    self.status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"status")];
    self.add_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"add_time")];
    self.vin = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"vin")];
}

@end

@implementation OrignalModel


-(instancetype)init
{
    if (self = [super init]) {
        self.shiFouXuanZhong = NO;
    }
    return self;
}

-(void)setDangQIanWIthData:(NSDictionary *)dict
{
    self.parts = KISDictionaryHaveKey(dict, @"brand_img");
    self.subject_total = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"subject_total")];
    self.is_oper = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_oper")];
    self.staff_alias = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_alias")];
    self.is_append = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_append")];
    self.status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"status")];
    self.endtime = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"endtime")];
    self.starttime = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"starttime")];
    self.operation = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"operation")];
    self.hour = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"hour")];
    self.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"reality_fee")];
    self.subject = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"subject")];
    self.subject_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"subject_id")];
}

@end

@implementation PeiJianListModel

-(instancetype)init
{
    if (self = [super init]) {
        self.shiFouXuanZhong = NO;
    }
    return self;
}


-(void)setDangQIanWIthData:(NSDictionary *)dict
{
    self.parts_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_id")];
    self.count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"count")];
    self.cname = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cname")];
    self.cattr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cattr")];
    self.commodity_code = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"commodity_code")];
    self.parts_num = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_num")];
    self.parts_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_fee")];
    self.parts_total = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_total")];
}

@end

