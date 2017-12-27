//
//  OrderDetailModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property(nonatomic,strong)NSArray *comm_imgs;
@property(nonatomic,strong)NSArray *comm_info;
@property(nonatomic,strong)NSString *holder_info;
@property(nonatomic,strong)NSDictionary *inspector;
@property(nonatomic,strong)NSString *is_free;
@property(nonatomic,strong)NSString *is_lock;
@property(nonatomic,strong)NSDictionary *lock_staff;
@property(nonatomic,strong)NSString *operation;
@property(nonatomic,strong)NSArray *media_images;
@property(nonatomic,strong)NSDictionary *order_info;
@property(nonatomic,strong)NSString *pre_holder;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *repair_mileage;
@property(nonatomic,strong)NSDictionary *seller;
@property(nonatomic,strong)NSString *staff_name;
@property(nonatomic,strong)NSArray *subjects;

@property(nonatomic,strong)NSDictionary *users_info;

@property(nonatomic,strong)NSDictionary *ait;

@property(nonatomic,assign)BOOL ait_switch;


-(void)setDangQIanWIthData:(NSDictionary *)dict;

@end


@interface Order_info : NSDictionary
@property(nonatomic,strong)NSString *advance_price;
@property(nonatomic,strong)NSString *brand_img;
@property(nonatomic,strong)NSString *car_brand;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *car_type;
@property(nonatomic,strong)NSString *cars_spec;
@property(nonatomic,strong)NSString *class_name;
@property(nonatomic,strong)NSString *create_type;
@property(nonatomic,strong)NSString *need_pay;
@property(nonatomic,strong)NSString *order_url;
@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *repair_mileage;
@property(nonatomic,strong)NSString *service;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *vin;

@property(nonatomic,strong)NSString *add_time;

-(void)setDangQIanWIthData:(NSDictionary *)dict;

@end

@interface OrignalModel : NSObject

@property(nonatomic,strong)NSString *subject_id;
@property(nonatomic,strong)NSString *subject;
@property(nonatomic,strong)NSString *reality_fee;
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *operation;
@property(nonatomic,strong)NSString *starttime;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *is_append;
@property(nonatomic,strong)NSString *staff_alias;
@property(nonatomic,strong)NSString *is_oper;
@property(nonatomic,strong)NSString *subject_total;
@property(nonatomic,strong)NSArray *parts;

@property(nonatomic,assign)BOOL shiFouXuanZhong;

-(void)setDangQIanWIthData:(NSDictionary *)dict;

@end


@interface PeiJianListModel : NSObject

@property(nonatomic,strong)NSString *parts_id;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSString *cname;
@property(nonatomic,strong)NSString *cattr;
@property(nonatomic,strong)NSString *commodity_code;
@property(nonatomic,strong)NSString *parts_num;
@property(nonatomic,strong)NSString *parts_fee;
@property(nonatomic,strong)NSString *parts_total;

@property(nonatomic,assign)BOOL shiFouXuanZhong;

-(void)setDangQIanWIthData:(NSDictionary *)dict;

@end

