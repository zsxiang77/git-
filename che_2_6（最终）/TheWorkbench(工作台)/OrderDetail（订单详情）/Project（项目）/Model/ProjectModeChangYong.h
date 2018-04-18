//
//  ProjectModeChangYong.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModeChangYong : NSObject
@property(nonatomic,strong)NSString *subject_id;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *fee;


-(void)setdataWithDict:(NSDictionary *)dict;
@end
