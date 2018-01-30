//
//  JobBoardModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobBoardModel : NSObject

@property(nonatomic,strong)NSString *car_info;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *is_heavy;
@property(nonatomic,strong)NSString *is_urgent;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *person_name;
@property(nonatomic,strong)NSString *press_time;
@property(nonatomic,strong)NSString *remain;
@property(nonatomic,strong)NSString *task_id;
@property(nonatomic,strong)NSString *task_type;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *username;


-(void)setdataWithDict:(NSDictionary *)dict;

@end
