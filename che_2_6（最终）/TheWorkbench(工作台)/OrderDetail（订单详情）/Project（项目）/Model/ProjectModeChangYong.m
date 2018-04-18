//
//  ProjectModeChangYong.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ProjectModeChangYong.h"

@implementation ProjectModeChangYong
-(void)setdataWithDict:(NSDictionary *)dict
{
      self.subject_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"subject_id")];
      self.id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"id")];
      self.name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
      self.hour = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"hour")];
      self.fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fee")];
}
@end
