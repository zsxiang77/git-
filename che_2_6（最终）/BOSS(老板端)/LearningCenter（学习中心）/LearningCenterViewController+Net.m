//
//  LearningCenterViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningCenterViewController.h"

@implementation LearningCenterViewController (Net)

-(void)qingQiuLuoBoData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/banner" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray *adDatas = kParseData(responseObject);/*dataDic[@"data"];*/
        if([adDatas isKindOfClass:[NSArray class]]){
            weakSelf.adDatas = [[NSMutableArray alloc] initWithArray:adDatas];
            [weakSelf buildAdView];
        }
    } failure:^(id error) {
        
    }];
}

-(void)postrequest_methodDatawithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    [[self.main_tableView viewWithTag:3000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    [self.main_tableView.mj_header endRefreshing];
    [self.main_tableView.mj_footer endRefreshing];
    
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/video_list_index" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.mainListArray removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        
        if (order_list.count>=20) {
            weakSelf.main_tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf postrequest_methodDatawithShuaXin:NO];
            }];
        }else{
            weakSelf.main_tableView.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            LearningModel *model = [[LearningModel alloc]init];
            [model setDatashuJu:order_list[i]];
            [weakSelf.mainListArray addObject:model];
        }
        
        if(weakSelf.mainListArray.count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 3000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [weakSelf.main_tableView addSubview:cLabel];
            
        }
        
        [weakSelf.main_tableView reloadData];
    } failure:^(id error) {
        
    }];
}
//收藏
-(void)postdo_article_praise:(LearningModel *)model withIndex:(NSIndexPath*)index;
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.video_id forKey:@"video_id"];
    
    kWeakSelf(weakSelf)
    if([model.user_coll boolValue]==YES){
        [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/del_collection" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            model.likenum = [NSString stringWithFormat:@"%ld",[model.likenum integerValue]-1];
            model.user_coll = @"0";
            [weakSelf.main_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(id error) {
            
        }];
    }else{
        [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/add_collection" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            model.likenum = [NSString stringWithFormat:@"%ld",[model.likenum integerValue]+1];
            model.user_coll = @"1";
            model.chuanzhiMain=YES;
            [weakSelf.main_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(id error) {
            
        }];
    }
   
}
@end
