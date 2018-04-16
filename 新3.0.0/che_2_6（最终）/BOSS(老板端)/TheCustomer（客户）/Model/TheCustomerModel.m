//
//  TheCustomerModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TheCustomerModel.h"
#import "BOSSCheDianZhangCommon.h"

@implementation TheCustomerModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    self.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"user_id")];
    self.mobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"mobile")];
    self.is_unit = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_unit")];
    self.store_alias = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"store_alias")];

}

@end
