//
//  ConstructionPersonnelErModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstructionPersonnelErModel : NSObject

@property(nonatomic,strong)NSString *type_id;
@property(nonatomic,strong)NSString *type_name;
@property(nonatomic,strong)NSArray *staff;
@property(nonatomic,assign)BOOL zheHe;

-(void)setQingQiuData:(NSDictionary *)dict;

@end



@interface ConstructionStaffModel : NSObject

@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *staff_id;
@property(nonatomic,assign)BOOL shiFouXuanZhong;
@property(nonatomic,assign)BOOL shiFouKeShan;
-(void)setQingQiuData:(NSDictionary *)dict;

@end
