//
//  FoundDetailModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundDetailModel.h"
#import "BOSSCheDianZhangCommon.h"

@implementation FoundDetailModel


-(void)setdataWithDict:(NSDictionary *)dict
{
    
    self.articleid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"articleid")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    self.author = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"author")];
    self.time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"time")];
    self.content = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"content")];
    self.praisenum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"praisenum")];
    self.commentnum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"commentnum")];
    self.readnum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"readnum")];
    self.is_praise = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_praise")];
    self.now_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"now_time")];
    
    
}

@end

@implementation FoundDetailListModel
-(void)setdataWithDict:(NSDictionary *)dict
{
    
    self.c_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"c_id")];
    self.articleid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"articleid")];
    self.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"user_id")];
    self.content = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"content")];
    self.createdate = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"createdate")];
    self.pid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"pid")];
    self.to_user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"to_user_id")];
    self.praise = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"praise")];
    self.fid = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fid")];
    self.is_praise = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"is_praise")];
    self.now_time = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"now_time")];
    self.username = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"username")];
    self.avatar = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"avatar")];
    self.to_username = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"to_username")];
    self.original = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"original")];
}

@end
