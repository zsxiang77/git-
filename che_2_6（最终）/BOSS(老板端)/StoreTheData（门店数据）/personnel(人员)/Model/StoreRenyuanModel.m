//
//  StoreRenyuanModel.m
//  cheDianZhang
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenyuanModel.h"

@implementation StoreRenyuanModel

-(void)setdataDict:(NSDictionary *)dict{
    self.all_page =  [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"all_page")];
    self.pagesize =  [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"pagesize")];
    self.page =  [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"page")];
    self.y =  [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"y")];
    self.m =  [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"m")];
    NSMutableArray * Staff_listC =[[NSMutableArray alloc]init];
    NSArray * Staff_listC1 = KISDictionaryHaveKey(dict, @"list");
    if(Staff_listC1.count>0){
        for (int i =0; i<Staff_listC1.count; i++) {
            listModel * model = [[listModel alloc]init];
            [model setdataDict:Staff_listC1[i]];
            [Staff_listC addObject:model];
        }
    }
    self.list = Staff_listC;
}
@end
@implementation listModel
-(void)setdataDict:(NSDictionary *)dict{
    self.total_price =[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"total_price")];
    self.staff_id =[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"staff_id")];
    self.real_name =[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"real_name")];
    self.avatar =[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"avatar")];
}


@end
