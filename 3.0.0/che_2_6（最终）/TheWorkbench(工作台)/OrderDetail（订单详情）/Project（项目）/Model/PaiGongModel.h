//
//  PaiGongModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaiGongModel : NSObject

@property(nonatomic,strong)NSString *type_id;
@property(nonatomic,strong)NSString *type_name;
@property(nonatomic,strong)NSArray *staff;


-(void)setdataWithDict:(NSDictionary *)dict;


@end


@interface PaiGongStaffModel : NSObject

@property(nonatomic,strong)NSString *staff_id;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *staff_img;

@property(nonatomic,assign)BOOL    shiFouXuanZhong;

-(void)setdataWithDict:(NSDictionary *)dict;


@end

