//
//  LearningZuoCeShiModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningZuoCeShiModel.h"

@implementation LearningZuoCeShiModel


-(void)setDictData:(NSDictionary *)dict
{
    self.question_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"question_id")];
    self.question_types = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"question_types")];
    self.title = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    self.option = KISDictionaryHaveKey(dict, @"option");
    
    NSMutableArray *xinArray = [[NSMutableArray alloc]init];
    if (self.option.count>0) {
        for (int i = 0; i<self.option.count; i++) {
            LearningZuoCeShiDaAnModel *ximModel = [[LearningZuoCeShiDaAnModel alloc]init];
            ximModel.tiStr = self.option[i];
            ximModel.shiFouXuanZhong = NO;
            [xinArray addObject:ximModel];
        }
    }
    self.daAn = xinArray;
}

@end

@implementation LearningZuoCeShiDaAnModel

@end

