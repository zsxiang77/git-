//
//  TheCustomerModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheCustomerModel : NSObject

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *is_unit;
@property(nonatomic,strong)NSString *store_alias;


-(void)setdataWithDict:(NSDictionary *)dict;

@end
