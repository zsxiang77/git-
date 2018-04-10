//
//  LearningWrongModel.h
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearningWrongModel : NSObject
@property(nonatomic,strong)NSString      *no_wrong;
@property(nonatomic,strong)NSString      *num;
@property(nonatomic,strong)NSArray      *wrong;
@property(nonatomic,strong)NSString      *totalnum;


-(void)setDictData:(NSDictionary *)dict;
@end

@interface LearningWrongListModel : NSObject
@property(nonatomic,strong)NSString      *answer;
@property(nonatomic,strong)NSString      *answer_u;
@property(nonatomic,strong)NSArray      *option;
@property(nonatomic,strong)NSString      *question_id;
@property(nonatomic,strong)NSString      *question_types;
@property(nonatomic,strong)NSString      *title;

-(void)setDictData:(NSDictionary *)dict;
@end
