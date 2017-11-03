//
//  LineUpTheListVC+NetWork.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/1.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "LineUpTheListVC.h"
#import "MJRefresh.h"

#define kALLTAG  (3000)


@implementation LineUpTheListVC (NetWork)

-(void)postQingQiuSearch:(NSString *)str
{
    [self.seachArray removeAllObjects];
    [self.seachTableView reloadData];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:str forKey:@"query"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_query/search_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            
            
            [weakSelf.seachTableView reloadData];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
            
        }
        
        
    } failure:^(id error) {
        
    }];
}


-(void)setNetworkListWithshuaxin:(BOOL)shuaxin withIndex:(NSInteger)index{
    
    if (shuaxin == YES) {
        page[index] = 1;
    }
    
    [[m_myTableView[index] viewWithTag:kALLTAG + index] removeFromSuperview];

    
    [m_myTableView[index].mj_header  endRefreshing];
    NPrintLog(@"index%ld",(long)index);
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:[self getCommonCookieDictionaryWithIndex:index] withUrl:@"order/order_queue/simple_queue_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (m_myTableView[index].mj_footer != nil) {
            [m_myTableView[index].mj_footer endRefreshing];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (shuaxin == YES) {
            [main_dataArry[index] removeAllObjects];
        }
        
        NSArray *array = KISDictionaryHaveKey(dataDic, @"order_list");
        if (array.count<20) {
            m_myTableView[index].mj_footer = nil;
        }else
        {
            m_myTableView[index].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page[index] ++;
                [weakSelf setNetworkListWithshuaxin:NO withIndex:index];
            }];
        }
        
        for (int i = 0; i<array.count; i++) {
            TheWorkModel *model = [[TheWorkModel alloc]init];
            [model setdataWithDict:array[i]];
            [main_dataArry[index] addObject:model];
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
        if (m_myTableView[index].mj_footer != nil) {
            [m_myTableView[index].mj_footer endRefreshing];
        }
    }];
}

-(void)setShanChuDanTiaoDatawithOrdercodevarchar:(TheWorkModel *)model withIndex:(NSInteger)index{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/order_delete" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            
            [weakSelf rREQUEST_METHODNetwork];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
            
        }
        
        
    } failure:^(id error) {
        
    }];
}


-(void)rEQUEST_METHODsetShanChuDanTiaoDatawithBordercode:(TheWorkModel *)bordercodeModel withAordercode:(TheWorkModel *)aordercodeModel withIndex:(NSInteger)inex{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:bordercodeModel.ordercode forKey:@"bordercode"];
    [mDict setObject:bordercodeModel.queue_id forKey:@"bqueue_id"];
    
    [mDict setObject:aordercodeModel.ordercode forKey:@"aordercode"];
    [mDict setObject:aordercodeModel.queue_id forKey:@"aqueue_id"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/replace" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            [weakSelf showMessageWindowWithTitle:@"修改成功" point:self.view.center delay:2];
            
            [weakSelf  setNetworkListWithshuaxin:YES withIndex:0];
            [weakSelf  setNetworkListWithshuaxin:YES withIndex:inex];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
            
        }
        
    } failure:^(id error) {
        
    }];
}


- (NSMutableDictionary*)getCommonCookieDictionaryWithIndex:(NSInteger )index
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    if (index == 0) {
        [mDict setObject:@0 forKey:@"ctype"];
    }else
    {
        NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
        NSInteger indectype = [KISDictionaryHaveKey(array[index-1], @"channel_id") integerValue];
        [mDict setObject:@(indectype) forKey:@"ctype"];
    }

    
    [mDict setObject:@20 forKey:@"pagesize"];
    [mDict setObject:@(page[index]) forKey:@"page"];
    return mDict;
}

-(void)rREQUEST_METHODNetwork{

    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/order/channels",HOST_URL];
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
        
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            weakSelf.numberDict = adData;
            NSArray *array = KISDictionaryHaveKey(adData, @"channels");
            [weakSelf buildMainViewWitharray:array];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHideLoadView:NO];
    }];

}

@end
