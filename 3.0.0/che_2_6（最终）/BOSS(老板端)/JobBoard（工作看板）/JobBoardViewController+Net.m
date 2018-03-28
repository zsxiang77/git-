//
//  JobBoardViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardViewController.h"

@implementation JobBoardViewController (Net)
-(void)postwork_boardwithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        fenYeIndex = 1;
    }
    [[self.mainTableView viewWithTag:4000] removeFromSuperview];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    if (m_menuView.selectTag == 0) {
        [mDict setObject:@"0" forKey:@"status"];
    }else if (m_menuView.selectTag == 1) {
        [mDict setObject:@"1" forKey:@"status"];
    }else{
        [mDict setObject:@"2" forKey:@"status"];
    }
    
    NSString *task_type = @"10";
    if ([self.jiuGongHuiDiaoDict isKindOfClass:[NSDictionary class]]) {
        task_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.jiuGongHuiDiaoDict, @"task_type")];
    }
    
    if (m_headerView.xuanZhongIndex == 0) {
        [mDict setObject:task_type forKey:@"task_type"];
        [mDict setObject:@"" forKey:@"is_urgent"];
        [mDict setObject:@"" forKey:@"is_heavy"];
    }else if (m_headerView.xuanZhongIndex == 1) {
        [mDict setObject:task_type forKey:@"task_type"];
        [mDict setObject:@"1" forKey:@"is_urgent"];
        [mDict setObject:@"" forKey:@"is_heavy"];
    }else{
        [mDict setObject:task_type forKey:@"task_type"];
        [mDict setObject:@"" forKey:@"is_urgent"];
        [mDict setObject:@"1" forKey:@"is_heavy"];
    }
    
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",fenYeIndex] forKey:@"page"];

    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    NPrintLog(@"%@",mDict);

    kWeakSelf(weakSelf)
    [self showOrHideLoadView:YES];
    NSString *path = [NSString stringWithFormat:@"%@user/work_board/board",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if (code == 200) {
            if (shuaX == YES) {
                [weakSelf.mainDataArray removeAllObjects];
            }
            NSDictionary* dataDic = kParseData(responseObject);
            weakSelf.mainDataDict = dataDic;
            
            NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
            
            if (order_list.count>=20) {
                weakSelf.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    fenYeIndex ++;
                    [weakSelf postwork_boardwithShuaXin:NO];
                }];
            }else{
                weakSelf.mainTableView.mj_footer = nil;
            }
            
            for (int i = 0; i<order_list.count; i++) {
                JobBoardModel *model = [[JobBoardModel alloc]init];
                [model setdataWithDict:order_list[i]];
                [weakSelf.mainDataArray addObject:model];
            }
            
            [weakSelf setheaderTitleNumber];
            [weakSelf.mainTableView reloadData];
            
            if(weakSelf.mainDataArray.count<=0)
            {
                UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, kWindowW, 50)];
                cLabel.text = @"暂无数据";
                cLabel.tag = 4000;
                cLabel.textAlignment = NSTextAlignmentCenter;
                cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
                cLabel.font = [UIFont boldSystemFontOfSize:20];
                cLabel.backgroundColor = [UIColor clearColor];
                [weakSelf.mainTableView addSubview:cLabel];
                
            }
            
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
}

-(void)setheaderTitleNumber
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_count")]];
    [array addObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_urgent_count")]];
    [array addObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_heavy_count")]];
    
    [m_headerView setTitleStrWithArrar:array];
}


-(void)postCuiBan:(JobBoardModel *)model
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.task_id forKey:@"task_id"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/work_board/do_unit" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
            [weakSelf showAlertViewWithTitle:nil Message:@"催办成功,五分钟内不可以再次催办" buttonTitle:@"确定"];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
    } failure:^(id error) {
        
    }];
    
}

@end
