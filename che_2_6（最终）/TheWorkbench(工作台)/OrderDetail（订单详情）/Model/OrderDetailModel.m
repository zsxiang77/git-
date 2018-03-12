//
//  OrderDetailModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/1.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailModel.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    OrderDetailOrder_infoModel * order_info = [[OrderDetailOrder_infoModel alloc]init];
    [order_info setdataWithDict:KISDictionaryHaveKey(dict, @"order_info")];
    self.order_info = order_info;
    self.inspect_percent = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"inspect_percent")];
    
    OrderDetailShow_listModel * show_list = [[OrderDetailShow_listModel alloc]init];
    [show_list setdataWithDict:KISDictionaryHaveKey(dict, @"show_list")];
    self.show_list = show_list;
    self.protect_subjects = KISDictionaryHaveKey(dict, @"protect_subjects");
    NSMutableArray *subjects1 = [[NSMutableArray alloc]init];
    NSArray *subjects2 = KISDictionaryHaveKey(dict, @"subjects");
    for (int i = 0; i<subjects2.count; i++) {
        OrderDetailSubjectsModel *amm = [[OrderDetailSubjectsModel alloc]init];
        [amm setdataWithDict:subjects2[i]];
        [subjects1 addObject:amm];
    }
    self.subjects = subjects1;
    
    
    NSMutableArray *parts1 = [[NSMutableArray alloc]init];
    NSArray *parts2 = KISDictionaryHaveKey(dict, @"parts");
    for (int i = 0; i<parts2.count; i++) {
        OrderDetailPartsModel *amm = [[OrderDetailPartsModel alloc]init];
        [amm setdataWithDict:parts2[i]];
        [parts1 addObject:amm];
    }
    self.parts = parts1;
    self.services = KISDictionaryHaveKey(dict, @"services");
    self.commods = KISDictionaryHaveKey(dict, @"commods");
    
    OrderDetailAitModel * ait = [[OrderDetailAitModel alloc]init];
    [ait setdataWithDict:KISDictionaryHaveKey(dict, @"ait")];
    self.is_hide_button = [KISDictionaryHaveKey(dict, @"is_hide_button") boolValue];
    self.ait = ait;
}

@end

@implementation OrderDetailOrder_infoModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ordercode")];
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.cars_spec = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cars_spec")];
    self.repair_describe = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"repair_describe")];
    self.send_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"send_name")];
    self.builder_state = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"builder_state")];
    self.create_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"create_time")];
    self.vin = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"vin")];
    self.status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"status")];
    self.order_status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"order_status")];
    self.brand_img = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"brand_img")];
    self.class_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"class_name")];
    self.order_url = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"order_url")];
    self.price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"price")];

}

@end

@implementation OrderDetailShow_listModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.is_show_recom = [KISDictionaryHaveKey(dict, @"is_show_recom") boolValue];
    self.recom_num = [KISDictionaryHaveKey(dict, @"recom_num") integerValue];
    self.is_show_mointor = [KISDictionaryHaveKey(dict, @"is_show_mointor") boolValue];
    self.is_show_subjects = [KISDictionaryHaveKey(dict, @"is_show_subjects") boolValue];
    self.is_show_parts = [KISDictionaryHaveKey(dict, @"is_show_parts") boolValue];
    self.is_show_services = [KISDictionaryHaveKey(dict, @"is_show_services") boolValue];
    self.is_show_commods = [KISDictionaryHaveKey(dict, @"is_show_commods") boolValue];
}

@end

@implementation OrderDetailAitModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.num = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"num")];
    self.massage = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"massage")];
    self.ait_status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ait_status")];
}

@end

@implementation OrderDetailSubjectsModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.subject_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"subject_id")];
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"reality_fee")];
    self.hour = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"hour")];
    self.operation = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"operation")];
    self.operation_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"operation_name")];
    self.shiFouBianJi = NO;
}

@end

@implementation OrderDetailPartsModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    
    self.parts_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_id")];
    self.parts_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_name")];
    self.parts_num = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_num")];
    self.parts_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_fee")];
    self.unit = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"unit")];
    self.count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"count")];
    self.parts_brand = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_brand")];
    self.parts_code = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_code")];
    self.shiFouBianJi = NO;
    self.shiFouXuanZhong = NO;
}

@end
