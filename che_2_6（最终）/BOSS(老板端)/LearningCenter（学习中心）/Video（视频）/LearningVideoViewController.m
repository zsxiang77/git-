//
//  LearningVideoViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningVideoViewController.h"


#define SHIPINGGAO (kWindowW*472/750)//视频高度

@interface LearningVideoViewController ()


@end

@implementation LearningVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_mainTopTitle = @"视频详情";
    
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*892/750)];
    [self.view addSubview:shangView];
    
    
    _playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.CLwidth, SHIPINGGAO)];
    [shangView addSubview:_playerView];
    
    //重复播放，默认不播放
    _playerView.repeatPlay = YES;
    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    _playerView.isLandscape = YES;
    //全屏是否隐藏状态栏，默认一直不隐藏
    _playerView.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
    //顶部工具条隐藏样式，默认不隐藏
    _playerView.topToolBarHiddenType = TopToolBarHiddenSmall;

//    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
    
   
    
    [self qingQiuLuoBoData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UserInfo shareInstance].shiFouXuanZhuan = YES;
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_playerView destroyPlayer];
    [UserInfo shareInstance].shiFouXuanZhuan = NO;
}



-(LearningVideoModel *)mainModel
{
    if (!_mainModel) {
        _mainModel = [[LearningVideoModel alloc]init];
    }
    return _mainModel;
}

@end
