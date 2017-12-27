//
//  FillInformationViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillInformationViewController.h"
#import "FillInforMationErVC.h"

@implementation FillInformationViewController (Net)

-(void)postShangChuanTuPianWithImage:(NSArray *)ims
{
    kWeakSelf(weakSelf)
    [NetWorkManager requestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:@"order/order_queue/upload_file" viewController:self isShowLoading:YES withimage:ims success:^(id responseObject) {
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        
        [weakSelf postZuiHouQueRenQingQiuWithImage:KISDictionaryHaveKey(adData, @"name")];
        
    } failure:^(id error) {
        
    }];
}

-(void)postZuiHouQueRenQingQiuWithImage:(NSString *)image
{

    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:image forKey:@"images"];
    [mDict setObject:self.zhuModel.car_id forKey:@"target_id"];
    [mDict setObject:self.chuanZhiDict.owner forKey:@"owner"];
    [mDict setObject:self.chuanZhiDict.address forKey:@"address"];
    [mDict setObject:self.chuanZhiDict.use_character forKey:@"use_character"];
    [mDict setObject:self.chuanZhiDict.model forKey:@"model"];
    [mDict setObject:self.chuanZhiDict.issue_date forKey:@"issue_date"];
    [mDict setObject:self.chuanZhiDict.register_date forKey:@"register_date"];
    [mDict setObject:self.chuanZhiDict.carvin forKey:@"carvin"];
    [mDict setObject:self.chuanZhiDict.engine_number forKey:@"engine_number"];
    [mDict setObject:self.chuanZhiDict.carno forKey:@"carno"];
    [mDict setObject:@(self.chuanZhiDict.cartype) forKey:@"cartype"];
    [mDict setObject:self.chuanZhiDict.color forKey:@"color"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/cars_license" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        FillInforMationErVC *vc = [[FillInforMationErVC alloc]init];
        vc.zuiZhongModel = weakSelf.zuiZhongModel;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    } failure:^(id error) {
        
    }];
    
}

@end
