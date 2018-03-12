//
//  TheWorkModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/31.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheDianZhangCommon.h"

@interface TheWorkModel : NSObject

@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *cars_spec;
@property(nonatomic,strong)NSString *service;
@property(nonatomic,strong)NSString *queue_id;
@property(nonatomic,strong)NSString *add_time;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *class_name;
@property(nonatomic,strong)NSString *brand_img;
@property(nonatomic,strong)NSString *ait_report;
@property(nonatomic,assign)NSInteger is_lock;
@property(nonatomic,assign)BOOL ait_switch;

@property(nonatomic,assign)BOOL  shanChuState;//删除按钮



-(void)setdataWithDict:(NSDictionary *)dict;



@end
