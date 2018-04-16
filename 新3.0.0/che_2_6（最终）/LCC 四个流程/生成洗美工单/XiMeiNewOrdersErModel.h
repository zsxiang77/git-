//
//  XiMeiNewOrdersErModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiMeiNewOrdersErModel : NSObject

@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *service_process;
@property(nonatomic,strong)NSString *serviceid;
@property(nonatomic,strong)NSString *title;


@end


@interface Service_commods : NSObject
@property(nonatomic,strong)NSString *commodity_id;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSString *current_count;
@property(nonatomic,strong)NSString *images;
@property(nonatomic,strong)NSString *is_orignal;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *sku_properties;
@property(nonatomic,strong)NSString *unit;


@property(nonatomic,assign)BOOL  shiFouKeShan;

@property(nonatomic,assign)BOOL  xuanZhong;

-(void)setDictData:(NSDictionary *)dict;



@end
