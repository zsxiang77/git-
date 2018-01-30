//
//  ConstructionPersonnelErModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ConstructionPersonnelErModel.h"
#import "CheDianZhangCommon.h"

@implementation ConstructionPersonnelErModel

-(instancetype)init
{
    if (self = [super init]) {
        self.type_id = @"";
        self.type_name = @"";
        self.staff = [[NSArray alloc]init];
        self.zheHe = NO;
    }
    return self;
}
-(void)setQingQiuData:(NSDictionary *)dict withXuanZong:(NSString *)str
{
    self.type_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"type_id")];
    self.type_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"type_name")];
    NSArray *array = KISDictionaryHaveKey(dict, @"staff");
    NSMutableArray *zuoHeArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<array.count; i++) {
        ConstructionStaffModel *model= [[ConstructionStaffModel alloc]init];
        [model setQingQiuData:array[i]];
        if ([model.real_name isEqualToString:str]) {
            model.shiFouXuanZhong = YES;
        }
        
        [zuoHeArray addObject:model];
    }
    
    self.staff = zuoHeArray;
}

@end


@implementation ConstructionStaffModel

-(instancetype)init
{
    if (self = [super init]) {
        self.real_name = @"";
        self.staff_id = @"";
        self.shiFouXuanZhong = NO;
        self.shiFouKeShan = NO;
    }
    return self;
}
-(void)setQingQiuData:(NSDictionary *)dict
{
    self.staff_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_id")];
    self.real_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"real_name")];
}

@end
