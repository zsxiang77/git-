//
//  LearningZuoCeShiModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearningZuoCeShiModel : NSObject

@property(nonatomic,strong)NSString      *question_id;
@property(nonatomic,strong)NSString      *question_types;
@property(nonatomic,strong)NSString      *title;
@property(nonatomic,strong)NSArray      *option;

-(void)setDictData:(NSDictionary *)dict;

@end
