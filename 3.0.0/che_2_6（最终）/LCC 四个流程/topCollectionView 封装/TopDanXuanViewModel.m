
//
//  TopDanXuanViewModel.m
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TopDanXuanViewModel.h"

@implementation TopDanXuanViewModel


-(void)setDictData:(NSDictionary *)dict
{
    self.imageUrl = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"images")];
    self.market_price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"market_price")];
    self.price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"price")];
    self.serviceid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"serviceid")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    self.imageName = @"";
    self.isSelect = NO;
}

@end
