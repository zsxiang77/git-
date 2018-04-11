//
//  AppDelegate+BOSS.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "AppDelegate.h"
#import "BOSSCheDianZhangCommon.h"


@implementation AppDelegate (BOSS)
- (void)BOSSbuildMainWindowView
{
    
    self.jobBoardViewController = [[JobBoardViewController alloc] init];
    UINavigationController* one_nc = [[UINavigationController alloc] initWithRootViewController:self.jobBoardViewController];
    one_nc.navigationBar.hidden = YES;
    
    self.storeTheDataViewController = [[StoreTheDataViewController alloc] init];
    UINavigationController* two_nc = [[UINavigationController alloc] initWithRootViewController:self.storeTheDataViewController];
    two_nc.navigationBar.hidden = YES;
    
    self.learningCenterViewController = [[LearningCenterViewController alloc] init];
    UINavigationController* three_nc = [[UINavigationController alloc] initWithRootViewController:self.learningCenterViewController];
    three_nc.navigationBar.hidden = YES;
    
    self.foundViewController = [[FoundViewController alloc] init];
    UINavigationController* four_nc = [[UINavigationController alloc] initWithRootViewController:self.foundViewController];
    four_nc.navigationBar.hidden = YES;
    
    self.theCustomerViewController = [[TheCustomerViewController alloc] init];
    UINavigationController* five_nc = [[UINavigationController alloc] initWithRootViewController:self.theCustomerViewController];
    five_nc.navigationBar.hidden = YES;
    
    UITabBarItem* item01 = [[UITabBarItem alloc] initWithTitle:@"工作看板" image:[DJImageNamed(@"Boss_tabBar_kanban") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"Boss_tabBar_kanban_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item02 = [[UITabBarItem alloc] initWithTitle:@"门店数据" image:[DJImageNamed(@"Boss_tabBar_menDian") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"Boss_tabBar_menDian_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item03 = [[UITabBarItem alloc] initWithTitle:@"学习中心" image:[DJImageNamed(@"Boss_tabBar_XueXi") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"Boss_tabBar_XueXi_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item04 = [[UITabBarItem alloc] initWithTitle:@"发现" image:[DJImageNamed(@"Boss_tabBar_faXian") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"Boss_tabBar_faXian_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item05 = [[UITabBarItem alloc] initWithTitle:@"客户" image:[DJImageNamed(@"Boss_tabBar_keHu") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"Boss_tabBar_keHu_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    one_nc.tabBarItem = item01;
    two_nc.tabBarItem = item02;
    three_nc.tabBarItem = item03;
    four_nc.tabBarItem = item04;
    five_nc.tabBarItem = item05;
    
    //TODO: 测试
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:@[one_nc,two_nc,three_nc,four_nc,five_nc]];
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.translucent = NO;//不透明
    self.tabBarController.tabBar.tintColor = kZhuTiColor;
    self.tabBarController.tabBar.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.tabBarController.tabBar.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.tabBarController.tabBar.layer.shadowRadius = 2;//阴影半径，默认3
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],} forState:UIControlStateSelected];
    
    //去掉tabBar顶部线条
    CGRect rect = CGRectMake(0, 0, kWindowW, kWindowH);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [self.tabBarController.tabBar setShadowImage:img];
    [self.tabBarController.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    UIImageView *im = [[UIImageView alloc]initWithImage:DJImageNamed(@"Combined Shape")];
    im.frame = CGRectMake(-2, -18, kWindowW+4, 20);
    [self.tabBarController.tabBar addSubview:im];
    
    
    LeftController *leftVC = [[LeftController alloc] init];
    
    
    
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:self.tabBarController leftDrawerViewController:leftVC];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setMaximumLeftDrawerWidth:kWindowW-100];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];//侧滑效果
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.drawerController];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
}

#pragma mark 获取自定义消息内容

- (void)chuLiBOSSxiXiao:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    NSString *content_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(userInfo, @"content_type")];

//    发送课程通知—msg_type：12
    if ([content_type isEqualToString:@"12"]) {
        NSMutableArray *keChengArray = [[NSMutableArray alloc]init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kKeChengXiaoXi] != nil) {
            NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kKeChengXiaoXi];
            for (int i = 0; i<newArray.count; i++) {
                NSDictionary *dict = newArray[i];
                [keChengArray addObject:dict];
            }
        }
        
        BOOL shiFouC = NO;
        NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
        for (int i = 0; i<keChengArray.count; i++) {
            if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(extras, @"video_id")] isEqualToString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(keChengArray[i], @"video_id")]]) {
                shiFouC = YES;
            }
        }
        if (shiFouC == NO) {
            [keChengArray addObject:extras];
        }
        
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeChengXiaoXi];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSArray *cunarray = keChengArray;
        [[NSUserDefaults standardUserDefaults] setObject:cunarray forKey:kKeChengXiaoXi];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
//    发送系统通知—msg_type：13
    if ([content_type isEqualToString:@"13"]) {
        NSMutableArray *keChengArray = [[NSMutableArray alloc]init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kXiTongTongZhi] != nil) {
            NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kXiTongTongZhi];
            for (int i = 0; i<newArray.count; i++) {
                NSDictionary *dict = newArray[i];
                [keChengArray addObject:dict];
            }
        }

        BOOL shiFouC = NO;
        NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
        for (int i = 0; i<keChengArray.count; i++) {
            if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(extras, @"title")] isEqualToString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(keChengArray[i], @"title")]]) {
                shiFouC = YES;
            }
        }
        if (shiFouC == NO) {
            [keChengArray addObject:extras];
        }


        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kXiTongTongZhi];
        [[NSUserDefaults standardUserDefaults] synchronize];

        NSArray *cunarray = keChengArray;
        [[NSUserDefaults standardUserDefaults] setObject:cunarray forKey:kXiTongTongZhi];
        [[NSUserDefaults standardUserDefaults] synchronize];


    }
//    发送点赞—msg_type：14
    if ([content_type isEqualToString:@"14"]) {
        NSMutableArray *keChengArray = [[NSMutableArray alloc]init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kDianZanTongZhi] != nil) {
            NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kDianZanTongZhi];
            for (int i = 0; i<newArray.count; i++) {
                NSDictionary *dict = newArray[i];
                [keChengArray addObject:dict];
            }
        }

        BOOL shiFouC = NO;
        NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
        for (int i = 0; i<keChengArray.count; i++) {
            if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(extras, @"title")] isEqualToString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(keChengArray[i], @"title")]]) {
                shiFouC = YES;
            }
        }
        if (shiFouC == NO) {
            [keChengArray addObject:extras];
        }


        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kXiTongTongZhi];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [[NSUserDefaults standardUserDefaults] setObject:keChengArray forKey:kXiTongTongZhi];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
//    发送回复消息—msg_type：14
    NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
    if ([content_type isEqualToString:@"14"] && [KISDictionaryHaveKey(extras, @"is_praise")boolValue] == NO) {
        NSMutableArray *keChengArray = [[NSMutableArray alloc]init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kWoDeXiaoXi] != nil) {
            NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kWoDeXiaoXi];
            for (int i = 0; i<newArray.count; i++) {
                NSDictionary *dict = newArray[i];
                [keChengArray addObject:dict];
            }
        }

        BOOL shiFouC = NO;
        for (int i = 0; i<keChengArray.count; i++) {
            if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(extras, @"article_id")] isEqualToString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(keChengArray[i], @"article_id")]]) {
                shiFouC = YES;
            }
        }
        if (shiFouC == NO) {
            [keChengArray addObject:extras];
        }


        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWoDeXiaoXi];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSArray *cunarray = keChengArray;
        [[NSUserDefaults standardUserDefaults] setObject:cunarray forKey:kWoDeXiaoXi];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
