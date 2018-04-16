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
    
    
    [self showOrHideLoadView:YES];
    NSString *path = [NSString stringWithFormat:@"%@user/study/mask_video",HOST_URL];
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
            NSDictionary* dataDic = kParseData(responseObject);
            WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isNoShowNavBar = NO;
            
            vc.webUrl = [NSString stringWithFormat:@"%@?video_id=%@&exam_id=1",KISDictionaryHaveKey(dataDic, @"url"),KISDictionaryHaveKey(dataDic, @"video_id")];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
}

@end
