//
//  CustomerInformationYYueModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailModel.h"

@interface CustomerInformationYYueModel : NSObject
@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *appointment;
@property(nonatomic,strong)NSString *order_type;
@property(nonatomic,strong)NSString*end_days;


@property(nonatomic,strong)NSArray *subject;
@property(nonatomic,strong)NSArray *parts;
@property(nonatomic,strong)NSArray *info;
-(void)setDataShuJu:(NSDictionary *)dict;
@end
