//
//  AppDelegate.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define kNewfuctionKey @"newIntroduceVersion"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController* tabBarController;

/** 引导图后 */
- (void)startFirstPage;



@end

