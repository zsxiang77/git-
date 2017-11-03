//
//  BaseViewController.h
//  zyyp
//
//  Created by shen yan ping on 15/5/21.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CheDianZhangCommon.h"
#import "NetWorkManager.h"
#import "NetWorkManagerGet.h"
#import "LoadView.h"
#import "MJRefresh.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"



@class LoadView;

static float kNavBarHeight = 64;

@interface BaseViewController : UIViewController




{
    UIView* m_baseTopView;
    LoadView* m_loadView;
    UIView* m_notDataView;
    
    NSString* m_mainTopTitle;//页面名称 友盟统计页面访问路径
}

@property (nonatomic, strong) NSMutableArray *menuItems;

-(void)setAlertControllerWithTitle:(NSString *)titlr message:(NSString *)message actionTitle:(NSString  *)titi;

/**
 设置导航条
 */
- (void)setTopViewWithTitle:(NSString*)titleStr withBackButton:(BOOL)hasBacButton;

- (void)setTopViewWithTitle:(NSString*)titleStr withRootBackButton:(BOOL)hasBacButton;

/**
 展示黑底白色 当前view
 */
- (void)showMessageWithContent:(NSString*)content point:(CGPoint)point afterDelay:(float)delay;
/**
 展示黑底白色 当前window
 */
- (void)showMessageWindowWithTitle:(NSString*)content point:(CGPoint)point delay:(float)delay;
/**
 tabbar高度
 */
- (float)getTabBarHeight;
/**
 联网等待框
 */
- (void)showOrHideLoadView:(BOOL)isShow;
/**
 无数据view
 */
- (void)showNotDataView:(BOOL)isShow title:(NSString*)showTitle view:(UIView*)addView startY:(float)showY;
- (void)showNotDataView:(BOOL)isShow title:(NSString*)showTitle view:(UIView*)addView startY:(float)showY font:(UIFont*)font textColor:(UIColor*)textColor;

/**
 键盘消失 弹alertView
 */
- (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message buttonTitle:(NSString*)btnTitle;

//- (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message sureBtn:(NSString*)sureTitle cancelBtn:(NSString *)cancelTitle;

/**
 *  把导航条设置在最前面
 */
- (void) setNavBarToBring;

/**
 * 导航的返回事件
 */
- (void)backButtonClick:(id)sender;

#pragma mark- 助手
/**
 * 设置右上角的助手按钮
 */
- (void) setNavBarAssistantButtonWithItems:(NSArray*)items;

/**
 * 助手按钮的响应事件
 * 子类需重写此方法
 */
- (void) assistantActionWithIndex:(NSInteger) index;

/**
 * 助手按钮的响应方法
 */
- (void) assistantButtonClick:(id) sender;


-(void)settitleLabelText:(NSString *)title;
- (BOOL)loginCheck;
@end
