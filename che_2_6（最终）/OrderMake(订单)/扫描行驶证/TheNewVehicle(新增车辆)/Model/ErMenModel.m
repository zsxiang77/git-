//
//  ErMenModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ErMenModel.h"

@implementation ErMenModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.bfirstletter = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"bfirstletter")];
    self.brand_id = [KISDictionaryHaveKey(dict, @"brand_id") integerValue];
    self.imges = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"imges")];
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
}

@end

