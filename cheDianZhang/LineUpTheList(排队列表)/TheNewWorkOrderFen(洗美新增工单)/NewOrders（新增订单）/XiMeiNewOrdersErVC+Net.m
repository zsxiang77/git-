//
//  XiMeiNewOrdersErVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErVC.h"
#import "SuccessfulOrderViewController.h"


@implementation XiMeiNewOrdersErVC (Net)

-(void)postREQUEST_METHODWithService_id:(NSString *)service_id{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:service_id forKey:@"service_id"];
    if (self.zuiZongModel.shiFoNiMing == NO) {
        [mDict setObject:self.zuiZongModel.user_id forKey:@"user_id"];
    }else
    {
        [mDict setObject:@"0" forKey:@"user_id"];
    }
    
    [mDict setObject:self.zuiZongModel.spec_id forKey:@"spec_id"];
    [mDict setObject:self.zuiZongModel.targetid forKey:@"target_id"];
    [mDict setObject:self.zuiZongModel.cars_detail forKey:@"cars_detail"];
    
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/service_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *service = KISDictionaryHaveKey(dataDic, @"service");
        weakSelf.huoQuServiceData = [XiMeiNewOrdersErModel yy_modelWithDictionary:service];
        
        [weakSelf.service_commodArray removeAllObjects];
        NSArray *service_commods = KISDictionaryHaveKey(dataDic, @"service_commods");
        
        for (int i = 0; i<service_commods.count; i++) {
            Service_commods *model = [Service_commods yy_modelWithDictionary:service_commods[i]];
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
    [mDict setObject:@"true" forKey:@"add_queue"];
    NSString *commod_price = @"";
    NSString *commod_id = @"";
    NSString *count = @"";
    NSString *is_orignal = @"";
    for (int i = 0; i<self.service_commodArray.count; i++) {
        Service_commods *model =  self.service_commodArray[i];
        if (commod_price.length>0) {
            commod_price = [NSString stringWithFormat:@"%@,%@",commod_price,model.price];
        }else
        {
            commod_price = model.price;
        }
        
        if (commod_id.length>0) {
            commod_id = [NSString stringWithFormat:@"%@,%@",commod_id,model.commodity_id];
        }else
        {
            commod_id = model.commodity_id;
        }
        
        if (count.length>0) {
            count = [NSString stringWithFormat:@"%@,%@",count,model.count];
        }else
        {
            count = model.count;
        }
        
        if (is_orignal.length>0) {
            is_orignal = [NSString stringWithFormat:@"%@,%@",is_orignal,model.is_orignal];
        }else
        {
            is_orignal = model.is_orignal;
        }
    }
    self.zuiZongModel.service_fee = self.huoQuServiceData.price;
    self.zuiZongModel.commod_price = commod_price;
    self.zuiZongModel.commod_id = commod_id;
    self.zuiZongModel.count = count;
    self.zuiZongModel.is_orignal = is_orignal;
    
    [mDict setObject:self.zuiZongModel.mobile forKey:@"mobile"];
    [mDict setObject:self.zuiZongModel.realname forKey:@"realname"];
    [mDict setObject:self.zuiZongModel.service_name forKey:@"service_name"];
    [mDict setObject:self.zuiZongModel.service_fee forKey:@"service_fee"];
    [mDict setObject:self.zuiZongModel.cars_detail forKey:@"cars_detail"];
    [mDict setObject:self.zuiZongModel.user_id forKey:@"user_id"];
    [mDict setObject:self.zuiZongModel.spec_id forKey:@"spec_id"];
    [mDict setObject:self.zuiZongModel.targetid forKey:@"targetid"];
    [mDict setObject:self.zuiZongModel.car_number forKey:@"car_number"];
    [mDict setObject:self.zuiZongModel.hour forKey:@"hour"];
    [mDict setObject:self.zuiZongModel.commod_price forKey:@"commod_price"];
    [mDict setObject:self.zuiZongModel.commod_id forKey:@"commod_id"];
    [mDict setObject:self.zuiZongModel.count forKey:@"count"];
    [mDict setObject:self.zuiZongModel.is_orignal forKey:@"is_orignal"];
    [mDict setObject:self.zuiZongModel.remark forKey:@"remark"];
    [mDict setObject:self.zuiZongModel.source forKey:@"source"];
    [mDict setObject:self.zuiZongModel.recommend forKey:@"recommend"];
    
    [mDict setObject:self.chuZhiModel.serviceid forKey:@"service_id"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/services_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
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
            }
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
}

@end
