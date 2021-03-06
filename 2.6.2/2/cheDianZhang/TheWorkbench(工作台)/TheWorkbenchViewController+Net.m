//
//  TheWorkbenchViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/31.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "LonInViewController.h"
#import "ZhanShiDetailViewController.h"

#define kALLTAG  (3000)

@implementation TheWorkbenchViewController (Net)

-(void)rREQUEST_METHODNetwork{
    
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/order/channels",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NPrintLog(@"task是%@",task);
        [weakSelf showOrHideLoadView:NO];
    }];
    
}

-(void)postrequest_methodDataWithIndex:(NSInteger )index withShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        page[index] = 1;
    }
    [[m_myTableView[index] viewWithTag:kALLTAG + index] removeFromSuperview];
    
    NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:KISDictionaryHaveKey(array[index], @"channel_id") forKey:@"ctype"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)page[index]] forKey:@"page"];
    
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


-(void)postSearchrequest_methodDatawithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        self.searchIndex = 1;
    }
    [[self.seachTableView viewWithTag:kALLTAG + 500] removeFromSuperview];
    [[self.seachTableView viewWithTag:kALLTAG + 501] removeFromSuperview];
    
    NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    if (self.searchText.text.length>0) {
        [mDict setObject:self.searchText.text forKey:@"search"];
    }else{
        return;
    }
    
    [mDict setObject:KISDictionaryHaveKey(array[m_segButtonsView.selectIndex], @"channel_id") forKey:@"ctype"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",self.searchIndex] forKey:@"page"];
    
    if (self.myListSearchButton.selected == YES) {
        [mDict setObject:@"1" forKey:@"is_relation"];
    }else{
        [mDict setObject:@"0" forKey:@"is_relation"];
    }
    
    [self.seachTableView.mj_header endRefreshing];
    [self.seachTableView.mj_header endRefreshing];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/order_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.seachArray removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"order_list");
        for (int i = 0; i<order_list.count; i++) {
            TheWorkModel *model = [[TheWorkModel alloc]init];
            [model setdataWithDict:order_list[i]];
            [weakSelf.seachArray addObject:model];
        }
        
        
        if (order_list.count>=20) {
            weakSelf.seachTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                weakSelf.searchIndex ++;
                [weakSelf postSearchrequest_methodDatawithShuaXin:NO];
            }];
        }else{
            weakSelf.seachTableView.mj_footer = nil;
        }
        
        
        [[self.seachTableView viewWithTag:kALLTAG + 500] removeFromSuperview];
        [[self.seachTableView viewWithTag:kALLTAG + 501] removeFromSuperview];
        if(weakSelf.seachArray.count<=0)
        {
            UIImageView *wuViweImage = [[UIImageView alloc]initWithImage:DJImageNamed(@"seach_wuData")];
            if (KIS_IPHONE_6P) {
                wuViweImage.frame = CGRectMake((kWindowW-173/2)/2, 80, 173/2, 221/2);
            }else{
                wuViweImage.frame = CGRectMake((kWindowW-173/2)/2, 80, 173/3, 221/3);
            }
            
            wuViweImage.tag = kALLTAG + 500;
            [weakSelf.seachTableView addSubview:wuViweImage];
            
            
            UILabel *zhanLabel = [[UILabel alloc]init];
            zhanLabel.font = [UIFont systemFontOfSize:14];
            zhanLabel.tag = kALLTAG + 501;
            zhanLabel.text = @"暂无相关订单";
            [weakSelf.seachTableView addSubview:zhanLabel];
            [zhanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(wuViweImage);
                make.top.mas_equalTo(wuViweImage.mas_bottom).mas_equalTo(10);
            }];
        }
        
        [weakSelf.seachTableView reloadData];
    } failure:^(id error) {
        
    }];
}

-(void)getrequest_methodWithTheWorkModel:(TheWorkModel *)model
{
    [self showOrHideLoadView:YES];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@store_staff/store_set/settings",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            
            return ;
        }
        
        NSDictionary *settings = KISDictionaryHaveKey(adData, @"settings");
        
        if (code == 200) {
            if ([model.status isEqualToString:@"待施工"]) {
                if ([model.class_name isEqualToString:@"维修"]) {
                    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
                    if ([KISDictionaryHaveKey(settings, @"is_hide_button")boolValue]) {
                        vc.shiFouKeXiugai = YES;
                    }else{
                        vc.shiFouKeXiugai = NO;
                    }
                    
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.chuanzhiModel = model;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    XiMeiDetailViewController *vc = [[XiMeiDetailViewController alloc]init];
                    vc.chuanzhiModel = model;
                    vc.anNiuStr = @"施工完成";
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else
            {
                ZhanShiDetailViewController *vc = [[ZhanShiDetailViewController alloc]init];
                vc.chuanZhiModel = model;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
        [[UserInfo shareInstance] showNotNetView];
    }];
    
}


@end
