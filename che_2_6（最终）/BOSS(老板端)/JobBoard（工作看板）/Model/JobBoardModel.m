//
//  JobBoardModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardModel.h"
#import "BOSSCheDianZhangCommon.h"

@implementation JobBoardModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.car_info = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_info")];
    self.car_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    self.is_heavy = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_heavy")];
    self.is_urgent = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_urgent")];
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.person_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"person_name")];
    self.press_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"press_time")];
    self.remain = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"remain")];
    self.task_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"task_id")];
    self.task_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"task_type")];
    
    self.unit = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"unit")];
    self.username = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"username")];
}
@end
