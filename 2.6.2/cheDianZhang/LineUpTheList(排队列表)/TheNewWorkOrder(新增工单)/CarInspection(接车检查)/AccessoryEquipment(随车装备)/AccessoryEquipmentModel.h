//
//  AccessoryEquipmentModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessoryEquipmentModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *overhaul_id;
@property(nonatomic,assign)BOOL shiFouXuanZhong;

-(void)setDataShuJu:(NSDictionary *)dict;

@end


@interface AccessoryFunctionsModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *overhaul_id;
@property(nonatomic,assign)BOOL FunctionXuanZhong;

-(void)setDataShuJu:(NSDictionary *)dict;

@end
