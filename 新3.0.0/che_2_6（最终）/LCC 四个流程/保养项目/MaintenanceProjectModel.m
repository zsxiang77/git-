//
//  MaintenanceProjectModel.m
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "MaintenanceProjectModel.h"

@implementation MaintenanceProjectModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"parts" : [MaintenanceProjectPartstModel class]};
    
}
@end
