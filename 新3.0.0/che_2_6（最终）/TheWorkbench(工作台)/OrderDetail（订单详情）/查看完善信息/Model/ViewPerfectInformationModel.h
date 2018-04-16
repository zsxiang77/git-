//
//  ViewPerfectInformationModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ViewPerfectInformationUser_infoModel;
@class ViewPerfectInformationCar_infoModel;
@class ViewPerfectInformationInsurance_infoModel;
@class ViewPerfectInformationInspect_infoModel;
@class ViewPerfectInformationGoods_infoModel;
@class ViewPerfectInformationFunctions_infoModel;
@class ViewPerfectInformationGas_infoModel;

@interface ViewPerfectInformationModel : NSObject
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSDictionary *value;
@property(nonatomic,strong)NSString *percent;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface ViewPerfectInformationUser_infoModel : NSObject

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *send_mobile;
@property(nonatomic,strong)NSString *send_name;
@property(nonatomic,strong)NSString *send_id_card;
@property(nonatomic,strong)NSString *is_unit;
@property(nonatomic,strong)NSString *store_alias;
@property(nonatomic,strong)NSString *id_card;
@property(nonatomic,strong)NSString *unit_full_name;
-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface ViewPerfectInformationCar_infoModel : NSObject

@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *car_spec;
@property(nonatomic,strong)NSString *owner;
@property(nonatomic,strong)NSString *engine_number;
@property(nonatomic,strong)NSString *carvin;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *use_character;
@property(nonatomic,strong)NSString *issue_date;
@property(nonatomic,strong)NSString *register_date;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *cartype;
@property(nonatomic,strong)NSString *car_body_color;


-(void)setdataWithDict:(NSDictionary *)dict;
@end

@interface ViewPerfectInformationInsurance_infoModel : NSObject

@property(nonatomic,strong)NSString *TCI_expire;
@property(nonatomic,strong)NSString *VCI_expire;
@property(nonatomic,strong)NSString *insurance_force;
@property(nonatomic,strong)NSString *insurance_company;
@property(nonatomic,strong)NSString *valid_car_date;
@property(nonatomic,strong)NSString *insurance_force_images;
@property(nonatomic,strong)NSString *insurance_company_images;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface ViewPerfectInformationInspect_infoModel : NSObject

@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *image_info_sum;
-(void)setdataWithDict:(NSDictionary *)dict;

@end

@interface ViewPerfectInformationGoods_infoModel : NSObject

@property(nonatomic,strong)NSArray *goods;
@property(nonatomic,strong)NSString *goods_remark;
-(void)setdataWithDict:(NSDictionary *)dict;


@end

@interface ViewPerfectInformationFunctions_infoModel : NSObject

@property(nonatomic,strong)NSArray *functions;
@property(nonatomic,strong)NSString *functions_remark;
-(void)setdataWithDict:(NSDictionary *)dict;


@end

@interface ViewPerfectInformationGas_infoModel : NSObject

@property(nonatomic,strong)NSString *gas;
@property(nonatomic,strong)NSString *repairmile;
-(void)setdataWithDict:(NSDictionary *)dict;
@end



