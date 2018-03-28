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
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/video_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showConnectFailView:NO mySEL:nil inView:weakSelf.view startY:0];
        NSDictionary *adData = kParseData(responseObject);/*dataDic[@"data"];*/
        if([adData isKindOfClass:[NSDictionary class]]){
            [weakSelf.mainModel setDatashuJu:KISDictionaryHaveKey(adData, @"info")];
        }
        //视频地址
        weakSelf.playerView.url = [NSURL URLWithString:weakSelf.mainModel.video_url];
    } failure:^(id error) {
        [weakSelf showConnectFailView:YES mySEL:@selector(qingQiuLuoBoData) inView:weakSelf.view startY:0];
    }];
}

@end
