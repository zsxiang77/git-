//
//  TheWorkbenchViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/31.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "LonInViewController.h"

#define kALLTAG  (3000)

@implementation TheWorkbenchViewController (Net)

-(void)rREQUEST_METHODNetwork{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    kWeakSelf(weakSelf)
    [NetWorkManagerGet requestWithParametersGet:mDict withUrl:@"order/order/channels" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 404) {
            NPrintLog(@"msg:%@",KISDictionaryHaveKey(parserDict, @"msg"));
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            weakSelf.numberDict = adData;
            NSArray *array = KISDictionaryHaveKey(adData, @"channels");
            weakSelf.channelsArray = array;
            [weakSelf buildMainViewWitharray:array];
            
            [weakSelf postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
        }
    } failure:^(id error) {
        
    }];
}

-(void)postrequest_methodDataWithIndex:(NSInteger )index withShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        page[index] = 1;
    }
    
    if ([UserInfo shareInstance].isLogined == NO) {
        return;
    }
    
    [[m_myTableView[index] viewWithTag:kALLTAG + index] removeFromSuperview];
    
    NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:KISDictionaryHaveKey(array[index], @"channel_id") forKey:@"ctype"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)page[index]] forKey:@"page"];
    
    if (self.orderDetailShaiXuanView.indexPage == 0) {
        [mDict setObject:@"1" forKey:@"order_status"];
    }else if (self.orderDetailShaiXuanView.indexPage == 1) {
        [mDict setObject:@"7" forKey:@"order_status"];
    }else if (self.orderDetailShaiXuanView.indexPage == 2) {
        [mDict setObject:@"3" forKey:@"order_status"];
    }else if (self.orderDetailShaiXuanView.indexPage == 3) {
        [mDict setObject:@"2" forKey:@"order_status"];
    }
    
    
    if (myListButton.selected == YES) {
        [mDict setObject:@"1" forKey:@"is_relation"];
    }else{
        [mDict setObject:@"0" forKey:@"is_relation"];
    }
    
    [m_myTableView[0].mj_header endRefreshing];
    [m_myTableView[1].mj_header endRefreshing];
    
    [m_myTableView[0].mj_footer endRefreshing];
    [m_myTableView[1].mj_footer endRefreshing];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/order_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [main_dataArry[index] removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"order_list");
        for (int i = 0; i<order_list.count; i++) {
            TheWorkModel *model = [[TheWorkModel alloc]init];
            [model setdataWithDict:order_list[i]];
            [main_dataArry[index] addObject:model];
        }
        
        
        if (order_list.count>=20) {
            m_myTableView[index].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page[index] ++;
                [weakSelf postrequest_methodDataWithIndex:index withShuaXin:NO];
            }];
        }else{
            m_myTableView[index].mj_footer = nil;
        }
        
        
        if(main_dataArry[index].count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = kALLTAG + index;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [m_myTableView[index] addSubview:cLabel];
        }
        
        [m_myTableView[index] reloadData];
    } failure:^(id error) {
        
    }];
}



@end
