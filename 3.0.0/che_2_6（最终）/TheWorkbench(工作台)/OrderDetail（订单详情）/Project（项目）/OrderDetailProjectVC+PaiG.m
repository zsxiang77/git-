//
//  OrderDetailProjectVC+PaiG.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailProjectVC.h"

@implementation OrderDetailProjectVC (PaiG)
-(void)postrequest_methodList{
    self.paiGongArray = [[NSMutableArray alloc]init];
    self.xuanZhongPaiGongArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
//    [mDict setObject:self.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/oper_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] != 200) {
            [self showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }else
        {
            [weakSelf.paiGongArray removeAllObjects];
            
            NSArray *works = KISDictionaryHaveKey(dataDic, @"works");
            for (int i = 0; i<works.count; i++) {
                PaiGongModel *model = [[PaiGongModel alloc]init];
                [model setdataWithDict:works[i]];
                [weakSelf.paiGongArray addObject:model];
            }
            weakSelf.orderDetailProjectPGView.chuanZhiArray = weakSelf.paiGongArray;
            weakSelf.orderDetailProjectPGView.hidden = NO;
            [weakSelf.view bringSubviewToFront:weakSelf.orderDetailProjectPGView];
            [weakSelf.orderDetailProjectPGView zhuXianShi];
        }
    } failure:^(id error) {
        
    }];
}

@end
