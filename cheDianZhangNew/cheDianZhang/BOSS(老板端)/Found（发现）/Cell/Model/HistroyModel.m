//
//  HistroyModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "HistroyModel.h"
#import "BOSSCheDianZhangCommon.h"
@implementation HistroyModel
-(void)setDatashuJu:(NSDictionary *)dic{
    self.minutes=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"minutes")];
    self.image=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    self.title=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.num=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"num")];
}
@end
