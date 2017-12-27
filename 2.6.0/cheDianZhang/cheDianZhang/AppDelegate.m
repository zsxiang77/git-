//
//  AppDelegate.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AppDelegate.h"
#import "LineUpTheListVC.h"
#import "ScanViewController.h"
#import "TheWorkbenchViewController.h"
#import "UserViewController.h"
#import "LonInViewController.h"
#import "UMMobClick/MobClick.h"
#import "EBForeNotification.h"
#import "AITHTMLViewController.h"

#import "IntroduceViewController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "DCURLNavgation.h"
#import "UserPersonalDataVC.h"

#define kAPPKEY  @"bde8e49072393efd31ff1028"
static NSString *channel = @"APP Store";
static BOOL isProduction = FALSE;

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property(nonatomic,strong)LineUpTheListVC *lineUpTheListVC;
@property(nonatomic,strong)ScanViewController *scanViewController;
@property(nonatomic,strong)TheWorkbenchViewController *theWorkbenchViewController;
@property(nonatomic,strong)UserViewController *userViewController;
@property(nonatomic,strong)UserPersonalDataVC *sixViewController;

@end

@implementation AppDelegate

#pragma mark 友盟
- (void)umengTrack {
    UMConfigInstance.appKey = @"5a011823aed179348b000041";
    UMConfigInstance.channelId = KAgentId;
    [MobClick setAppVersion:kCurrentVersion];
    //    [MobClick setLogEnabled:YES];
    //    UMConfigInstance.ePolicy = REALTIME;
    [MobClick startWithConfigure:UMConfigInstance];
}


- (void)startFirstPage
{
    [self buildMainWindowView];
}

- (void)buildMainWindowView
{
    _lineUpTheListVC = [[LineUpTheListVC alloc] init];
    UINavigationController*  second_nc= [[UINavigationController alloc] initWithRootViewController:_lineUpTheListVC];
    second_nc.navigationBar.hidden = YES;

    _scanViewController = [[ScanViewController alloc] init];
    UINavigationController* third_nc = [[UINavigationController alloc] initWithRootViewController:_scanViewController];
    third_nc.navigationBar.hidden = YES;

    _theWorkbenchViewController = [[TheWorkbenchViewController alloc] init];
    UINavigationController* first_nc = [[UINavigationController alloc] initWithRootViewController:_theWorkbenchViewController];
    first_nc.navigationBar.hidden = YES;


    //TODO: 测试
    _userViewController = [[UserViewController alloc] init];
    UINavigationController* fourth_nc = [[UINavigationController alloc] initWithRootViewController:_userViewController];
    fourth_nc.navigationBar.hidden = YES;
    
    //TODO: 测试
    _sixViewController = [[UserPersonalDataVC alloc] init];
    UINavigationController* six_nc = [[UINavigationController alloc] initWithRootViewController:_sixViewController];
    six_nc.navigationBar.hidden = YES;



    //UIImageRenderingModeAlwaysOriginal 使用系统色（灰色）
    UITabBarItem* item01 = [[UITabBarItem alloc] initWithTitle:@"工作台" image:[DJImageNamed(@"tablebar_GZT") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_GZT_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item02 = [[UITabBarItem alloc] initWithTitle:@"排队列表" image:[DJImageNamed(@"tablebar_PDLB") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_PDLB_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item03 = [[UITabBarItem alloc] initWithTitle:@"扫一扫" image:[DJImageNamed(@"tablebar_SYS") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_SYS_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item04 = [[UITabBarItem alloc] initWithTitle:@"我" image:[DJImageNamed(@"tablebar_ME") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_ME_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    first_nc.tabBarItem = item01;
    second_nc.tabBarItem = item02;
    third_nc.tabBarItem = item03;
    //TODO: 测试
    six_nc.tabBarItem = item04;

    //TODO: 测试
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController setViewControllers:@[first_nc, second_nc, third_nc,six_nc]];
    _tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    _tabBarController.tabBar.translucent = NO;//不透明
    _tabBarController.tabBar.tintColor = kNavBarColor;
    _tabBarController.tabBar.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    _tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _tabBarController.tabBar.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    _tabBarController.tabBar.layer.shadowRadius = 2;//阴影半径，默认3
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],} forState:UIControlStateSelected];

    [_tabBarController.tabBar setShadowImage:[[UIImage alloc]init]];
    [_tabBarController.tabBar setBackgroundImage:[[UIImage alloc]init]];
    self.window.rootViewController = self.tabBarController;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
}





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self umengTrack];
    
    [NetWorkManager getReviewVersion];

    if ([UserInfo shareInstance].isLogined == NO) {
        LonInViewController* viewController = [[LonInViewController alloc] init];
        self.window.rootViewController = viewController;
    }else
    {
        [self buildMainWindowView];
    }

//    if ([[NSUserDefaults standardUserDefaults] objectForKey:kNewfuctionKey] == nil || ![[[NSUserDefaults standardUserDefaults] objectForKey:kNewfuctionKey] isEqualToString:kCurrentVersion]) {
//        IntroduceViewController* viewController = [[IntroduceViewController alloc] init];
//        self.window.rootViewController = viewController;
//
//    }
//    else{
//        if ([UserInfo shareInstance].isLogined == NO) {
//            LonInViewController* viewController = [[LonInViewController alloc] init];
//            self.window.rootViewController = viewController;
//        }else
//        {
//            [self buildMainWindowView];
//        }
//
//    }


//    LonInViewController* viewController = [[LonInViewController alloc] init];
//    self.window.rootViewController = viewController;


    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kAPPKEY
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

    [JPUSHService registerForRemoteNotificationTypes:(

                                                      UIUserNotificationTypeBadge |

                                                      UIUserNotificationTypeSound |

                                                      UIUserNotificationTypeAlert) categories:nil];
    
    return YES;
}


#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NPrintLog(@"notification2上不去%@",notification);
    NSDictionary * userInfo = [notification userInfo];
    NPrintLog(@"%@",userInfo);
    NSString *content_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(userInfo, @"content_type")];
    
    if ([content_type isEqualToString:@"1"]) {
        [UserInfo saveuserHuanCunXiTongArray:KISDictionaryHaveKey(userInfo, @"extras")];
    }
    
    if ([content_type isEqualToString:@"2"]) {
        [UserInfo saveuseruserDingDanArray:KISDictionaryHaveKey(userInfo, @"extras")];
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:kJieShouXiaoXi object:nil userInfo:userInfo];
//    [defaultCenter postNotificationName:kJieShouXiaoXi object:userInfo];
    
//    NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
//    
////    UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
////    artView.tag = 200;
////    [artView show];
//    
//    if (![extras isKindOfClass:[NSDictionary class]]) {
//        return;
//    }
//    
//    if ([KISDictionaryHaveKey(extras, @"is_ait") boolValue] == YES) {
//        UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
//        artView.tag = 200;
//        [artView show];
//        self.tiaoZhuanordercode = KISDictionaryHaveKey(extras, @"ordercode");
//        
//    }
    
}


//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
#pragma mark 推送
- (void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{//ios8.0 以上 #if __IPHONE_OS_VERSION_MAX_ALLOWED>=__IPHONE_8需要系统版本>=8.0
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [JPUSHService resetBadge];//重设角标为0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
     NPrintLog(@"%@",userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NPrintLog(@"%@",userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    UIApplicationState state = [application applicationState];//判断程序的状态
    if (state == UIApplicationStateInactive) {//小化、直接锁屏
        
    }else if (state == UIApplicationStateActive){
        //这种情况就是app打开的状态
        [EBForeNotification handleRemoteNotification:userInfo soundID:1312 isIos10:NO];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    UIApplicationState state = [application applicationState];//判断程序的状态
    if (state == UIApplicationStateInactive) {//小化、直接锁屏
        
    }else if (state == UIApplicationStateActive){
        //这种情况就是app打开的状态
        [EBForeNotification handleRemoteNotification:userInfo soundID:1312 isIos10:NO];
    }
}

@end
