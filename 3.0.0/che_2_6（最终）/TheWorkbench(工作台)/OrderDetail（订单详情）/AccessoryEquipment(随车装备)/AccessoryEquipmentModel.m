//
//  AccessoryEquipmentModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AccessoryEquipmentModel.h"
#import "CheDianZhangCommon.h"

@implementation AccessoryEquipmentModel

-(void)setDataShuJu:(NSDictionary *)dict{
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.overhaul_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"overhaul_id")];
    self.result = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"result")];
    self.dataBool = [KISDictionaryHaveKey(dict, @"bool") boolValue];
}

@end

