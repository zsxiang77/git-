//
//  UserPersonalDataVC+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/20.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "UserPersonalDataVC.h"

@implementation UserPersonalDataVC (Net)
-(void)postwork_boardwithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        fenYeIndex = 1;
    }
    [[self.mainTableView viewWithTag:4000] removeFromSuperview];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",fenYeIndex] forKey:@"page"];
    
    [mDict setObject:@"" forKey:@"is_unit"];
    if (m_scrollPageView.selectIndex == 0) {
        [mDict setObject:@"" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 1) {
        [mDict setObject:@"0" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 2) {
        [mDict setObject:@"1" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 3) {
        [mDict setObject:@"2" forKey:@"consume_type"];
    }else if (m_scrollPageView.selectIndex == 4) {
        [mDict setObject:@"3" forKey:@"consume_type"];
    }else{
        [mDict setObject:@"4" forKey:@"consume_type"];
    }
    
     [mDict setObject:@"1" forKey:@"role_id"];
    
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@user/ucenter/consume_list",HOST_URL];
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
            [NetWorkManager loginAgain:weakSelf];
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
                TheCustomerModel *model = [[TheCustomerModel alloc]init];
                [model setdataWithDict:order_list[i]];
                [weakSelf.mainDataArray addObject:model];
            }
            
            if(weakSelf.mainDataArray.count<=0)
            {
                UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
                cLabel.text = @"暂无数据";
                cLabel.tag = 4000;
                cLabel.textAlignment = NSTextAlignmentCenter;
                cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
                cLabel.font = [UIFont boldSystemFontOfSize:20];
                cLabel.backgroundColor = [UIColor clearColor];
                [weakSelf.mainTableView addSubview:cLabel];
                
            }
            [weakSelf setheaderTitleNumber];
            [weakSelf.mainTableView reloadData];
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
    NSString *A_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"A_count")];
    NSString *B_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"B_count")];
    NSString *C_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"C_count")];
    NSString *D_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"D_count")];
    NSString *all_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_count")];
    NSString *loss_count = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"loss_count")];
    [array addObject:all_count];
    [array addObject:A_count];
    [array addObject:B_count];
    [array addObject:C_count];
    [array addObject:D_count];
    [array addObject:loss_count];
    [m_scrollPageView reloadTitlesWithNewTitles:array];
}

@end
