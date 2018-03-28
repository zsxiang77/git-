//
//  XiMeiNewOrdersModer.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersModer.h"

@implementation XiMeiNewOrdersModer

-(void)setDictData:(NSDictionary *)dict
{
    self.images = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"images")];
    self.market_price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"market_price")];
    self.price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"price")];
    self.serviceid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"serviceid")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    self.isSelect = NO;
}

@end
