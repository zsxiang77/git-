//
//  TheNewWorkOrderModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheNewWorkOrderModel.h"

@implementation TheNewWorkOrderModel

@end
@implementation Users_carsModel

-(instancetype)init
{
    if (self = [super init]) {
        self.shiFouXinZeng = NO;
        self.shifouXuanZHong = NO;
    }
    return self;
}

-(void)setdataWithDict:(NSDictionary *)dict
{

    
    self.brand_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"brand_id")];
    self.brand_pic = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"brand_pic")];
    self.car_body_color = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_body_color")];
    self.car_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_id")];
    self.car_info = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_info")];
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.flag = [KISDictionaryHaveKey(dict, @"flag") integerValue];
    self.show_tip = [KISDictionaryHaveKey(dict, @"show_tip") integerValue];
    self.spec_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"spec_id")];
    self.unit_full_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"unit_full_name")];
    self.tip = KISDictionaryHaveKey(dict, @"tip");
    self.ait = [KISDictionaryHaveKey(dict, @"ait") boolValue];
    
    self.shiFouXinZeng = NO;
    self.shifouXuanZHong = NO;
}

@end

@implementation XinShiZheng_carsModel

-(instancetype)init
{
    if (self = [super init]) {
        self.images = @"";
        self.target_id = 0;
        self.owner = @"";
        self.address = @"";
        self.use_character = @"";
        self.model = @"";
        self.issue_date = @"";
        self.register_date = @"";
        self.carvin = @"";
        self.engine_number = @"";
        self.carno = @"";
        self.cartype = 0;
        self.color = @"";
    }
    return self;
}


@end
