//
//  WritePersonalModel.m
//  cheDianZhang
//
//  Created by sykj on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "WritePersonalModel.h"

@implementation WritePersonalModel

-(instancetype)init
{
    if (self = [super init]) {
        self.model = [[WritePersonalDataModel alloc]init];
    }
    return self;
}

@end

@implementation WritePersonalDataModel

-(instancetype)init
{
    if (self = [super init]) {
        self.address = @"";
        self.birthday = @"";
        self.nation = @"";
        self.send_addr = @"";
        self.send_birth = @"";
        self.send_nation = @"";
        self.send_sex = @"";
        self.sex = @"";
        
        self.user_id = @"";
        self.mobile = @"";
        self.send_mobile = @"";
        self.send_name = @"";
        self.send_id_card = @"";
        self.is_unit = @"";
        self.store_alias = @"";
        self.id_card = @"";
        self.unit_full_name = @"";
        self.ordercode = @"";
        
    }
    return self;
}
@end;
