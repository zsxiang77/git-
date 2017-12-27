//
//  WeiXiuZhanShiModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiXiuZhanShiModel : NSObject

@property(nonatomic,strong)NSDictionary *order_info;
@property(nonatomic,strong)NSString *is_lock;
@property(nonatomic,strong)NSString *is_free;
@property(nonatomic,strong)NSDictionary *lock_staff;
@property(nonatomic,strong)NSArray *subjects;
@property(nonatomic,strong)NSDictionary *users_info;
@property(nonatomic,strong)NSArray *comm_info;
@property(nonatomic,strong)NSArray *comm_imgs;
@property(nonatomic,strong)NSString *holder_info;
@property(nonatomic,strong)NSString *staff_name;
@property(nonatomic,strong)NSString *pre_holder;
@property(nonatomic,strong)NSDictionary *seller;
@property(nonatomic,strong)NSString *operation;
@property(nonatomic,strong)NSString *repair_mileage;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSDictionary *inspector;
@property(nonatomic,strong)NSArray *media_images;
@property(nonatomic,strong)NSDictionary *ait;
@property(nonatomic,strong)NSString *is_builder;
@property(nonatomic,strong)NSDictionary *builder_info;
@property(nonatomic,strong)NSString *is_comment;
@property(nonatomic,strong)NSDictionary *comment;
@property(nonatomic,strong)NSDictionary *service_info;


-(void)setdataWithDict:(NSDictionary *)dict;

@end
