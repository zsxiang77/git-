//
//  BossJianCeXiangQingModel.m
//  cheDianZhang
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossJianCeXiangQingModel.h"

@implementation BossJianCeXiangQingModel
-(void)setJianCeDatashuJu:(NSDictionary*)dic
{

    self.question_types = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"question_types")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.option = KISDictionaryHaveKey(dic, @"option");
    NPrintLog(@"option2%ld",self.option.count);
    self.answer = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"answer")];
    self.analysis = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"analysis")];
    self.question_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"question_id")];
    self.answer_u = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"answer_u")];

}
@end
