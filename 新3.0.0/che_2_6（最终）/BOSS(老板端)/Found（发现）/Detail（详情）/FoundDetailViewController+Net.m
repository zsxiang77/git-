//
//  FoundDetailViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundDetailViewController.h"

@implementation FoundDetailViewController (Net)

-(void)postfind_article_detail
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanZhiModel.articleid forKey:@"articleid"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/find_article_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        [weakSelf.foundDetailModel setdataWithDict:KISDictionaryHaveKey(dataDic, @"info")];
        [weakSelf.headerView refleshdata:weakSelf.foundDetailModel withBuju:NO];
        weakSelf.mainTableView.tableHeaderView = weakSelf.headerView;
        
    } failure:^(id error) {
        
    }];
}



-(void)postdo_article_praise
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanZhiModel.articleid forKey:@"articleid"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/do_article_praise" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        weakSelf.foundDetailModel.praisenum = [NSString stringWithFormat:@"%ld",[weakSelf.foundDetailModel.praisenum integerValue]+1];
        weakSelf.foundDetailModel.is_praise = @"1";
        [weakSelf.headerView setanniuDianJidata:weakSelf.foundDetailModel];
    } failure:^(id error) {
        
    }];
}

//评论点赞、取消赞
-(void)postdo_comment_praiseWithmodel:(FoundDetailListModel *)model
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.c_id forKey:@"c_id"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/do_comment_praise" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        BOOL sendbo = [model.is_praise boolValue];
        sendbo = !sendbo;
        if (sendbo == YES) {
            model.is_praise = @"1";
            model.praise = [NSString stringWithFormat:@"%ld",[model.praise integerValue]+1];
        }else{
            model.is_praise = @"0";
            model.praise = [NSString stringWithFormat:@"%ld",[model.praise integerValue]-1];
        }
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

//发布评论文章
-(void)postdo_article_comment
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    if ([self.huiFuModel isKindOfClass:[FoundDetailListModel class]]) {
        
        
        [mDict setObject:self.huiFuModel.articleid forKey:@"articleid"];
        
        [mDict setObject:self.faBuTextField.text forKey:@"content"];
        
        [mDict setObject:self.huiFuModel.user_id forKey:@"to_user_id"];
        [mDict setObject:self.huiFuModel.c_id forKey:@"c_id"];
        
        
        [self.faBuTextField resignFirstResponder];
        kWeakSelf(weakSelf)
        [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/do_replay_comment" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            NSInteger codel = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
            if (codel == 200) {
                weakSelf.faBuTextField.text = @"";
                [weakSelf.faBuTextField  resignFirstResponder];
                [weakSelf showMessageWindowWithTitle:@"发布成功" point:weakSelf.view.center delay:1];
                [weakSelf postpingLunLIst:YES];
            }else{
                [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                return;
            }
        } failure:^(id error) {
            
        }];
    }else{
        [mDict setObject:self.chuanZhiModel.articleid forKey:@"articleid"];
        
        [mDict setObject:self.faBuTextField.text forKey:@"content"];
        
        
        [self.faBuTextField resignFirstResponder];
        kWeakSelf(weakSelf)
        [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/do_article_comment" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            NSInteger codel = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
            if (codel == 200) {
                weakSelf.faBuTextField.text = @"";
                [weakSelf.faBuTextField  resignFirstResponder];
                [weakSelf showMessageWindowWithTitle:@"发布成功" point:weakSelf.view.center delay:1];
                [weakSelf postpingLunLIst:YES];
            }else{
                [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                return;
            }
        } failure:^(id error) {
            
        }];
    }
    
}


-(void)postpingLunLIst:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    if (shaiXuanQieHuan == YES) {
        [mDict setObject:@"1" forKey:@"type"];
    }else{
        [mDict setObject:@"2" forKey:@"type"];
    }
    [mDict setObject:self.chuanZhiModel.articleid forKey:@"articleid"];
    
    [self.mainTableView.mj_footer endRefreshing];
    
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/find/get_comment" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.mainListArrar removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        
        if (order_list.count>=20) {
            weakSelf.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf postpingLunLIst:NO];
            }];
        }else{
            weakSelf.mainTableView.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            FoundDetailListModel *model = [[FoundDetailListModel alloc]init];
            [model setdataWithDict:order_list[i]];
            [weakSelf.mainListArrar addObject:model];
        }
        
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

@end

