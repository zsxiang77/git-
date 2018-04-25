//
//  AppDelegate.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

#import "FoundViewController.h"
#import "JobBoardViewController.h"
#import "LearningCenterViewController.h"
#import "StoreTheDataViewController.h"
#import "TheCustomerViewController.h"
#import "LeftController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "ScanViewController.h"
#import "TheWorkbenchViewController.h"
#import "LonInViewController.h"
#import "UserPersonalDataVC.h"


#import "TheSidebarViewController.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define kNewfuctionKey @"newIntroduceVersion"

#import "MainTabBarViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainTabBarViewController* tabBarController;
@property (strong, nonatomic) NSString * tiaoZhuanordercode;

/** 引导图后 */
- (void)startFirstPage;


@property(nonatomic,strong)NSDictionary *xiaoXiVINDict;//VIN消息


@property(nonatomic,strong)ScanViewController *scanViewController;
@property(nonatomic,strong)TheWorkbenchViewController *theWorkbenchViewController;
@property(nonatomic,strong)UserPersonalDataVC *sixViewController;
//老板端
@property(nonatomic,strong)FoundViewController *foundViewController;
@property(nonatomic,strong)JobBoardViewController *jobBoardViewController;
@property(nonatomic,strong)LearningCenterViewController *learningCenterViewController;
@property(nonatomic,strong)StoreTheDataViewController *storeTheDataViewController;
@property(nonatomic,strong)TheCustomerViewController *theCustomerViewController;
@property (nonatomic,strong) MMDrawerController * drawerController;


@end


@interface AppDelegate (BOSS)

- (void)BOSSbuildMainWindowView;
- (void)chuLiBOSSxiXiao:(NSNotification *)notification;

@end

