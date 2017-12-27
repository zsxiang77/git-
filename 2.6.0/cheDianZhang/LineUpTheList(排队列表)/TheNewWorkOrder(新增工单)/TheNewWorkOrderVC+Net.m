//
//  TheNewWorkOrderVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheNewWorkOrderVC.h"
#import "LicenseInformationVC.h"
#import "FillInformationViewController.h"

@implementation TheNewWorkOrderVC (Net)

-(void)postNetWorkOrder_user:(NSString *)mobile WithName:(NSString *)name{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:mobile forKey:@"mobile"];
    [mDict setObject:name forKey:@"realname"];
    if (self.shiFouZhuCe == YES) {
        
        if (self.userInformetionDict) {
            NSDictionary *users_details2 = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
            [mDict setObject:KISDictionaryHaveKey(users_details2, @"user_id") forKey:@"user_id"];
        }else
        {
            [mDict setObject:@"" forKey:@"user_id"];
        }
        
    }else
    {
        NSDictionary *users_details = KISDictionaryHaveKey(self.postDict, @"users_details");
        
        if ([users_details isKindOfClass:[NSDictionary  class]]) {
            [mDict setObject:KISDictionaryHaveKey(users_details, @"user_id") forKey:@"user_id"];
        }else
        {
            if (self.userInformetionDict) {
                NSDictionary *users_details2 = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
                [mDict setObject:KISDictionaryHaveKey(users_details2, @"user_id") forKey:@"user_id"];
            }else
            {
                [mDict setObject:KISDictionaryHaveKey(users_details, @"user_id") forKey:@"user_id"];
            }
        }
        
        
    }
    
    if (self.shiFouQiYe == YES) {
        [mDict setObject:@1 forKey:@"is_unit"];
    }else
    {
        [mDict setObject:@0 forKey:@"is_unit"];
    }
    NSString *pingJIeStr = @"";
    
    Users_carsModel *zhuModel;
    for (int i = 0; i< xinZengArray.count; i++) {
        Users_carsModel *model2 = xinZengArray[i];
        if (model2.shifouXuanZHong == YES) {
            zhuModel = model2;
        }
    }
    
    self.zuiZhongModel.unit_full_name = [NSString stringWithFormat:@"%@",zhuModel.unit_full_name];
    
    
    
    if (zhuModel.shiFouXinZeng == YES) {
        pingJIeStr = [NSString  stringWithFormat:@",%@,%@,%@,%@,%@,add",zhuModel.brands,zhuModel.trainSystem,zhuModel.models,zhuModel.modelsId,zhuModel.car_number];
        [mDict setObject:pingJIeStr forKey:@"cars_detail"];
    }
    
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_user" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        weakSelf.zuiZhongModel.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"user_id")];
        weakSelf.zuiZhongModel.target_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"car_id")];
        
        if (zhuModel.shiFouXinZeng == YES) {
            zhuModel.car_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"car_id")];
        }else{
            weakSelf.zuiZhongModel.target_id = zhuModel.car_id;
        }
        
        if (zhuModel.shiFouXinZeng == YES) {
            LicenseInformationVC *vc = [[LicenseInformationVC alloc]init];
            vc.zhuModel = zhuModel;
            vc.zuiZhongModel = weakSelf.zuiZhongModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else
        {
            [weakSelf getRequest_methodWith:zhuModel];
        }
        
    } failure:^(id error) {
        
    }];
}

-(void)getRequest_methodWith:(Users_carsModel *)zhuModel
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:zhuModel.car_id forKey:@"target_id"];
    [self showOrHideLoadView:YES];
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/repair_order/cars_license/",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"get参数%@\n返回：%@",zhuModel.car_id,parserDict);
        
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        if (code == 205) {
            LicenseInformationVC *vc = [[LicenseInformationVC alloc]init];
            vc.zhuModel = zhuModel;
            vc.zuiZhongModel = weakSelf.zuiZhongModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            
            return ;
        }
        NSDictionary *license_info = KISDictionaryHaveKey(adData, @"license_info");
        if (code == 200  && ([license_info isKindOfClass:[NSDictionary class]])) {
            
            
            FillInformationViewController *vc = [[FillInformationViewController alloc]init];
            vc.chuanZhiDict = [[XinShiZheng_carsModel alloc]init];
            vc.chuanZhiDict.images = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(license_info, @"images")];
            vc.chuanZhiDict.cartype = [KISDictionaryHaveKey(license_info, @"cartype") integerValue];
            vc.chuanZhiDict.carvin = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(license_info, @"carvin")];
            vc.chuanZhiDict.color = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(license_info, @"color")];
            vc.chuanZhiDict.engine_number = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(license_info, @"engine_number")];
            vc.chuanZhiDict.issue_date = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(license_info, @"issue_date")];
            vc.chuanZhiDict.register_date = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(license_info, @"register_date")];
            vc.zhuModel = zhuModel;
            vc.zuiZhongModel = weakSelf.zuiZhongModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            LicenseInformationVC *vc = [[LicenseInformationVC alloc]init];
            vc.zhuModel = zhuModel;
            vc.zuiZhongModel = weakSelf.zuiZhongModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];

}

-(void)quDiaoHuiYuanKa
{
//    [jiBenArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        TheNewWorkOrderModel *dict = (TheNewWorkOrderModel *)obj;
//        if ([dict.name isEqualToString:@"3"]) {
//            [jiBenArray removeObject:obj];
//        }
//    }];
//
//    for (int i = 0; i<jiBenArray.count; i++) {
//        TheNewWorkOrderModel *dict = jiBenArray[i];
//        if ([dict.name isEqualToString:@"会员卡"]) {
//            [jiBenArray removeObject:dict];
//        }
//    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i<jiBenArray.count; i++) {
        TheNewWorkOrderModel *dict = jiBenArray[i];
        if (![dict.name isEqualToString:@"会员卡"]) {
            [array addObject:dict];
        }
    }
    
    [jiBenArray removeAllObjects];
    for (int i = 0; i<array.count; i++) {
        [jiBenArray addObject:array[i]];
    }
}

-(void)postNetWorkPhone:(NSString *)mobile{
    self.shiFouQiYe = NO;
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:mobile forKey:@"mobile"];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store_user/users/mobile" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 202) {
            weakSelf.shiFouZhuCe = YES;
            [xinZengArray removeAllObjects];
            [couponsArray removeAllObjects];
            
            [weakSelf quDiaoHuiYuanKa];
            
            for (int i = 0; i<5; i++) {
                TheNewWorkOrderModel *dict = jiBenArray[i];
                if (i==0) {
                    dict.textName = phoneTextField.text;
                }else if (i==1) {
                    dict.textName = @"";
                }else if (i==2) {
                    dict.textName = @"";
                }else  if (i==3) {
                    dict.textName = phoneTextField.text;
                }else{
                    dict.textName = @"";
                }
            }
            
        }else if([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200)
        {
            NSDictionary* dataDic = kParseData(responseObject);
            if (![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            
            [couponsArray removeAllObjects];
            [weakSelf quDiaoHuiYuanKa];
            
            weakSelf.shiFouZhuCe = NO;
            weakSelf.postDict = dataDic;
            NSDictionary *deliverer = KISDictionaryHaveKey(weakSelf.postDict, @"deliverer");
            NSDictionary *users_details = KISDictionaryHaveKey(weakSelf.postDict, @"users_details");
            NSArray *users_cars = KISDictionaryHaveKey(weakSelf.postDict, @"users_cars");
            [xinZengArray removeAllObjects];
            if (users_cars.count>0) {
                for (int i = 0; i<users_cars.count; i++) {
                    Users_carsModel *model = [[Users_carsModel alloc]init];
                    [model setdataWithDict:users_cars[i]];
                    [xinZengArray addObject:model];
                }
            }
            
            if ([KISDictionaryHaveKey(users_details, @"is_unit") integerValue] == 0) {
                weakSelf.shiFouQiYe = NO;
            }else
            {
                weakSelf.shiFouQiYe = YES;
            }
            
            for (int i = 0; i<5; i++) {
                TheNewWorkOrderModel *dict = jiBenArray[i];
                if (i==0) {
                    dict.textName = KISDictionaryHaveKey(users_details, @"mobile");
                }else if (i==1) {
                    dict.textName = KISDictionaryHaveKey(users_details, @"realname");
                }else if (i==2) {
                    dict.textName = KISDictionaryHaveKey(users_details, @"unit_full_name");
                }else  if (i==3) {
                    NSString *users_detailsmobile = KISDictionaryHaveKey(users_details, @"mobile");
                    if (users_detailsmobile.length<=0) {
                        dict.textName = KISDictionaryHaveKey(users_details, @"mobile");
                    }else{
                        dict.textName = KISDictionaryHaveKey(deliverer, @"mobile");
                    }
                    
                }else{
                    dict.textName = KISDictionaryHaveKey(deliverer, @"realname");
                }
            }
            
            
            NSArray *cards_info = KISDictionaryHaveKey(weakSelf.postDict, @"cards_info");
            if (cards_info.count>0) {
                for (int i = 0; i<cards_info.count; i++) {
                    [couponsArray addObject:cards_info[i]];
                }
                
                TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
                dict.textName = @"";
                dict.name = @"会员卡";
                [jiBenArray addObject:dict];
            }
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }
        [weakSelf.main_tabelView reloadData];
    } failure:^(id error) {
        
    }];
}

@end
