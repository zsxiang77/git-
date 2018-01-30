//
//  BossJianceModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossJianceModel.h"
#import "BOSSCheDianZhangCommon.h"
@implementation BossJianceModel
-(void)setDatashuJu:(NSDictionary *)dic{
    self.a_id=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"a_id")];
    self.num=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"num")];
    self.score=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"score")];
    self.exam_id=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"exam_id")];
    self.image=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    self.test_paper_name=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"test_paper_name")];
    
}
@end
