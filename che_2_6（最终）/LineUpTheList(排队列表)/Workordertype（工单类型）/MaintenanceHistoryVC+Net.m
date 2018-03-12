//
//  MaintenanceHistoryVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "MaintenanceHistoryVC.h"

@implementation MaintenanceHistoryVC (Net)

-(void)postWeiXiuXiangMuQingQiuWithShuXin:(BOOL)shuaXin
{
    if (shuaXin == YES) {
        pageIndex[0] = 1;
    }
    [[main_tableView[0] viewWithTag:4000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:self.user_id forKey:@"user_id"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",pageIndex[0]] forKey:@"page"];
    
    [main_tableView[0].mj_header endRefreshing];
    [main_tableView[0].mj_footer endRefreshing];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/new_order/repair_history_subject" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaXin == YES) {
            [m_dateArray[0] removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"subject");
        for (int i = 0; i<order_list.count; i++) {
            [m_dateArray[0] addObject:order_list[i]];
        }
        
        
        if (order_list.count>=20) {
            main_tableView[0].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                pageIndex[0] ++;
                [weakSelf postWeiXiuXiangMuQingQiuWithShuXin:NO];
            }];
        }else{
            main_tableView[0].mj_footer = nil;
        }
        
        
        if(m_dateArray[0].count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 4000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [main_tableView[0] addSubview:cLabel];
            
        }
        
        [main_tableView[0] reloadData];
    } failure:^(id error) {
        
    }];
}
-(void)postWeiXiuPeiJianQingQiuWithShuXin:(BOOL)shuaXin{
    if (shuaXin == YES) {
        pageIndex[1] = 1;
    }
    [[main_tableView[1] viewWithTag:4000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:self.user_id forKey:@"user_id"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",pageIndex[1]] forKey:@"page"];
    
    [main_tableView[1].mj_header endRefreshing];
    [main_tableView[1].mj_footer endRefreshing];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/new_order/repair_history_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaXin == YES) {
            [m_dateArray[1] removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"subject");
        for (int i = 0; i<order_list.count; i++) {
            [m_dateArray[1] addObject:order_list[i]];
        }
        
        
        if (order_list.count>=20) {
            main_tableView[1].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                pageIndex[1] ++;
                [weakSelf postWeiXiuPeiJianQingQiuWithShuXin:NO];
            }];
        }else{
            main_tableView[1].mj_footer = nil;
        }
        
        
        if(m_dateArray[1].count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 4000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [main_tableView[1] addSubview:cLabel];
            
        }
        
        [main_tableView[1] reloadData];
    } failure:^(id error) {
        
    }];
}

-(void)postXiMeiXiangMuQingQiuWithShuXin:(BOOL)shuaXin
{
    if (shuaXin == YES) {
        pageIndex[0] = 1;
    }
    [[main_tableView[0] viewWithTag:4000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:self.user_id forKey:@"user_id"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",pageIndex[0]] forKey:@"page"];
    
    [main_tableView[0].mj_header endRefreshing];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/new_order/wash_history_subject" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaXin == YES) {
            [m_dateArray[0] removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"subject");
        for (int i = 0; i<order_list.count; i++) {
            [m_dateArray[0] addObject:order_list[i]];
        }
        
        
        if (order_list.count>=20) {
            main_tableView[0].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                pageIndex[0] ++;
                [weakSelf postWeiXiuXiangMuQingQiuWithShuXin:NO];
            }];
        }else{
            main_tableView[0].mj_footer = nil;
        }
        
        
        if(m_dateArray[0].count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 4000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [main_tableView[0] addSubview:cLabel];
            
        }
        
        [main_tableView[0] reloadData];
    } failure:^(id error) {
        
    }];
}
-(void)postXiMeiPeiJianQiuWithShuXin:(BOOL)shuaXin{
    if (shuaXin == YES) {
        pageIndex[1] = 1;
    }
    [[main_tableView[1] viewWithTag:4000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:self.user_id forKey:@"user_id"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",pageIndex[1]] forKey:@"page"];
    
    [main_tableView[1].mj_header endRefreshing];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/new_order/wash_history_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaXin == YES) {
            [m_dateArray[1] removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"subject");
        for (int i = 0; i<order_list.count; i++) {
            [m_dateArray[1] addObject:order_list[i]];
        }
        
        
        if (order_list.count>=20) {
            main_tableView[1].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                pageIndex[1] ++;
                [weakSelf postWeiXiuPeiJianQingQiuWithShuXin:NO];
            }];
        }else{
            main_tableView[1].mj_footer = nil;
        }
        
        
        if(m_dateArray[1].count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 4000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [main_tableView[1] addSubview:cLabel];
            
        }
        
        [main_tableView[1] reloadData];
    } failure:^(id error) {
        
    }];
}

@end
