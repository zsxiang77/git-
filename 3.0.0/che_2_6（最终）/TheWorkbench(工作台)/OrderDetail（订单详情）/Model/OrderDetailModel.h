//
//  OrderDetailModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/1.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderDetailOrder_infoModel;
@class OrderDetailShow_listModel;
@class OrderDetailAitModel;


@interface OrderDetailModel : NSObject

@property(nonatomic,strong)OrderDetailOrder_infoModel *order_info;
@property(nonatomic,strong)NSString *inspect_percent;
@property(nonatomic,strong)OrderDetailShow_listModel *show_list;
@property(nonatomic,strong)NSArray *protect_subjects;
@property(nonatomic,strong)NSArray *subjects;
@property(nonatomic,strong)NSArray *parts;
@property(nonatomic,strong)NSArray *services;
@property(nonatomic,strong)NSArray *commods;
@property(nonatomic,strong)OrderDetailAitModel *ait;
@property(nonatomic,assign)BOOL is_hide_button;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface OrderDetailOrder_infoModel : NSObject

@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *cars_spec;
@property(nonatomic,strong)NSString *repair_describe;
@property(nonatomic,strong)NSString *send_name;
@property(nonatomic,strong)NSString *builder_state;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *vin;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *order_status;
@property(nonatomic,strong)NSString *brand_img;
@property(nonatomic,strong)NSString *class_name;
@property(nonatomic,strong)NSString *order_url;
@property(nonatomic,strong)NSString *price;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface OrderDetailShow_listModel : NSObject

@property(nonatomic,assign)BOOL is_show_recom;
@property(nonatomic,assign)NSInteger recom_num;
@property(nonatomic,assign)BOOL is_show_mointor;
@property(nonatomic,assign)BOOL is_show_subjects;
@property(nonatomic,assign)BOOL is_show_parts;
@property(nonatomic,assign)BOOL is_show_services;
@property(nonatomic,assign)BOOL is_show_commods;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface OrderDetailAitModel : NSObject

@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *massage;
@property(nonatomic,strong)NSString *ait_status;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface OrderDetailSubjectsModel : NSObject

@property(nonatomic,strong)NSString *subject_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *reality_fee;
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *operation;
@property(nonatomic,strong)NSString *operation_name;

@property(nonatomic,assign)BOOL     shiFouBianJi;//是否编辑

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface OrderDetailPartsModel : NSObject

@property(nonatomic,strong)NSString *parts_brand;
@property(nonatomic,strong)NSString *parts_id;
@property(nonatomic,strong)NSString *parts_name;
@property(nonatomic,strong)NSString *parts_num;
@property(nonatomic,strong)NSString *parts_fee;
@property(nonatomic,strong)NSString *parts_code;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *count;

@property(nonatomic,assign)BOOL     shiFouBianJi;//是否编辑
@property(nonatomic,assign)BOOL     shiFouXuanZhong;//是否选中

-(void)setdataWithDict:(NSDictionary *)dict;

@end
