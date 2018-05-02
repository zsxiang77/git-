//
//  StorePeiJianModel.h
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
@class listPeiJianModel;
@interface StorePeiJianModel : NSObject
@property(nonatomic,strong)NSString *all_page;
@property(nonatomic,strong)NSString *pagesize;
@property(nonatomic,strong)NSString *page;
@property(nonatomic,strong)NSArray * listArray;
-(void)setdataDict:(NSDictionary *)dict;
@end
@interface listPeiJianModel : NSObject

@property(nonatomic,strong)NSString *class_name;
@property(nonatomic,strong)NSString *class_id;
@property(nonatomic,strong)NSString *sales_price;
@property(nonatomic,strong)NSString *parts_brand;
@property(nonatomic,strong)NSString *parts_percent;
-(void)setdataDict:(NSDictionary *)dict;
@end
