//
//  BossJianCeXiangQingModel.h
//  cheDianZhang
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BossJianCeXiangQingModel : NSObject
@property(nonatomic,strong)NSString * question_types;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSArray  * option;
@property(nonatomic,strong)NSString * answer;
@property(nonatomic,strong)NSString * analysis;
@property(nonatomic,strong)NSString * question_id;
@property(nonatomic,strong)NSString * answer_u;

-(void)setJianCeDatashuJu:(NSDictionary*)dic;
@end
