//
//  Car_zongModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car_zongModel : NSObject

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *target_id;
@property(nonatomic,strong)NSMutableArray *image_info;
@property(nonatomic,strong)NSMutableArray *image_info_sum;
@property(nonatomic,strong)NSString *exist;
@property(nonatomic,strong)NSString *abnormal;
@property(nonatomic,strong)NSString *gas;
@property(nonatomic,strong)NSString *repairmile;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *repairnature;
@property(nonatomic,strong)NSString *repair_describe;
@property(nonatomic,strong)NSString *repairtype;
@property(nonatomic,strong)NSString *imagec;
@property(nonatomic,strong)NSString *goods_remark;
@property(nonatomic,strong)NSMutableDictionary *upload;
@property(nonatomic,strong)NSString *unit_full_name;

@property(nonatomic,strong)NSString *deliver_mobile;
@property(nonatomic,strong)NSString *deliver_name;

@property(nonatomic,strong)NSString *is_unit;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *realname;

@end
