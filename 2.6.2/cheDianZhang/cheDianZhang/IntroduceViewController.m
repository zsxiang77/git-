//
//  IntroduceViewController.m
//  DaJiang365
//
//  Created by shen yan ping on 16/5/13.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import "IntroduceViewController.h"
#import "CheDianZhangCommon.h"

@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, kWindowW, kWindowH);
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kWindowW*4, kWindowH);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    BOOL isBigScreen = (kWindowH>480)?YES:NO;
    UIImageView* image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    image1.image = DJImageNamed(isBigScreen?@"introduce5_1.jpg":@"introduce4_1.jpg");
    image1.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:image1];
    
    UIImageView* image2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    image2.image = DJImageNamed(isBigScreen?@"introduce5_2.jpg":@"introduce4_2.jpg");
    image2.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:image2];
    
    UIImageView* image3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*2, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    image3.image = DJImageNamed(isBigScreen?@"introduce5_3.jpg":@"introduce4_3.jpg");
    image3.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:image3];
    
    UIImageView* image4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*3, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    image4.image = DJImageNamed(isBigScreen?@"introduce5_4.jpg":@"introduce4_4.jpg");
    image4.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:image4];
    
    UIButton* startButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*3, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    [startButton setImage:DJImageNamed(@"ydt_go") forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor clearColor];
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:startButton];

}

// 点击按钮事件
-(void) startButtonClick
{
    /*
     ////////////////显示主页面\\\\\\\\\\\\\\\\\\\\\\\
     */
    //屏蔽掉 新版本介绍
    [[NSUserDefaults standardUserDefaults] setObject:kCurrentVersion forKey:kNewfuctionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate startFirstPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
