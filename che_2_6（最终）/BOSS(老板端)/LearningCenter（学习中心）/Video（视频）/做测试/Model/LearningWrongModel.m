//
//  LearningWrongModel.m
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningWrongModel.h"

@implementation LearningWrongModel

-(void)setDictData:(NSDictionary *)dict
{

    self.no_wrong = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"no_wrong")];
    self.num = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"num")];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSArray *tianAt =KISDictionaryHaveKey(dict, @"wrong");
    for (int i = 0; i<tianAt.count; i++) {
        LearningWrongListModel *model = [[LearningWrongListModel alloc]init];
        [model setDictData:tianAt[i]];
        [array addObject:model];
    }
    self.wrong = array;
    self.totalnum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"totalnum")];
}

@end

@implementation LearningWrongListModel
-(void)setDictData:(NSDictionary *)dict
{
    self.answer = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"answer")];
    self.answer_u = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"answer_u")];
    self.option = KISDictionaryHaveKey(dict, @"option");
    self.question_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"question_id")];
    self.question_types = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"question_types")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
}

@end

