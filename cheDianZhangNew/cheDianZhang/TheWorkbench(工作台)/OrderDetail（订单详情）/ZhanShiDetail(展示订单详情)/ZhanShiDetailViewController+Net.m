//
//  ZhanShiDetailViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ZhanShiDetailViewController.h"

@implementation ZhanShiDetailViewController (Net)

-(void)setrequest_methodwithOrdercodevarchar:(TheWorkModel *)model{
    [self.mainTableView.mj_header endRefreshing];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/queue_order_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        [weakSelf.zhuModel setdataWithDict:dataDic];
        
        WeiXiuZhanShiView *newHeaderViwe = [[WeiXiuZhanShiView alloc]initWithModel:weakSelf.chuanZhiModel withWeiXiuZhanShiModel:weakSelf.zhuModel];
        weakSelf.mainTableView.tableHeaderView = newHeaderViwe;
        [weakSelf.mainTableView reloadData];
       
    } failure:^(id error) {
        
    }];
}

#pragma mark - 配件明细
-(void)postpeiJianMingXiWithModel:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/seller_show_parts" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        [_peiJianMingXiArrayCun removeAllObjects];
        
        if (dataDic.count>0) {
            for (int i = 0; i<dataDic.count; i++) {
                PeiJianListModel *model = [[PeiJianListModel alloc]init];
                [model setDangQIanWIthData:dataDic[i]];
                [_peiJianMingXiArrayCun addObject:model];
            }
        }
        
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}
#pragma mark - 项目明细
-(void)postrequest_methodMingXiWithModel:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/seller_show_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        [_xiangMuMingXiArrayCun removeAllObjects];
        NSArray * orignalArrary = KISDictionaryHaveKey(dataDic, @"orignal");
        if (orignalArrary.count>0) {
            for (int i = 0; i<orignalArrary.count; i++) {
                OrignalModel *model = [[OrignalModel alloc]init];
                [model setDangQIanWIthData:orignalArrary[i]];
                [_xiangMuMingXiArrayCun addObject:model];
            }
        }
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

@end
