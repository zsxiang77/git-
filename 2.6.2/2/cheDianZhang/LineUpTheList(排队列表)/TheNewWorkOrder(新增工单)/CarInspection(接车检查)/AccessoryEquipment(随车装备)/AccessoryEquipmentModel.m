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

-(instancetype)init
{
    if (self = [super init]) {
        self.shiFouXuanZhong = YES;
        self.name = @"";
        self.overhaul_id = @"";
    }
    return self;
}

-(void)setDataShuJu:(NSDictionary *)dict{
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.overhaul_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"overhaul_id")];
}

@end



@implementation AccessoryFunctionsModel

-(instancetype)init
{
    if (self = [super init]) {
        self.FunctionXuanZhong = NO;
        self.name = @"";
        self.overhaul_id = @"";
    }
    return self;
}

-(void)setDataShuJu:(NSDictionary *)dict{
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.overhaul_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"overhaul_id")];
}

@end
