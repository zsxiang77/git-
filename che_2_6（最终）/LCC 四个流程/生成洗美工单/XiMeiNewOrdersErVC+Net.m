//
//  XiMeiNewOrdersErVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErVC.h"
#import "SuccessfulOrderViewController.h"
#import "YYModel.h"
#import "LCMessageViewModel.h"



@implementation XiMeiNewOrdersErVC (Net)

-(void)postREQUEST_METHODWithService_id:(NSString *)service_id{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:service_id forKey:@"service_id"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/service_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *service = KISDictionaryHaveKey(dataDic, @"service");
        weakSelf.huoQuServiceData = [XiMeiNewOrdersErModel modelWithDictionary:service];
        
        [weakSelf.service_commodArray removeAllObjects];
        NSArray *service_commods = KISDictionaryHaveKey(dataDic, @"service_commods");
        
        for (int i = 0; i<service_commods.count; i++) {
            Service_commods *model = [Service_commods modelWithDictionary:service_commods[i]];
            model.shiFouKeShan = NO;
            [weakSelf.service_commodArray addObject:model];
        }
        
        [weakSelf jiSuanZongEQian];
        [weakSelf.main_tabelView reloadData];
        
    } failure:^(id error) {
        
    }];
}




-(void)postREQUEST_METHODWithTiaoJiao{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithCapacity:10];
//    ===========================
    NSMutableArray *commodity = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.service_commodArray.count; i++) {
        Service_commods *model =  self.service_commodArray[i];
        NSMutableDictionary *nDict = [[NSMutableDictionary alloc]init];
        [nDict setObject:model.name forKey:@"name"];
        [nDict setObject:model.is_orignal forKey:@"is_orignal"];
        [nDict setObject:model.commodity_id forKey:@"commodity_id"];
        [nDict setObject:model.count forKey:@"commodity_num"];
        [nDict setObject:model.price forKey:@"fee"];
        [nDict setObject:model.sku_properties forKey:@"commodity_sku"];
//        NSString *str = [self convertToJsonData:nDict];
        [commodity addObject:nDict];
    }
    [infoDict setObject:commodity forKey:@"commodity"];
    [infoDict setObject:self.zuiZongModel.mobile forKey:@"mobile"];
    [infoDict setObject:self.huoQuServiceData.price forKey:@"service_fee"];
    if (self.userInformetionDict) {
        NSArray *users_cars = KISDictionaryHaveKey(self.userInformetionDict, @"users_cars");
        [infoDict setObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_cars[0], @"car_id")] forKey:@"targetid"];
    }else{
        [infoDict setObject:@"0" forKey:@"targetid"];
    }
    [infoDict setObject:self.huoQuServiceData.title forKey:@"service"];
    [infoDict setObject:self.zuiZongModel.car_number forKey:@"car_number"];
    [infoDict setObject:self.zuiZongModel.plate_color forKey:@"plate_color"];
    [infoDict setObject:self.huoQuServiceData.serviceid forKey:@"serviceid"];
    if (self.zuiZongModel.shiFoNiMing == YES) {
        [infoDict setObject:@"" forKey:@"send_mobile"];
        [infoDict setObject:@"" forKey:@"send_name"];
        [infoDict setObject:@"" forKey:@"send_id_card"];
        [infoDict setObject:@"0" forKey:@"user_id"];
        
        
    }else{
        [infoDict setObject:self.zuiZongModel.send_mobile forKey:@"send_mobile"];
        [infoDict setObject:self.zuiZongModel.send_name forKey:@"send_name"];
        if (self.zuiZongModel.send_id_card) {
            [infoDict setObject:self.zuiZongModel.send_id_card forKey:@"send_id_card"];
        }
        
        [infoDict setObject:self.zuiZongModel.user_id forKey:@"user_id"];
    }
    
//    ===========================
    NSMutableArray *description = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.zuiZongModel.miaoShuArray.count; i++) {
        LCMessageViewModel *model =  self.zuiZongModel.miaoShuArray[i];
        NSMutableDictionary *nDict = [[NSMutableDictionary alloc]init];
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
//        NSDate *date = [dateFormatter dateFromString:model.time];
//        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        [nDict setObject:model.timeStamp forKey:@"time"];
        [nDict setObject:model.message forKey:@"info"];
//        NSString *str = [self convertToJsonData:nDict];
        [description addObject:nDict];
    }
    
    [infoDict setObject:[self convertToJsonDataWithArray:description] forKey:@"description"];
    
    [infoDict setObject:self.zuiZongModel.car_brand forKey:@"car_brand"];
    [infoDict setObject:self.zuiZongModel.car_type forKey:@"car_type"];
    [infoDict setObject:self.zuiZongModel.cars_spec forKey:@"cars_spec"];
    [infoDict setObject:self.zuiZongModel.spec_id forKey:@"spec_id"];
    
    [mDict setObject:[self convertToJsonData:infoDict] forKey:@"info"];
//    [mDict setObject:infoDict forKey:@"info"];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/new_order/create_wash" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue]== 200) {
            NSString *query_url = KISDictionaryHaveKey(dataDic, @"query_url");
            if (query_url.length>0) {
                SuccessfulOrderViewController *vc = [[SuccessfulOrderViewController alloc]init];
                vc.chuZhiDict = dataDic;
                [self.navigationController pushViewController:vc animated:YES];
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:kShuaXinGuoZuoTai object:nil];
            }
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
}

@end
