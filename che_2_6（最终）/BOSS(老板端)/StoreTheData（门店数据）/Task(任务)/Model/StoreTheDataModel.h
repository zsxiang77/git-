//
//  StoreTheDataModel.h
//  cheDianZhang
//
//  Created by apple on 2018/4/21.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Work_infoModel;

@interface StoreTheDataModel : NSObject

@property(nonatomic,strong)Work_infoModel *work_info;
@property(nonatomic,strong)NSArray *staff_list;
@property(nonatomic,strong)NSArray *task_list;

-(void)setdataDict:(NSDictionary *)dict;

@end

@interface Work_infoModel : NSObject

@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *undone;
@property(nonatomic,strong)NSString *inval;
@property(nonatomic,strong)NSString *done;
@property(nonatomic,strong)NSString *appoint;
@property(nonatomic,strong)NSString *arrival;
@property(nonatomic,strong)NSString *other_consume;
@property(nonatomic,strong)NSString *arrival_p;
@property(nonatomic,strong)NSString *appoint_p;
@property(nonatomic,strong)NSString *other_consume_p;
@property(nonatomic,strong)NSString *done_p;
@property(nonatomic,strong)NSString *inval_p;
@property(nonatomic,strong)NSString *undone_p;
@property(nonatomic,strong)NSString *appoint_p1;

-(void)setdataDict:(NSDictionary *)dict;
@end

@interface Staff_listModel : NSObject
@property(nonatomic,strong)NSString *appoint;
@property(nonatomic,strong)NSString *arrival;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *staff_id;
-(void)setdataDict:(NSDictionary *)dict;

@end

@interface Task_listModel : NSObject

@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *undone;
@property(nonatomic,strong)NSString *done;
@property(nonatomic,strong)NSString *inval;
@property(nonatomic,strong)NSString *appoint;
@property(nonatomic,strong)NSString *task_name;

-(void)setdataDict:(NSDictionary *)dict;

@end
