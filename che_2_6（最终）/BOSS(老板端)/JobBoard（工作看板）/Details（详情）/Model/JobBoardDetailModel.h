//
//  JobBoardDetailModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/18.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JobBoardInfoModel;

@interface JobBoardDetailModel : NSObject

@property(nonatomic,strong)JobBoardInfoModel *info;
@property(nonatomic,strong)NSArray *task_detail;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface JobBoardInfoModel : NSObject

@property(nonatomic,strong)NSString *task_type;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *is_urgent;
@property(nonatomic,strong)NSString *is_heavy;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *person_name;
@property(nonatomic,strong)NSString *car_info;
@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *press_time;
@property(nonatomic,strong)NSString *order_type;
@property(nonatomic,strong)NSString *finish_date;
@property(nonatomic,strong)NSArray *contents;
@property(nonatomic,strong)NSString *remain;
@property(nonatomic,strong)NSString *person_concat;
@property(nonatomic,strong)NSString *unit;
-(void)setdataWithDict:(NSDictionary *)dict;

@end
