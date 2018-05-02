//
//  StoreDetliModel.m
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreDetliModel.h"

@implementation StoreDetliModel
-(void)setdataDict:(NSDictionary *)dict
{
    NSDictionary *work_infoC = KISDictionaryHaveKey(dict, @"ability");
    self.ability = [[abilityModel alloc]init];
    [self.ability setdataDict:work_infoC];
    
    NSDictionary *work_ability = KISDictionaryHaveKey(dict, @"achievement");
    self.achievement = [[achievementModel alloc]init];
    [self.achievement setdataDict:work_ability];
    
    self.task = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"task")];
    self.time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"time")];
    self.y = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"y")];
    self.m = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"m")];
}
@end
@implementation abilityModel
-(void)setdataDict:(NSDictionary *)dict
{
    NSDictionary *work_abilitydetail = KISDictionaryHaveKey(dict, @"abilitydetail");
    self.abilitydetail = [[abilitydetailModel alloc]init];
    [self.abilitydetail setdataDict:work_abilitydetail];
    self.abilitynum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"abilitynum")];
    self.real_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"real_name")];
    self.avatar = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"avatar")];
    self.staff_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_id")];
}
@end
@implementation abilitydetailModel
-(void)setdataDict:(NSDictionary *)dict
{
    self.sales = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"sales")];
    self.work = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"work")];
    self.excavate = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"excavate")];
    self.customer = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"customer")];
    self.newconsumer = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"newconsumer")];
}
@end
@implementation achievementModel
-(void)setdataDict:(NSDictionary *)dict
{
    self.repair = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"repair")];
    self.insurance = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"insurance")];
    self.maintain = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"maintain")];
    self.cosmetology = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"cosmetology")];
    self.wash = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"wash")];
    self.retail = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"retail")];
    self.vip = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"vip")];
    self.total_price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"total_price")];
    self.car_num = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_num")];
    self.price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"price")];
}
@end
