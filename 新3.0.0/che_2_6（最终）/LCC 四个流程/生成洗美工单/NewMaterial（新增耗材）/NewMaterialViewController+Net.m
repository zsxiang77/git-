//
//  NewMaterialViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "NewMaterialViewController.h"

@implementation NewMaterialViewController (Net)

-(void)postcommods_listWithIndex:(NSInteger )index isShuXin:(BOOL)shuaXin{
    
    
    if (shuaXin == YES) {
        yeMa[index] = 1;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
//    100 维修配件
//    182 车载电器
//    195 美容清洗
//    202 汽车装饰
    if (index == 0) {
        [mDict setObject:@"100" forKey:@"classid"];
    }else if (index == 1) {
        [mDict setObject:@"182" forKey:@"classid"];
    }else if (index == 2) {
        [mDict setObject:@"195" forKey:@"classid"];
    }else if (index == 3) {
        [mDict setObject:@"202" forKey:@"classid"];
    }
    
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)yeMa[index]] forKey:@"p"];
    [mDict setObject:self.zuiZongModel.user_id forKey:@"user_id"];
    [mDict setObject:self.zuiZongModel.spec_id forKey:@"spec_id"];
    [mDict setObject:self.zuiZongModel.targetid forKey:@"target_id"];
    
    for (int i=0; i<4; i++) {
        [main_tableView[i].mj_header endRefreshing];
        [main_tableView[i].mj_footer endRefreshing];
        
    }
    
    
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/commods_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        if (shuaXin == YES) {
            [main_dataArry[index] removeAllObjects];
        }
        
        
        if (([KISDictionaryHaveKey(dataDic, @"p") integerValue] == [KISDictionaryHaveKey(dataDic, @"ptotal") integerValue])||([KISDictionaryHaveKey(dataDic, @"p") integerValue] > [KISDictionaryHaveKey(dataDic, @"ptotal") integerValue])) {
            main_tableView[index].mj_footer = nil;
        }else
        {
            yeMa[index] = [KISDictionaryHaveKey(dataDic, @"p") integerValue]+1;
            main_tableView[index].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf postcommods_listWithIndex:index isShuXin:NO];
            }];
        }
        NSArray *commods = KISDictionaryHaveKey(dataDic, @"commods");
        if (commods.count>0) {
            for (int i = 0; i<commods.count; i++) {
                Service_commods *model = [Service_commods modelWithDictionary:commods[i]];
                model.shiFouKeShan  = YES;
                model.xuanZhong = NO;
                [main_dataArry[index] addObject:model];
            }
        }
        
        [main_tableView[index] reloadData];
        
    } failure:^(id error) {
        
    }];
}

@end
