//
//  XiMeiXinZengZuiZongModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiMeiXinZengZuiZongModel : NSObject

@property(nonatomic,assign)BOOL shiFoNiMing;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *realname;
@property(nonatomic,strong)NSString *service_name;
@property(nonatomic,strong)NSString *service_fee;
@property(nonatomic,strong)NSString *cars_detail;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *spec_id;
@property(nonatomic,strong)NSString *targetid;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *commod_price;
@property(nonatomic,strong)NSString *commod_id;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSString *is_orignal;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *recommend;
@property(nonatomic,strong)NSString *plate_color;

@property(nonatomic,strong)NSString *send_mobile;
@property(nonatomic,strong)NSString *send_name;
@property(nonatomic,strong)NSString *send_id_card;

@property(nonatomic,strong)NSString *car_brand;
@property(nonatomic,strong)NSString *car_type;
@property(nonatomic,strong)NSString *cars_spec;





@property(nonatomic,strong)NSArray  *miaoShuArray;

@end



@interface Car_zongModel : NSObject

@property(nonatomic,strong)NSString *car_Color;
@property(nonatomic,strong)NSString *car_number;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *is_unit;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *realname;

@end
