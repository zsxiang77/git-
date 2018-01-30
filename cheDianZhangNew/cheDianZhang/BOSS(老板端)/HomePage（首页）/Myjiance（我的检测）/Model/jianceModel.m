//
//  jianceModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "jianceModel.h"
#import "BOSSCheDianZhangCommon.h"
@implementation jianceModel
-(void)setDatashuJu:(NSDictionary *)dic{
    self.date=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"date")];
    self.total_fee=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"total_fee")];
    self.title=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.date=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    self.total_fee=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"video_id")];
    self.title=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"num")];

}
@end
