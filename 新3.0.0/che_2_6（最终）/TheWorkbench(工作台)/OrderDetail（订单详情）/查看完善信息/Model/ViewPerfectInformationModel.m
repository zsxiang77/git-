//
//  ViewPerfectInformationModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ViewPerfectInformationModel.h"

@implementation ViewPerfectInformationModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.key = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"key")];
    self.value = KISDictionaryHaveKey(dict, @"value");
    self.percent = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"percent")];
}
@end

@implementation ViewPerfectInformationUser_infoModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"user_id")];
    self.mobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"mobile")];
    self.send_mobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"send_mobile")];
    self.send_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"send_name")];
    self.send_id_card = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"send_id_card")];
    self.is_unit = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_unit")];
    self.store_alias = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"store_alias")];
    self.id_card = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"id_card")];
    self.unit_full_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"unit_full_name")];
}

@end
@implementation ViewPerfectInformationCar_infoModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.car_spec = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_spec")];
    self.owner = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"owner")];
    self.engine_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"engine_number")];
    self.carvin = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"carvin")];
    self.model = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"model")];
    self.use_character = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"use_character")];
    self.issue_date = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"issue_date")];
    self.register_date = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"register_date")];
    self.address = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"address")];
    self.cartype = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cartype")];
    self.car_body_color = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_body_color")];
    
}

@end
@implementation ViewPerfectInformationInsurance_infoModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.TCI_expire = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"TCI_expire")];
    self.VCI_expire = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"VCI_expire")];
    self.insurance_force = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"insurance_force")];
    self.insurance_company = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"insurance_company")];
    self.valid_car_date = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"valid_car_date")];
    self.insurance_force_images = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"insurance_force_images")];
    self.insurance_company_images = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"insurance_company_images")];
}

@end
@implementation ViewPerfectInformationInspect_infoModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.images = KISDictionaryHaveKey(dict, @"images");
    self.image_info_sum = KISDictionaryHaveKey(dict, @"image_info_sum");
}

@end
@implementation ViewPerfectInformationGoods_infoModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.goods = KISDictionaryHaveKey(dict, @"goods");
    self.goods_remark = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"goods_remark")];
}

@end
@implementation ViewPerfectInformationFunctions_infoModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.functions = KISDictionaryHaveKey(dict, @"functions");
    self.functions_remark = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"functions_remark")];
}

@end


@implementation ViewPerfectInformationGas_infoModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.gas = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"gas")];
    self.repairmile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"repairmile")];
}
@end


