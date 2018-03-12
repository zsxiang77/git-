//
//  ViewPerfectInformationVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ViewPerfectInformationVC.h"

@implementation ViewPerfectInformationVC (Net)


-(void)postInspect_detail
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.ordercode forKey:@"ordercode"];

    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/inspect_ios" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        weakSelf.mainDict = dataDic;
        [weakSelf updateUI];
        NSArray *listArray = KISDictionaryHaveKey(dataDic, @"list");

        if ([listArray isKindOfClass:[NSArray class]]) {
            [weakSelf.listArray removeAllObjects];
            for (int i = 0; i<listArray.count; i++) {
                ViewPerfectInformationModel *model = [[ViewPerfectInformationModel alloc]init];
                [model setdataWithDict:listArray[i]];
                [weakSelf.listArray addObject:model];
            }
            [weakSelf.mainTableView reloadData];

        }else{
            return ;
        }
    } failure:^(id error) {

    }];
}

@end
