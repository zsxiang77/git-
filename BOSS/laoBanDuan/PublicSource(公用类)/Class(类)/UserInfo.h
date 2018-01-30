//
//  UserInfo.h
//  zyyp
//
//  Created by shen yan ping on 15/5/26.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CheDianZhangCommon.h"

static NSString* const kUserToken = @"userToken";
static NSString* const kIsExplod = @"kIsExplod";//是否是北京用户
static NSString* const userZhangHao = @"USERZhangHao";//是否是北京用户

//缓存
static NSString* const userHuanCunXiTongArray = @"userHuanCunXiTongArray";//系统消息
static NSString* const userDingDanArray = @"userDingDanArray";//订单消息
static NSString* const userReal_name = @"userReal_name";
static NSString* const userRole = @"userRole";
static NSString* const userAvatar = @"userAvatar";
static NSString* const userMobile = @"userMobile";

@interface UserInfo : NSObject<UIAlertViewDelegate>
{
    UIAlertView*   m_userAlert;//无网络弹框、升级框（确保弹一个）
}


+ (UserInfo *)shareInstance;

@property(nonatomic,strong)NSString *userZhangHao;//账号
@property(nonatomic,strong)NSString *userReal_name;
@property(nonatomic,strong)NSString *userRole;
@property(nonatomic,strong)NSString *userAvatar;
@property(nonatomic,strong)NSString *userMobile;
@property(nonatomic, assign)BOOL isLogined;//是否登录
@property(nonatomic,strong)NSDictionary *userNameDict;
@property(nonatomic,strong)NSString *isExplod;//是否北京用户

@property(nonatomic,strong)NSArray *userHuanCunXiTongArray;
@property(nonatomic,strong)NSArray *userDingDanArray;
//=================================

- (void)cleanUserInfor;


@property(nonatomic, copy)NSString* updataUrl;//升级地址

+ (void)saveUserName;

+ (void)savekIsExplod;

/**
 无网络弹框
 */
- (void)showNotNetView;

#pragma mark - 缓存
+ (void)saveuserHuanCunXiTongArray:(NSDictionary *)dict;
+ (void)saveuseruserDingDanArray:(NSDictionary *)dict;
+ (void)cleanDingDanArray;
+ (void)cleanDingDanArrayDanTiao:(NSDictionary *)dict;
@end
