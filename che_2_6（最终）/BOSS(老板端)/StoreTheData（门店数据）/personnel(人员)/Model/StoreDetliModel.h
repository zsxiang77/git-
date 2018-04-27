//
//  StoreDetliModel.h
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
@class abilityModel;
@class abilitydetailModel;
@class achievementModel;


@interface StoreDetliModel : NSObject
@property(nonatomic,strong)abilityModel *ability;
@property(nonatomic,strong)achievementModel *achievement;
@property(nonatomic,strong)NSString *task;
@property(nonatomic,strong)NSString *y;
@property(nonatomic,strong)NSString *m;
-(void)setdataDict:(NSDictionary *)dict;
@end



@interface abilityModel : NSObject
@property(nonatomic,strong)NSString *abilitynum;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *staff_id;
@property(nonatomic,strong)abilitydetailModel *abilitydetail;
-(void)setdataDict:(NSDictionary *)dict;
@end



@interface abilitydetailModel : NSObject

@property(nonatomic,strong)NSString *sales;
@property(nonatomic,strong)NSString *work;
@property(nonatomic,strong)NSString *excavate;
@property(nonatomic,strong)NSString *customer;
@property(nonatomic,strong)NSString *newconsumer;

-(void)setdataDict:(NSDictionary *)dict;
@end



@interface achievementModel : NSObject

@property(nonatomic,strong)NSString *repair;
@property(nonatomic,strong)NSString *insurance;
@property(nonatomic,strong)NSString *maintain;
@property(nonatomic,strong)NSString *cosmetology;
@property(nonatomic,strong)NSString *wash;
@property(nonatomic,strong)NSString *retail;
@property(nonatomic,strong)NSString *vip;
@property(nonatomic,strong)NSString *total_price;
@property(nonatomic,strong)NSString *car_num;
@property(nonatomic,strong)NSString *price;

-(void)setdataDict:(NSDictionary *)dict;
@end
