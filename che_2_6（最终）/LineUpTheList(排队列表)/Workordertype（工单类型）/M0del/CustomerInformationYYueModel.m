//
//  CustomerInformationYYueModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CustomerInformationYYueModel.h"


@implementation CustomerInformationYYueModel
-(void)setDataShuJu:(NSDictionary *)dict
{
    self.ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ordercode")];
    self.status=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"status")];
    self.create_time=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"create_time")];
    self.appointment=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"appointment")];
    self.order_type=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"order_type")];
    self.end_days=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"end_days")];
    NSArray *subjectArray = KISDictionaryHaveKey(dict, @"subject");
    NSMutableArray *ar = [[NSMutableArray alloc]init];
    for (int i = 0; i<subjectArray.count; i++) {
        OrderDetailSubjectsModel *md = [[OrderDetailSubjectsModel alloc]init];
        [md setdataWithDict:subjectArray[i]];
        [ar addObject:md];
    }
    self.subject = ar;
    
    NSArray *partsArray = KISDictionaryHaveKey(dict, @"parts");
    NSMutableArray *ar2 = [[NSMutableArray alloc]init];
    for (int i = 0; i<partsArray.count; i++) {
        OrderDetailPartsModel *md = [[OrderDetailPartsModel alloc]init];
        [md setdataWithDict:partsArray[i]];
        [ar2 addObject:md];
    }
    self.parts = ar2;
    
    self.info = KISDictionaryHaveKey(dict, @"info");
    
    self.order_typeArray = [self.order_type componentsSeparatedByString:@","];
}

@end
