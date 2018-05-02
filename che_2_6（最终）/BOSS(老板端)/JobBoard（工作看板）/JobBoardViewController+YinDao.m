//
//  JobBoardViewController+YinDao.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardViewController.h"

@implementation JobBoardViewController (YinDao)

//添加引导图
-(void)tianJianYingDaoTu
{
    CGRect frame = CGRectMake(0, 0, kWindowW, kWindowH);
    if (!self.yingDaoScrollView) {
        self.yingDaoScrollView = [[UIScrollView alloc] initWithFrame:frame];
    }
    
    self.yingDaoScrollView.pagingEnabled = YES;
    self.yingDaoScrollView.delegate = self;
    self.yingDaoScrollView.showsHorizontalScrollIndicator = NO;
    self.yingDaoScrollView.contentSize = CGSizeMake(kWindowW*3, kWindowH);
    self.yingDaoScrollView.scrollEnabled = YES;
    self.yingDaoScrollView.bounces = NO;
    self.yingDaoScrollView.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
    [self.view addSubview:self.yingDaoScrollView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.yingDaoScrollView];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
    
    
    for (int i = 0; i<1; i++) {
        UIImageView* image1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.yingDaoScrollView.frame)*i+15, (kWindowH - (kWindowW - 30))/2,kWindowW - 30,kWindowW - 30)];
        image1.image = DJImageNamed(@"yingDao");
        image1.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.yingDaoScrollView addSubview:image1];
        //    kWindowH : 1334 = x:46
        //    1334x = kWindowH 46
        UIButton *guanBi = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.yingDaoScrollView.frame)*i+15, (kWindowH - (kWindowW - 30))/2,kWindowW - 30,kWindowW - 30)];
        [self.yingDaoScrollView addSubview:guanBi];
        
        [guanBi addTarget:self action:@selector(guanBiScrollView:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

-(void)guanBiScrollView:(UIButton *)sender
{
    self.yingDaoScrollView.hidden = YES;
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParametersGET:mDict withUrl:@"user/study/mask_video" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isNoShowNavBar = NO;
        
        vc.webUrl = [NSString stringWithFormat:@"%@?video_id=%@&exam_id=1",KISDictionaryHaveKey(dataDic, @"url"),KISDictionaryHaveKey(dataDic, @"video_id")];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } failure:^(id error) {
        
    }];
    
}

@end
