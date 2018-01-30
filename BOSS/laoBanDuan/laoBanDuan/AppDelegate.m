//
//  AppDelegate.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "AppDelegate.h"
#import "FoundViewController.h"
#import "JobBoardViewController.h"
#import "LearningCenterViewController.h"
#import "StoreTheDataViewController.h"
#import "TheCustomerViewController.h"
#import "LeftController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@property(nonatomic,strong)FoundViewController *foundViewController;
@property(nonatomic,strong)JobBoardViewController *jobBoardViewController;
@property(nonatomic,strong)LearningCenterViewController *learningCenterViewController;
@property(nonatomic,strong)StoreTheDataViewController *storeTheDataViewController;
@property(nonatomic,strong)TheCustomerViewController *theCustomerViewController;

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (void)buildMainWindowView
{
    _jobBoardViewController = [[JobBoardViewController alloc] init];
    UINavigationController* one_nc = [[UINavigationController alloc] initWithRootViewController:_jobBoardViewController];
    one_nc.navigationBar.hidden = YES;
    
    _storeTheDataViewController = [[StoreTheDataViewController alloc] init];
    UINavigationController* two_nc = [[UINavigationController alloc] initWithRootViewController:_storeTheDataViewController];
    two_nc.navigationBar.hidden = YES;
    
    _learningCenterViewController = [[LearningCenterViewController alloc] init];
    UINavigationController* three_nc = [[UINavigationController alloc] initWithRootViewController:_learningCenterViewController];
    three_nc.navigationBar.hidden = YES;
    
    _foundViewController = [[FoundViewController alloc] init];
    UINavigationController* four_nc = [[UINavigationController alloc] initWithRootViewController:_foundViewController];
    four_nc.navigationBar.hidden = YES;
    
    _theCustomerViewController = [[TheCustomerViewController alloc] init];
    UINavigationController* five_nc = [[UINavigationController alloc] initWithRootViewController:_theCustomerViewController];
    five_nc.navigationBar.hidden = YES;
    
    
    UITabBarItem* item01 = [[UITabBarItem alloc] initWithTitle:@"工作看板" image:[DJImageNamed(@"tablebar_GZT") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_GZT_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item02 = [[UITabBarItem alloc] initWithTitle:@"门店数据" image:[DJImageNamed(@"tablebar_SYS") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_SYS_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item03 = [[UITabBarItem alloc] initWithTitle:@"学习中心" image:[DJImageNamed(@"tablebar_ME") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_ME_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item04 = [[UITabBarItem alloc] initWithTitle:@"发现" image:[DJImageNamed(@"tablebar_ME") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_ME_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item05 = [[UITabBarItem alloc] initWithTitle:@"客户" image:[DJImageNamed(@"tablebar_ME") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_ME_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    one_nc.tabBarItem = item01;
    two_nc.tabBarItem = item02;
    three_nc.tabBarItem = item03;
    four_nc.tabBarItem = item04;
    five_nc.tabBarItem = item05;
    
    //TODO: 测试
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController setViewControllers:@[one_nc, two_nc,three_nc,four_nc,five_nc]];
    _tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    _tabBarController.tabBar.translucent = NO;//不透明
    _tabBarController.tabBar.tintColor = kZhuTiColor;
    _tabBarController.tabBar.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    _tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _tabBarController.tabBar.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    _tabBarController.tabBar.layer.shadowRadius = 2;//阴影半径，默认3
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],} forState:UIControlStateSelected];
    
    [_tabBarController.tabBar setShadowImage:[[UIImage alloc]init]];
    [_tabBarController.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    
    LeftController *leftVC = [[LeftController alloc] init];
    

    
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:_tabBarController leftDrawerViewController:leftVC];
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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self buildMainWindowView];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
}


@end
