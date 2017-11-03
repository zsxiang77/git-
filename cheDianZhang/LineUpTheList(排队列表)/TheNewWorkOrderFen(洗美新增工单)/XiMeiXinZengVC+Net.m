//
//  XiMeiXinZengVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiXinZengVC.h"
#import "XiMeiNewOrdersViewController.h"

@implementation XiMeiXinZengVC (Net)

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
                if ([users_details isKindOfClass:[NSDictionary class]]) {
                    [mDict setObject:KISDictionaryHaveKey(users_details, @"user_id") forKey:@"user_id"];
                }else
                {
                    [mDict setObject:@"" forKey:@"user_id"];
                }
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
    if (self.zuiZongModel.shiFoNiMing == NO) {
        for (int i = 0; i< xinZengArray.count; i++) {
            Users_carsModel *model2 = xinZengArray[i];
            if (model2.shifouXuanZHong == YES) {
                zhuModel = model2;
            }
        }
    }else
    {
        for (int i = 0; i< niMingxinZengArray.count; i++) {
            Users_carsModel *model2 = niMingxinZengArray[i];
            if (model2.shifouXuanZHong == YES) {
                zhuModel = model2;
            }
        }
    }
    
    
    
    self.zuiZongModel.spec_id = @"";
    if (zhuModel.shiFouXinZeng == YES) {
        pingJIeStr = [NSString  stringWithFormat:@",%@,%@,%@,%@,%@,add",zhuModel.brands,zhuModel.trainSystem,zhuModel.models,zhuModel.modelsId,zhuModel.car_number];
        [mDict setObject:pingJIeStr forKey:@"cars_detail"];
        self.zuiZongModel.cars_detail = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",zhuModel.brands,zhuModel.trainSystem,zhuModel.models,zhuModel.modelsId,zhuModel.car_number];
        if (self.zuiZongModel.shiFoNiMing == YES) {
            self.zuiZongModel.spec_id = zhuModel.modelsId;
        }
    }
    
    
    self.zuiZongModel.car_number = zhuModel.car_number;
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_user" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        
        if (zhuModel.shiFouXinZeng == YES) {
            zhuModel.car_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"car_id")];
        }
        
        weakSelf.zuiZongModel.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"user_id")];
        weakSelf.zuiZongModel.targetid = zhuModel.car_id;
        
        
        XiMeiNewOrdersViewController *vc = [[XiMeiNewOrdersViewController alloc]init];
        vc.zuiZongModel = weakSelf.zuiZongModel;
        vc.zhuModel = zhuModel;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    } failure:^(id error) {
        
    }];
}


-(void)postNetWorkPhone:(NSString *)mobile{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:mobile forKey:@"mobile"];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store_user/users/mobile" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 202) {
            weakSelf.shiFouZhuCe = NO;
            for (int i = 0; i<2; i++) {
                TheNewWorkOrderModel *dict = jiBenArray[i];
                if (i==0) {
                    dict.textName = phoneTextField.text;
                }else if (i==1) {
                    dict.textName = @"";
                }
            }
        }else
        {
            NSDictionary* dataDic = kParseData(responseObject);
            if (![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            weakSelf.shiFouZhuCe = YES;
            weakSelf.postDict = dataDic;
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
            
            for (int i = 0; i<2; i++) {
                TheNewWorkOrderModel *dict = jiBenArray[i];
                if (i==0) {
                    dict.textName = KISDictionaryHaveKey(users_details, @"mobile");
                }else if (i==1) {
                    dict.textName = KISDictionaryHaveKey(users_details, @"realname");
                }
            }
            
            [couponsArray removeAllObjects];
            NSArray *cards_info = KISDictionaryHaveKey(weakSelf.postDict, @"cards_info");
            if (cards_info.count>0) {
                for (int i = 0; i<cards_info.count; i++) {
                    [couponsArray addObject:cards_info[i]];
                }
                
                TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
                dict.textName = @"";
                dict.name = @"会员卡";
                [jiBenArray addObject:dict];
            }else
            {
                for (int i = 0; i<jiBenArray.count; i++) {
                    TheNewWorkOrderModel *dict = jiBenArray[i];
                    if ([dict.name isEqualToString:@"会员卡"]) {
                        [jiBenArray removeObject:dict];
                    }
                }
            }
            
            
        }
        [weakSelf.main_tabelView reloadData];
    } failure:^(id error) {
        
    }];
}



@end
