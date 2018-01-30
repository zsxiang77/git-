//
//  ModelCarViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ModelCarViewController.h"
#import "NetWorkManagerGet.h"
#import "ErMenModel.h"

@implementation ModelCarViewController (Net)

-(void)getReMenNetWork{
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/order/hot_brands",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSArray *adData = kParseData(responseObject);
        if((![adData isKindOfClass:[NSArray class]])|| (adData.count<=0)){
            return;
        }
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i = 0; i<adData.count; i++) {
            ErMenModel *model = [[ErMenModel alloc]init];
            [model setdataWithDict:adData[i]];
            [array addObject:model];
        }
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:array forKey:@"array"];//热门key
        [dict setObject:@"热门品牌" forKey:@"name"];
        
        [weakSelf.zhuArray addObject:dict];
        
        if (weakSelf.huanCunArray.count>0) {
            NSMutableArray  *fenLeiArray[26];
            for (int i = 0; i<26; i++) {
                fenLeiArray[i] = [[NSMutableArray alloc]init];
                switch (i) {
                    case 0:
                    {
                        [weakSelf setDataWIthKey:@"A" withArray:weakSelf.huanCunArray];
                    }
                        break;case 1:
                    {
                        [weakSelf setDataWIthKey:@"B" withArray:weakSelf.huanCunArray];
                    }
                        break;case 2:
                    {
                        [weakSelf setDataWIthKey:@"C" withArray:weakSelf.huanCunArray];
                    }
                        break;case 3:
                    {
                        [weakSelf setDataWIthKey:@"D" withArray:weakSelf.huanCunArray];
                    }
                        break;case 4:
                    {
                        [weakSelf setDataWIthKey:@"E" withArray:weakSelf.huanCunArray];
                    }
                        break;case 5:
                    {
                        [weakSelf setDataWIthKey:@"F" withArray:weakSelf.huanCunArray];
                    }
                        break;case 6:
                    {
                        [weakSelf setDataWIthKey:@"G" withArray:weakSelf.huanCunArray];
                    }
                        break;case 7:
                    {
                        [weakSelf setDataWIthKey:@"H" withArray:weakSelf.huanCunArray];
                    }
                        break;case 8:
                    {
                        [weakSelf setDataWIthKey:@"I" withArray:weakSelf.huanCunArray];
                    }
                        break;case 9:
                    {
                        [weakSelf setDataWIthKey:@"J" withArray:weakSelf.huanCunArray];
                    }
                        break;case 10:
                    {
                        [weakSelf setDataWIthKey:@"K" withArray:weakSelf.huanCunArray];
                    }
                        break;case 11:
                    {
                        [weakSelf setDataWIthKey:@"L" withArray:weakSelf.huanCunArray];
                    }
                        break;case 12:
                    {
                        [weakSelf setDataWIthKey:@"M" withArray:weakSelf.huanCunArray];
                    }
                        break;case 13:
                    {
                        [weakSelf setDataWIthKey:@"N" withArray:weakSelf.huanCunArray];
                    }
                        break;case 14:
                    {
                        [weakSelf setDataWIthKey:@"O" withArray:weakSelf.huanCunArray];
                    }
                        break;case 15:
                    {
                        [weakSelf setDataWIthKey:@"P" withArray:weakSelf.huanCunArray];
                    }
                        break;case 16:
                    {
                        [weakSelf setDataWIthKey:@"Q" withArray:weakSelf.huanCunArray];
                    }
                        break;case 17:
                    {
                        [weakSelf setDataWIthKey:@"R" withArray:weakSelf.huanCunArray];
                    }
                        break;case 18:
                    {
                        [weakSelf setDataWIthKey:@"S" withArray:weakSelf.huanCunArray];
                    }
                        break;case 19:
                    {
                        [weakSelf setDataWIthKey:@"T" withArray:weakSelf.huanCunArray];
                    }
                        break;case 20:
                    {
                        [weakSelf setDataWIthKey:@"U" withArray:weakSelf.huanCunArray];
                    }
                        break;case 21:
                    {
                        [weakSelf setDataWIthKey:@"V" withArray:weakSelf.huanCunArray];
                    }
                        break;case 22:
                    {
                        [weakSelf setDataWIthKey:@"W" withArray:weakSelf.huanCunArray];
                    }
                        break;case 23:
                    {
                        [weakSelf setDataWIthKey:@"X" withArray:weakSelf.huanCunArray];
                    }
                        break;case 24:
                    {
                        [weakSelf setDataWIthKey:@"Y" withArray:weakSelf.huanCunArray];
                    }
                        break;case 25:
                    {
                        [weakSelf setDataWIthKey:@"Z" withArray:weakSelf.huanCunArray];
                    }
                        
                    default:
                        break;
                }
            }
            [weakSelf.main_tabelView reloadData];
        }else{
            [weakSelf postcars_brand];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHideLoadView:NO];
    }];
}

-(void)postcars_brand{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/cars_brand" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray *adData = kParseData(responseObject);
        if((![adData isKindOfClass:[NSArray class]])|| (adData.count<=0)){
            return;
        }
        [weakSelf saveuserCheXXi:adData];
        
        NSMutableArray  *fenLeiArray[26];
        for (int i = 0; i<26; i++) {
            fenLeiArray[i] = [[NSMutableArray alloc]init];
            switch (i) {
                case 0:
                {
                   [weakSelf setDataWIthKey:@"A" withArray:adData];
                }
                    break;case 1:
                {
                    [weakSelf setDataWIthKey:@"B" withArray:adData];
                }
                    break;case 2:
                {
                    [weakSelf setDataWIthKey:@"C" withArray:adData];
                }
                    break;case 3:
                {
                    [weakSelf setDataWIthKey:@"D" withArray:adData];
                }
                    break;case 4:
                {
                    [weakSelf setDataWIthKey:@"E" withArray:adData];
                }
                    break;case 5:
                {
                    [weakSelf setDataWIthKey:@"F" withArray:adData];
                }
                    break;case 6:
                {
                    [weakSelf setDataWIthKey:@"G" withArray:adData];
                }
                    break;case 7:
                {
                    [weakSelf setDataWIthKey:@"H" withArray:adData];
                }
                    break;case 8:
                {
                    [weakSelf setDataWIthKey:@"I" withArray:adData];
                }
                    break;case 9:
                {
                    [weakSelf setDataWIthKey:@"J" withArray:adData];
                }
                    break;case 10:
                {
                    [weakSelf setDataWIthKey:@"K" withArray:adData];
                }
                    break;case 11:
                {
                    [weakSelf setDataWIthKey:@"L" withArray:adData];
                }
                    break;case 12:
                {
                    [weakSelf setDataWIthKey:@"M" withArray:adData];
                }
                    break;case 13:
                {
                    [weakSelf setDataWIthKey:@"N" withArray:adData];
                }
                    break;case 14:
                {
                    [weakSelf setDataWIthKey:@"O" withArray:adData];
                }
                    break;case 15:
                {
                    [weakSelf setDataWIthKey:@"P" withArray:adData];
                }
                    break;case 16:
                {
                    [weakSelf setDataWIthKey:@"Q" withArray:adData];
                }
                    break;case 17:
                {
                    [weakSelf setDataWIthKey:@"R" withArray:adData];
                }
                    break;case 18:
                {
                    [weakSelf setDataWIthKey:@"S" withArray:adData];
                }
                    break;case 19:
                {
                    [weakSelf setDataWIthKey:@"T" withArray:adData];
                }
                    break;case 20:
                {
                    [weakSelf setDataWIthKey:@"U" withArray:adData];
                }
                    break;case 21:
                {
                    [weakSelf setDataWIthKey:@"V" withArray:adData];
                }
                    break;case 22:
                {
                    [weakSelf setDataWIthKey:@"W" withArray:adData];
                }
                    break;case 23:
                {
                    [weakSelf setDataWIthKey:@"X" withArray:adData];
                }
                    break;case 24:
                {
                    [weakSelf setDataWIthKey:@"Y" withArray:adData];
                }
                    break;case 25:
                {
                    [weakSelf setDataWIthKey:@"Z" withArray:adData];
                }
   
                default:
                    break;
            }
        }
        
        [weakSelf.main_tabelView reloadData];
        
        
    } failure:^(id error) {
        
    }];
}

-(void)setDataWIthKey:(NSString *)key withArray:(NSArray *)array
{
    NSMutableArray *newArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<array.count; i++) {
        ErMenModel *model = [[ErMenModel alloc]init];
        [model setdataWithDict:array[i]];
        if ([key isEqualToString:model.bfirstletter]) {
            [newArray addObject:model];
        }
    }
    if (newArray.count>0) {
        NSMutableArray *arra2 = [[NSMutableArray alloc]init];
        for (int i = 0; i<newArray.count-1; i++) {
            [arra2 addObject:newArray[i+1]];
        }
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:arra2 forKey:@"array"];
        [dict setObject:key forKey:@"name"];
        [self.zhuArray addObject:dict];
    }
}


@end
