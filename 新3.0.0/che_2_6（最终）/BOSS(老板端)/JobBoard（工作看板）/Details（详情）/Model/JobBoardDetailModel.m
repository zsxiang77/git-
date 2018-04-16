//
//  JobBoardDetailModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/18.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardDetailModel.h"
#import "BOSSCheDianZhangCommon.h"

@implementation JobBoardDetailModel

-(void)setdataWithDict:(NSDictionary *)dict{
    JobBoardInfoModel *model = [[JobBoardInfoModel alloc]init];
    
    [model setdataWithDict:KISDictionaryHaveKey(dict, @"info")];
    self.info = model;
    
    self.task_detail = KISDictionaryHaveKey(dict, @"task_detail");
}

@end
@implementation JobBoardInfoModel

-(void)setdataWithDict:(NSDictionary *)dict{
    
    self.task_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"task_type")];
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.is_urgent = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_urgent")];
    self.is_heavy = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_heavy")];
    self.status = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"status")];
    self.person_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"person_name")];
    self.car_info = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_info")];
    self.ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ordercode")];
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.end_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"end_time")];
    self.order_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"order_type")];
    self.finish_date = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"finish_date")];
    self.person_concat = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"person_concat")];
    self.press_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"press_time")];
    self.contents = KISDictionaryHaveKey(dict, @"contents");
    self.remain = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"remain")];
    self.unit = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"unit")];
    
}

@end
