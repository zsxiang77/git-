//
//  WritePersonalModel.h
//  cheDianZhang
//
//  Created by sykj on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WritePersonalDataModel;

@interface WritePersonalModel : NSObject
@property (nonatomic, strong) WritePersonalDataModel *model;
@end

@interface WritePersonalDataModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *send_addr;
@property (nonatomic, copy) NSString *send_birth;
@property (nonatomic, copy) NSString *send_nation;
@property (nonatomic, copy) NSString *send_sex;
@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *send_mobile;
@property (nonatomic, copy) NSString *send_name;
@property (nonatomic, copy) NSString *send_id_card;
@property (nonatomic, copy) NSString *is_unit;
@property (nonatomic, copy) NSString *store_alias;
@property (nonatomic, copy) NSString *id_card;
@property (nonatomic, copy) NSString *unit_full_name;
@property (nonatomic, copy) NSString *ordercode;


@end
