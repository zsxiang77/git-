//
//  OrderDetailViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/1.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailViewController.h"

@implementation OrderDetailViewController (Net)

-(void)postorder_basicwithShuaXin:(BOOL)shuaX
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanZhiModel.ordercode forKey:@"ordercode"];
    [self.main_tabelView.mj_header endRefreshing];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/order_basic" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            weakSelf.mainData = [[OrderDetailModel alloc]init];
            [weakSelf.mainData setdataWithDict:dataDic];
            if (weakSelf.mainData.show_list.is_show_recom) {
                weakSelf.tableHeaderView.frame = CGRectMake(0, 0, kWindowW, 798/2);
            }else
            {
                weakSelf.tableHeaderView.frame = CGRectMake(0, 0, kWindowW, 798/2-152/2);
            }
            
            [weakSelf.tableHeaderView refreshData:weakSelf.mainData];
            weakSelf.main_tabelView.tableHeaderView = self.tableHeaderView;
            
            [weakSelf shengChengZhuShuZu];
            [weakSelf.main_tabelView reloadData];
        }else{
            return ;
        }
    } failure:^(id error) {
        
    }];
}

-(void)shengChengZhuShuZu
{
    [self.mainDataArray removeAllObjects];
    if (self.mainData.show_list.is_show_subjects == YES) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"subjects" forKey:@"name"];
        [dict setObject:self.mainData.subjects forKey:@"vely"];
        [self.mainDataArray addObject:dict];
    }
    if (self.mainData.show_list.is_show_mointor == YES) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"protect_subjects" forKey:@"name"];
        [dict setObject:self.mainData.protect_subjects forKey:@"vely"];
        [self.mainDataArray addObject:dict];
    }
    if (self.mainData.show_list.is_show_parts == YES) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"parts" forKey:@"name"];
        [dict setObject:self.mainData.parts forKey:@"vely"];
        [self.mainDataArray addObject:dict];
    }
    
    if (self.mainData.show_list.is_show_services == YES) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"services" forKey:@"name"];
        [dict setObject:self.mainData.services forKey:@"vely"];
        [self.mainDataArray addObject:dict];
    }
    
    if (self.mainData.show_list.is_show_commods == YES) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"commods" forKey:@"name"];
        [dict setObject:self.mainData.commods forKey:@"vely"];
        [self.mainDataArray addObject:dict];
    }
    
    if (self.mainData.order_info.repair_describe) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"repair_describe" forKey:@"name"];
        if (self.mainData.order_info.repair_describe.length>0) {
            [dict setObject:[self parseJSONStringToNSDictionary:self.mainData.order_info.repair_describe] forKey:@"vely"];
        }else{
            NSArray *array = [NSArray new];
            [dict setObject:array forKey:@"vely"];
            
        }
        
        [self.mainDataArray addObject:dict];
    }
    
}

-(NSArray *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
//计算总额
-(CGFloat)jiSuanZongE
{
    CGFloat zonge = 0;
    if (self.mainData.show_list.is_show_subjects == YES) {
        zonge += [self jiSuanSubjectsZongE];
    }
    if (self.mainData.show_list.is_show_parts == YES) {
        zonge += [self jiSuanPartsZongE];
    }
    if (self.mainData.show_list.is_show_services == YES) {
        zonge += [self jiSuanServicesZongE];
    }
    if (self.mainData.show_list.is_show_commods == YES) {
        zonge += [self jiSuanCommodsZongE];
    }
    return zonge;
}
//项目总额
-(CGFloat)jiSuanSubjectsZongE
{
    CGFloat zonge = 0;
    if (self.mainData.show_list.is_show_subjects == YES) {
        for (int i = 0; i<self.mainData.subjects.count; i++) {
            OrderDetailSubjectsModel *dataMode = self.mainData.subjects[i];
            CGFloat  reality_fee = [dataMode.reality_fee floatValue];
            CGFloat  hour = [dataMode.hour floatValue];
            zonge += reality_fee*hour;
        }
    }
    return zonge;
}
//配件总额
-(CGFloat)jiSuanPartsZongE
{
    CGFloat zonge = 0;
    if (self.mainData.show_list.is_show_parts == YES) {
        for (int i = 0; i<self.mainData.parts.count; i++) {
            OrderDetailPartsModel *dataMode = self.mainData.parts[i];
            CGFloat  parts_num = [dataMode.parts_num floatValue];
            CGFloat  parts_fee = [dataMode.parts_fee floatValue];
            zonge += parts_num*parts_fee;
        }
    }
    return zonge;
}
//洗美项目总额
-(CGFloat)jiSuanServicesZongE
{
    CGFloat zonge = 0;
    if (self.mainData.show_list.is_show_services == YES) {
        for (int i = 0; i<self.mainData.services.count; i++) {
            NSDictionary *dataMode = self.mainData.services[i];
            CGFloat  reality_price = [KISDictionaryHaveKey(dataMode, @"reality_price") floatValue];
            zonge += reality_price;
        }
    }
    return zonge;
}
//洗美配件总额
-(CGFloat)jiSuanCommodsZongE
{
    CGFloat zonge = 0;
    if (self.mainData.show_list.is_show_commods == YES) {
        for (int i = 0; i<self.mainData.commods.count; i++) {
            NSDictionary *dataMode = self.mainData.commods[i];
            CGFloat  count = [KISDictionaryHaveKey(dataMode, @"count") floatValue];
            CGFloat  reality_price = [KISDictionaryHaveKey(dataMode, @"reality_price") floatValue];
            zonge += count*reality_price;
        }
    }
    return zonge;
}

@end
