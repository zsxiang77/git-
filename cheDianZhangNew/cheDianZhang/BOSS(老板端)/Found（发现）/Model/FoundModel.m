//
//  FoundModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/23.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundModel.h"
#import "BOSSCheDianZhangCommon.h"

@implementation FoundModel

-(void)setdataWithDict:(NSDictionary *)dict
{

    self.articleid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"articleid")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    self.image = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"image")];
    self.time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"time")];
    self.praisenum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"praisenum")];
    self.commentnum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"commentnum")];
    self.is_praise = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_praise")];
    
}

@end
