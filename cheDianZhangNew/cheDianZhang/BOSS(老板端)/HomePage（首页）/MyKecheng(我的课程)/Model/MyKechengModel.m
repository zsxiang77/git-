//
//  MyKechengModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "MyKechengModel.h"
#import "BOSSCheDianZhangCommon.h"
@implementation MyKechengModel
-(void)setDatashuJu:(NSDictionary *)dic{
    self.date=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"date")];
    self.total_fee=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"total_fee")];
    self.title=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.image=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    self.video_id=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"video_id")];
    self.num=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"num")];
    
}
@end
