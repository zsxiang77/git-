//
//  MaintenanceProjectModel.h
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaintenanceProjectPartstModel.h"
@interface MaintenanceProjectModel : NSObject
@property (nonatomic, strong) NSString *fee;

@property (nonatomic, strong) NSString *hour;
@property (nonatomic, assign) NSString *img_num;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray  *parts;
@property (nonatomic, strong) NSString *subject_id;
@property (nonatomic, assign) BOOL isSelect;
@end
