//
//  LearningVideoModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningVideoModel.h"

@implementation LearningVideoModel

-(void)setDatashuJu:(NSDictionary*)dic
{
    self.video_url = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"video_url")];
    self.auto_url = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"auto_url")];
    self.exam_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"exam_id")];
    self.brief = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"brief")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.image = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    self.video_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"video_id")];
    self.free_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"free_time")];
    self.is_buy = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"is_buy")];
    self.price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"price")];
    self.num = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"num")];
    self.type_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"type_id")];
    self.user_coll = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"user_coll")];
    self.user_buy = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"user_buy")];
}

@end
