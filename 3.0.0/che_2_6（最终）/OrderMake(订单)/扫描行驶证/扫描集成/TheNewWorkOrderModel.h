//
//  TheNewWorkOrderModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheDianZhangCommon.h"

@interface TheNewWorkOrderModel : NSMutableDictionary

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *textName;


@end



@interface Users_carsModel : NSObject

@property(nonatomic,strong)NSString *brand_id;
@property(nonatomic,strong)NSString *brand_pic;
@property(nonatomic,strong)NSString *car_body_color;
@property(nonatomic,strong)NSString *car_id;
@property(nonatomic,strong)NSString *car_info;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,assign)NSInteger show_tip;
@property(nonatomic,strong)NSString *spec_id;
@property(nonatomic,strong)NSDictionary *tip;
@property(nonatomic,strong)NSString *unit_full_name;//企业全称

@property(nonatomic,strong)NSString *brands;
@property(nonatomic,strong)NSString *trainSystem;
@property(nonatomic,strong)NSString *models;
@property(nonatomic,strong)NSString *modelsId;
@property(nonatomic,assign)BOOL ait;


@property(nonatomic,assign)BOOL shiFouXinZeng;//是否新增
@property(nonatomic,assign)BOOL shifouXuanZHong;//是否选中

-(void)setdataWithDict:(NSDictionary *)dict;


@end

@interface XinShiZheng_carsModel : NSObject

@property(nonatomic,strong)NSString *imagesLocal;
@property(nonatomic,strong)NSString *images;
@property(nonatomic,assign)NSInteger target_id;
@property(nonatomic,strong)NSString *owner;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *use_character;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *issue_date;
@property(nonatomic,strong)NSString *register_date;
@property(nonatomic,strong)NSString *carvin;
@property(nonatomic,strong)NSString *engine_number;
@property(nonatomic,strong)NSString *carno;
@property(nonatomic,assign)NSInteger cartype;
@property(nonatomic,strong)NSString *color;

@end

