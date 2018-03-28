//
//  FoundViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/23.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundViewController.h"

@implementation FoundViewController (Net)

-(void)postrequest_methodDatawithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    [[self.mainTableView viewWithTag:3000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/find_index" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.mainDataArray removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        
        if (order_list.count>=20) {
            weakSelf.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf postrequest_methodDatawithShuaXin:NO];
            }];
        }else{
            weakSelf.mainTableView.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            FoundModel *model = [[FoundModel alloc]init];
            [model setdataWithDict:order_list[i]];
            [weakSelf.mainDataArray addObject:model];
        }
        
        if(weakSelf.mainDataArray.count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 3000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [weakSelf.mainTableView addSubview:cLabel];
            
        }
        
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

-(void)postdo_article_praise:(FoundModel *)model
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.articleid forKey:@"articleid"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/do_article_praise" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        model.praisenum = [NSString stringWithFormat:@"%ld",[model.praisenum integerValue]+1];
        model.is_praise = @"1";
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

@end
