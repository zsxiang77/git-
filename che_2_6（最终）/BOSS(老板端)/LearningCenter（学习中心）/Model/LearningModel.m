//
//  LearningModel.m
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningModel.h"

@implementation LearningModel
-(void)setDatashuJu:(NSDictionary *)dic{
    self.url=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"url")];
    self.title=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.video_id=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"video_id")];
    self.playnum=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"playnum")];
    self.image=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    self.teacher=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"teacher")];
    self.likenum=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"likenum")];
    
    self.is_buy=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"is_buy")];
    self.price=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"price")];
    self.user_coll=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"user_coll")];
    self.user_buy=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"user_buy")];
    self.is_new=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"is_new")];
    self.buynum=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"buynum")];
    self.chuanzhiMain=NO;
    
}
@end
