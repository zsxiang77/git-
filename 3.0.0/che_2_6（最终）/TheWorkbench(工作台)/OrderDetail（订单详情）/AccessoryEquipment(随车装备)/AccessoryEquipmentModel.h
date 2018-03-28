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
@property(nonatomic,strong)NSString *result;
@property(nonatomic,assign)BOOL dataBool;

-(void)setDataShuJu:(NSDictionary *)dict;

@end

