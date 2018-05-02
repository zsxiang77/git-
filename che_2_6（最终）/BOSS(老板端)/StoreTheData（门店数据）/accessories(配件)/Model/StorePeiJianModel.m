//
//  StorePeiJianModel.m
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StorePeiJianModel.h"

@implementation StorePeiJianModel
-(void)setdataDict:(NSDictionary *)dict{
   self.all_page = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"all_page")];
   self.pagesize = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"pagesize")];
   self.page = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"page")];
    NSMutableArray * Array = [[NSMutableArray alloc]init];
    NSArray * Staff_listC1 = KISDictionaryHaveKey(dict, @"sale_list");
    if(Staff_listC1.count>0){
        for (int i =0; i<Staff_listC1.count; i++) {
            listPeiJianModel * model = [[listPeiJianModel alloc]init];
            [model setdataDict:Staff_listC1[i]];
            [Array addObject:model];
        }
    }
    self.listArray = Array;
}

@end
@implementation listPeiJianModel
-(void)setdataDict:(NSDictionary *)dict{
    self.class_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"class_name")];
    self.class_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"class_id")];
    self.sales_price = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"sales_price")];
    self.parts_brand = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_brand")];
    self.parts_percent = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"parts_percent")];
}

@end
