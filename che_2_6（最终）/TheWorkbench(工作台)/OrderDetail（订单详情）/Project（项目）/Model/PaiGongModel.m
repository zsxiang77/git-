//
//  PaiGongModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "PaiGongModel.h"
#import "CheDianZhangCommon.h"

@implementation PaiGongModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    
    self.type_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"type_id")];
    self.type_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"type_name")];
    NSMutableArray *tianJiaArray = [[NSMutableArray alloc]init];
    NSArray *array = KISDictionaryHaveKey(dict, @"staff");
    for (int i = 0; i<array.count; i++) {
        PaiGongStaffModel *model = [[PaiGongStaffModel alloc]init];
        [model setdataWithDict:array[i]];
        [tianJiaArray addObject:model];
    }
    self.staff = tianJiaArray;
}

@end

@implementation PaiGongStaffModel

-(void)setdataWithDict:(NSDictionary *)dict
{
    self.staff_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_id")];
    self.real_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"real_name")];
    self.staff_img = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_img")];
    self.shiFouXuanZhong = NO;
}

@end
