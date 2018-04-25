//
//  StoreRenyuanModel.h
//  cheDianZhang
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreRenyuanModel : NSObject
@property(nonatomic,strong)NSString *all_page;
@property(nonatomic,strong)NSString *pagesize;
@property(nonatomic,strong)NSString *page;
@property(nonatomic,strong)NSString *y;
@property(nonatomic,strong)NSString *m;
@property(nonatomic,strong)NSArray *list;

-(void)setdataDict:(NSDictionary *)dict;
@end
@interface listModel : NSObject

@property(nonatomic,strong)NSString *total_price;
@property(nonatomic,strong)NSString *staff_id;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *avatar;

-(void)setdataDict:(NSDictionary *)dict;
@end
