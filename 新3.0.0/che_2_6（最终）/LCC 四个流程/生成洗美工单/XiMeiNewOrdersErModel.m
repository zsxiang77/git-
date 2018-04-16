//
//  XiMeiNewOrdersErModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErModel.h"

@implementation XiMeiNewOrdersErModel


@end


@implementation Service_commods

-(void)setDictData:(NSDictionary *)dict
{

    self.commodity_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"commodityid")];
    self.count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"count")];
    self.current_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"current_count")];
    self.images = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"images")];
    self.is_orignal = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_orignal")];
    self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    self.price=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"reality_price")];
    self.sku_properties=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"sku_properties")];
    self.unit=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"unit")];
}

@end
