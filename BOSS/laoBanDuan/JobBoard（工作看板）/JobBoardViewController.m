//
//  JobBoardViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

#import <objc/runtime.h>

@interface JobBoardViewController ()

@end

@implementation JobBoardViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    bt.backgroundColor = [UIColor yellowColor];
    [bt addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bt];
    
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        float viewWidth = CGRectGetWidth(self.view.frame);
        
        UIView *touView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 135+64)];
        
        float groupH = CGRectGetHeight(touView.frame);//30 按钮
        
        _mainTableView = [[UITableView alloc]init];
    }
    return _mainTableView;
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
