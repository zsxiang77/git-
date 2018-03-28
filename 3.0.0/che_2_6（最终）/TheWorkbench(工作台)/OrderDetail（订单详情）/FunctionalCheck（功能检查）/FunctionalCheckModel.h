//
//  FunctionalCheckModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionalCheckModel : NSObject


@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *overhaul_id;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,assign)BOOL dataBool;

-(void)setDataShuJu:(NSDictionary *)dict;

@end
