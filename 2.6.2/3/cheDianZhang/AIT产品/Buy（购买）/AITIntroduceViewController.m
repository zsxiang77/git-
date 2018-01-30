//
//  AITIntroduceViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITIntroduceViewController.h"
#import "BuyAITProductsViewController.h"
#import "HomeRightBottomButton.h"

@interface AITIntroduceViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    HomeRightBottomButton*         m_homeRightBottom;//右下角动画
}

@end

@implementation AITIntroduceViewController
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [m_homeRightBottom animationWithRotation0_10];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"AIT产品介绍" withBackButton:YES];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    UIScrollView *scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    scrView.delegate = self;
    [self.view addSubview:scrView];
    UIImageView *titImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"ait_introduce.jpg")];
    titImageView.frame = CGRectMake(0, 0, kWindowW, kWindowW*5599/750);
    [scrView addSubview:titImageView];
    scrView.contentSize = CGSizeMake(kWindowW,  kWindowW*5599/750);
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, kWindowW*5599/750-100, kWindowW, 60)];
    [bt addTarget:self action:@selector(buyChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [scrView addSubview:bt];
    
    [self buildHomeRightBottom];//右下角图标
    
    //3.拖手势
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    //5.右划手势
    UISwipeGestureRecognizer *swipeRightGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRightGesture.delegate = self;
    swipeRightGesture.direction=UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeRightGesture];
    //5.右划手势
    UISwipeGestureRecognizer *swipeRightGesture2=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRightGesture2.delegate = self;
    swipeRightGesture2.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeRightGesture2];
    
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"0"];
    
}
-(void)handlePanGesture:(UIPanGestureRecognizer *)sender
{

}
//划动手势
-(void)handleSwipeGesture:(UIGestureRecognizer*)sender
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_homeRightBottom animationWithRotation0_10];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [m_homeRightBottom animationWithRotation10_0];
    });
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kTiaoZhuanVinYe] != nil) {
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"1"];
    }else{
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"0"];
    }
}
#pragma mark 右下角图标
- (void)buildHomeRightBottom
{
    m_homeRightBottom = [[HomeRightBottomButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-75, kWindowH-[self getTabBarHeight]-80, 75, 75)];
    m_homeRightBottom.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [m_homeRightBottom setImage:DJImageNamed(@"AIT_gouWuChe") forState:(UIControlStateNormal)];
    [m_homeRightBottom addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.shiFouGouMai == YES) {
        m_homeRightBottom.hidden = YES;
    }
    [self.view addSubview:m_homeRightBottom];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [m_homeRightBottom animationWithRotation0_10];
    });
}
-(void)rightButtonClick:(UIButton *)sender
{
    if ([m_homeRightBottom isShowStatus]) {
        BuyAITProductsViewController *vc = [[BuyAITProductsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [m_homeRightBottom animationWithRotation10_0];
    }
}

-(void)buyChick:(UIButton *)sender
{
    if (self.shiFouGouMai == YES) {
        [self showMessageWindowWithTitle:@"已有订购项目" point:self.view.center delay:1];
    }else{
        BuyAITProductsViewController *vc = [[BuyAITProductsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
