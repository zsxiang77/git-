//
//  FunctionalCheckModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FunctionalCheckModel.h"
#import "CheDianZhangCommon.h"

@implementation FunctionalCheckModel

-(void)setDataShuJu:(NSDictionary *)dict{
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.overhaul_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"overhaul_id")];
    self.result = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"result")];
    self.dataBool = [KISDictionaryHaveKey(dict, @"bool") boolValue];
}

@end
