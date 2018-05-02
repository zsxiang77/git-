//
//  StoreTheDataViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreTheDataViewController.h"

@implementation StoreTheDataViewController (Net)



//人员数据
-(void)getrenyuan_list:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    self.yearStr = [NSString stringWithFormat:@"%@",@""];
    self.mouchStr = [NSString stringWithFormat:@"%@",@""];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [mDict setObject:self.yearStr forKey:@"y"];
    [mDict setObject:self.mouchStr forKey:@"m"];
    [self.renyuanView.mainTable.mj_header endRefreshing];
    [self.renyuanView.mainTable.mj_footer endRefreshing];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/staff_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.renyuanView.zhuanzhiModel removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        
        if (order_list.count>=20) {
            weakSelf.renyuanView.mainTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf getrenyuan_list:NO];
            }];
        }else{
            weakSelf.renyuanView.mainTable.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            listModel *model = [[listModel alloc]init];
            [model setdataDict:order_list[i]];
            [weakSelf.renyuanView.zhuanzhiModel addObject:model];
        }
        [weakSelf.renyuanView.mainTable reloadData];
    } failure:^(id error) {
        
    }];
}

//任务数据
-(void)getTask_status
{
    self.timeStr = [NSString stringWithFormat:@"%@",@""];
    self.dateStr = [NSString stringWithFormat:@"%@",@"2"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.timeStr forKey:@"time"];
    [mDict setObject:self.dateStr forKey:@"date"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/task_status" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        [weakSelf.mainModel setdataDict:dataDic];
        weakSelf.renwuView.zhauModel = weakSelf.mainModel;
        [weakSelf.renwuView.mainTable reloadData];
        
    } failure:^(id error) {
        
    }];
}
//配件数据
-(void)getStore_stock_list:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    self.timeStr = [NSString stringWithFormat:@"%@",@"1521475200"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [mDict setObject:self.timeStr forKey:@"time"];
    [self.peijianView.mainTable.mj_header endRefreshing];
    [self.peijianView.mainTable.mj_footer endRefreshing];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/store_stock_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.peijianView.zhuanzhiModel removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"sale_list");
        
        if (order_list.count>=20) {
            weakSelf.peijianView.mainTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf getrenyuan_list:NO];
            }];
        }else{
            weakSelf.peijianView.mainTable.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            listPeiJianModel *model = [[listPeiJianModel alloc]init];
            [model setdataDict:order_list[i]];
            [weakSelf.peijianView.zhuanzhiModel addObject:model];
        }
        [weakSelf.peijianView.mainTable reloadData];
    } failure:^(id error) {
        
        
    }];
    
}
@end
