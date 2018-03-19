//
//  AppDelegate.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AppDelegate.h"

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

#import "HomeRightBottomButton.h"
#import "FillVINCodeViewController.h"
#import "VINNewAlertView.h"

#import "IQKeyboardManager.h"

#define kAPPKEY  @"bde8e49072393efd31ff1028"
static NSString *channel = @"APP Store";
static BOOL isProduction = FALSE;

@interface AppDelegate ()<JPUSHRegisterDelegate,UIAlertViewDelegate>
{
    HomeRightBottomButton   *m_homeRightBottomXiaoXi;
}



@property(nonatomic,strong)VINNewAlertView  *aitAlert;

@end

@implementation AppDelegate

#pragma mark 友盟
- (void)umengTrack {
    UMConfigInstance.appKey = @"5aaa3cc0b27b0a674400025f";
    UMConfigInstance.channelId = KAgentId;
    [MobClick setAppVersion:kCurrentVersion];
    //    [MobClick setLogEnabled:YES];
    //    UMConfigInstance.ePolicy = REALTIME;
    [MobClick startWithConfigure:UMConfigInstance];
}


- (void)startFirstPage
{
    if ([[UserInfo shareInstance].userPositions isKindOfClass:[NSArray class]]&&[UserInfo shareInstance].userPositions.count>0) {
        if ([[UserInfo shareInstance].userPositions[0] integerValue] == 1) {
            //        [self buildMainWindowView];
            [self BOSSbuildMainWindowView];
        }else if([[UserInfo shareInstance].userPositions[0] integerValue] == 2)
        {
            [self buildMainWindowView];
        }else{
            [[UserInfo shareInstance] cleanUserInfor];
        }
    }else{
        [[UserInfo shareInstance] cleanUserInfor];
        LonInViewController* viewController = [[LonInViewController alloc] init];
        self.window.rootViewController = viewController;
    }
   
}

- (void)buildMainWindowView
{

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
    UITabBarItem* item03 = [[UITabBarItem alloc] initWithTitle:@"开单" image:[DJImageNamed(@"tablebar_SYS") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_SYS_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem* item04 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[DJImageNamed(@"tablebar_ME") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[DJImageNamed(@"tablebar_ME_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    first_nc.tabBarItem = item01;
    third_nc.tabBarItem = item03;
    //TODO: 测试
    six_nc.tabBarItem = item04;

    //TODO: 测试
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController setViewControllers:@[first_nc/*, second_nc*/, third_nc,six_nc]];
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
    self.window.rootViewController = self.tabBarController;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
}





#pragma mark 右下角图标
- (void)buildHomeRightBottom
{
    m_homeRightBottomXiaoXi = [[HomeRightBottomButton alloc] initWithFrame:CGRectMake(kWindowW-75, kWindowH-60-80, 75, 75)];
    m_homeRightBottomXiaoXi.hidden = YES;
    m_homeRightBottomXiaoXi.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [m_homeRightBottomXiaoXi setImage:DJImageNamed(@"xiaoXi_youHong") forState:(UIControlStateNormal)];
    [m_homeRightBottomXiaoXi addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:m_homeRightBottomXiaoXi];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [m_homeRightBottomXiaoXi animationWithRotation0_10];
//    });
}

-(void)rightButtonClick:(UIButton *)sender
{
    if ([m_homeRightBottomXiaoXi isShowStatus]) {
        m_homeRightBottomXiaoXi.hidden = YES;
        FillVINCodeViewController *vc = [[FillVINCodeViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.touStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.xiaoXiVINDict, @"serial_number")];
        UINavigationController *navigationController = [DCURLNavgation sharedDCURLNavgation].currentNavigationViewController;
        [navigationController pushViewController:vc animated:YES];
    }
    else{
        [m_homeRightBottomXiaoXi animationWithRotation10_0];
    }
}

-(void)networkDidReceiveMessageYingCangXiaoXi:(NSNotification*) notification
{
    if (!m_homeRightBottomXiaoXi) {
        [self buildHomeRightBottom];
    }
    
    BOOL br = [[notification object] boolValue];
    if (br == YES) {
        m_homeRightBottomXiaoXi.hidden = NO;
    }else{
        m_homeRightBottomXiaoXi.hidden = YES;
    }
    [self.window bringSubviewToFront:m_homeRightBottomXiaoXi];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];

    [self configureKeyboardManager];

    [self umengTrack];

    [NetWorkManager getReviewVersion];

    if ([UserInfo shareInstance].isLogined == NO) {
        LonInViewController* viewController = [[LonInViewController alloc] init];
        self.window.rootViewController = viewController;
    }else
    {
//        [self buildMainWindowView];
        [self startFirstPage];
    }



    [self buildHomeRightBottom];
    
//    [self BOSSbuildMainWindowView];
    
    
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessageYingCangXiaoXi:) name:kTiaoZhuanVinYe object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kTiaoZhuanVinYe] != nil) {
        self.xiaoXiVINDict = [[NSUserDefaults standardUserDefaults] objectForKey:kTiaoZhuanVinYe];
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"1"];
    }
    


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
    if ([content_type isEqualToString:@"11"]) {
        self.xiaoXiVINDict = KISDictionaryHaveKey(userInfo, @"extras");
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTiaoZhuanVinYe];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.xiaoXiVINDict forKey:kTiaoZhuanVinYe];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        [self.window removeFromSuperview];
        
        UINavigationController *navigationController = [DCURLNavgation sharedDCURLNavgation].currentNavigationViewController;
        if ([[self currentViewController] isKindOfClass:[FillVINCodeViewController class]] ||[UserInfo shareInstance].isLogined == NO ||[[self currentViewController] isKindOfClass:[BOSSBaseViewController class]]) {
            return;
        }
        m_homeRightBottomXiaoXi.hidden = NO;
        
        
        
        [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"1"];
        if (!self.aitAlert) {
            self.aitAlert = [[VINNewAlertView alloc]initWithTitleWithmessage:[NSString stringWithFormat:@"AIT:%@未能检测出当前车辆的VIN码，请您手动输入VIN码",KISDictionaryHaveKey(self.xiaoXiVINDict, @"serial_number")] cancelButtonTitle:@"取消" otherButtonTitle:@"输入VIN码"];
        }
        if (self.aitAlert.hidden == NO) {
            return;
        }
        
        self.aitAlert.maLabel.text = [NSString stringWithFormat:@"AIT:%@未能检测出当前车辆的VIN码，请您手动输入VIN码",KISDictionaryHaveKey(self.xiaoXiVINDict, @"serial_number")];
        
        self.aitAlert.tag = 4000;
        [self.aitAlert show];
        kWeakSelf(weakSelf)
        self.aitAlert.queRenBtBlock = ^{
            [weakSelf m_homeRightBottomxianshi];
            FillVINCodeViewController *vc = [[FillVINCodeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.touStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(weakSelf.xiaoXiVINDict, @"serial_number")];
            [navigationController pushViewController:vc animated:YES];
        };
        [self.window addSubview:self.aitAlert];
//        [self.window bringSubviewToFront:alert];
        [self.aitAlert daoJiShi];
    }
    
    [self chuLiBOSSxiXiao:notification];//boss消息
    
    
    [defaultCenter postNotificationName:kJieShouXiaoXi object:nil userInfo:userInfo];
    
    
}
-(void)m_homeRightBottomxianshi
{
    m_homeRightBottomXiaoXi.hidden = YES;
}

-(void)jiguangZhiZhiXingYiCiWith:(NSDictionary *)dict WithNSNotificationCenter:(NSNotificationCenter *)defaultCenter
{
    
    VINNewAlertView* alert2 = [self.window viewWithTag:4000];
    alert2.hidden = YES;
    [self.window removeFromSuperview];
    alert2 = nil;

    UINavigationController *navigationController = [DCURLNavgation sharedDCURLNavgation].currentNavigationViewController;
    if ([[self currentViewController] isKindOfClass:[FillVINCodeViewController class]] ||[UserInfo shareInstance].isLogined == NO) {
        return;
    }
    m_homeRightBottomXiaoXi.hidden = NO;
    self.xiaoXiVINDict = KISDictionaryHaveKey(dict, @"extras");

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTiaoZhuanVinYe];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSUserDefaults standardUserDefaults] setObject:self.xiaoXiVINDict forKey:kTiaoZhuanVinYe];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [defaultCenter postNotificationName:kTiaoZhuanVinYe object:@"1"];
    VINNewAlertView* alert = [[VINNewAlertView alloc]initWithTitleWithmessage:[NSString stringWithFormat:@"VIN:%@未能检测出当前车辆的VIN码，请您手动输入VIN码",KISDictionaryHaveKey(self.xiaoXiVINDict, @"serial_number")] cancelButtonTitle:@"取消" otherButtonTitle:@"输入VIN码"];
    alert.tag = 4000;
    [alert show];
    alert.queRenBtBlock = ^{
        m_homeRightBottomXiaoXi.hidden = YES;
        FillVINCodeViewController *vc = [[FillVINCodeViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.touStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.xiaoXiVINDict, @"serial_number")];


        [navigationController pushViewController:vc animated:YES];
    };
    [self.window addSubview:alert];
    [self.window bringSubviewToFront:alert];
    [alert daoJiShi];
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
    
    if ([UserInfo shareInstance].isLogined == NO) {
        if ([[self currentViewController] isKindOfClass:[LonInViewController class]]) {
            return;
        }else{
            
        }
    }
    
    if (KISDictionaryHaveKey(userInfo, @"serial_number")) {
        NSString *serial_numberSTR = KISDictionaryHaveKey(userInfo, @"serial_number");
        if (serial_numberSTR.length>0) {
            if (![[self currentViewController] isKindOfClass:[FillVINCodeViewController class]] &&[UserInfo shareInstance].isLogined == YES) {
                VINNewAlertView* alert = [self.window viewWithTag:4000];
                alert.hidden = YES;
                [self.window removeFromSuperview];
                alert = nil;
                
                m_homeRightBottomXiaoXi.hidden = YES;
                FillVINCodeViewController *vc = [[FillVINCodeViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.touStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(userInfo, @"serial_number")];
                UINavigationController *navigationController = [DCURLNavgation sharedDCURLNavgation].currentNavigationViewController;
                [navigationController pushViewController:vc animated:YES];
            }else{
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:kJieShouXiaoXiDangQianAIT object:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(userInfo, @"serial_number")] userInfo:nil];
            }
        }
        
    }
    
    if ([KISDictionaryHaveKey(userInfo, @"is_ait") boolValue] == YES) {
        
        NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
        [mDict setObject:KISDictionaryHaveKey(userInfo, @"ordercode") forKey:@"ordercode"];
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_report" viewController:nil withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            
            if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
                AITHTMLViewController *vc = [[AITHTMLViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                NSArray* dataDic = kParseData(responseObject);
                if (![dataDic isKindOfClass:[NSArray class]]) {
                    return;
                }
                vc.chuanZhiArray = dataDic;
                UINavigationController *navigationController = [DCURLNavgation sharedDCURLNavgation].currentNavigationViewController;
                [navigationController pushViewController:vc animated:YES];
            }
            
        } failure:^(id error) {
            
        }];
        
    }
    
    
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

- (void)configureKeyboardManager
{
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
    /// 需要禁用的控制器
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[LonInViewController class]];
}

@end
