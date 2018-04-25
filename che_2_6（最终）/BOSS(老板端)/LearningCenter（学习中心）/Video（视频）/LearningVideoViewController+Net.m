//
//  LearningVideoViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningVideoViewController.h"

@implementation LearningVideoViewController (Net)

-(void)qingQiuLuoBoData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.video_id forKey:@"video_id"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/video_list_type" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showConnectFailView:NO mySEL:nil inView:weakSelf.view startY:0];
        NSDictionary *adData = kParseData(responseObject);/*dataDic[@"data"];*/
        NSArray *adDataArray = KISDictionaryHaveKey(adData, @"list");
        NSString *v_idStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"v_id")];
        if([adData isKindOfClass:[NSDictionary class]]){
            [weakSelf.mainJiShuArray removeAllObjects];
            for (int i = 0; i<adDataArray.count; i++) {
                LearningVideoModel *model = [[LearningVideoModel alloc]init];
                [model setDatashuJu:adDataArray[i]];
                if ([v_idStr isEqualToString:model.video_id]) {
                    model.shiFouXuanZhong = YES;
                    weakSelf.playerView.url = [NSURL URLWithString:model.video_url];
                }
                
                [weakSelf.mainJiShuArray addObject:model];
            }
        }
        
        [weakSelf qingQiuLuoListBoData];
    } failure:^(id error) {
        [weakSelf showConnectFailView:YES mySEL:@selector(qingQiuLuoBoData) inView:weakSelf.view startY:0];
    }];
}

-(void)qingQiuLuoListBoData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.video_id forKey:@"video_id"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/recommend_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showConnectFailView:NO mySEL:nil inView:weakSelf.view startY:0];
        NSDictionary *dataDic = kParseData(responseObject);/*dataDic[@"data"];*/
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        
        
        for (int i = 0; i<order_list.count; i++) {
            LearningModel *model = [[LearningModel alloc]init];
            [model setDatashuJu:order_list[i]];
            [weakSelf.mainListArray addObject:model];
        }
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        [weakSelf showConnectFailView:YES mySEL:@selector(qingQiuLuoListBoData) inView:weakSelf.view startY:0];
    }];
}

//收藏
-(void)postdo_article_praise:(LearningModel *)model withIndex:(NSIndexPath*)index
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.video_id forKey:@"video_id"];
    
    kWeakSelf(weakSelf)
    if([model.user_coll boolValue]==YES){
        [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/del_collection" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            model.likenum = [NSString stringWithFormat:@"%ld",[model.likenum integerValue]-1];
            model.user_coll = @"0";
            [weakSelf.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(id error) {
            
        }];
    }else{
        [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/add_collection" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            model.likenum = [NSString stringWithFormat:@"%ld",[model.likenum integerValue]+1];
            model.user_coll = @"1";
            model.chuanzhiMain=YES;
            [weakSelf.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(id error) {
            
        }];
    }
    
}

@end
