//
//  CarInspectionModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarInspectionModel.h"

@implementation CarInspectionModel

-(instancetype)init
{
    if (self = [super init]) {
        self.wenTiArray = [[NSMutableArray alloc]init];
        self.cunImage = [[UIImage alloc]init];
        self.fangXiang = @"";
        self.beiZhu = @"";
        self.tuPianNameStr = @"";
        self.urlDiZhi = @"";
    }
    return self;
}

@end
