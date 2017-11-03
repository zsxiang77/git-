//
//  UserInfo.m
//  zyyp
//
//  Created by shen yan ping on 15/5/26.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

#import "UserInfo.h"
#import "SSKeychain.h"

@implementation UserInfo

- (id)init
{
    self = [super init];
    if (self) {
        self.isLogined = NO;
        self.userZhangHao = @"";
        self.isExplod = @"0";
        self.userRole = @"";
        self.userAvatar = @"";
        self.userReal_name = @"";
        self.userMobile = @"";
        self.userNameDict = [[NSDictionary alloc]init];
        self.userHuanCunXiTongArray = [[NSArray alloc]init];
        self.userDingDanArray = [[NSArray alloc]init];
        [self buildUserName];
        [self buildHuanCunArray];
    }
    return self;
}

+ (UserInfo *)shareInstance
{
    static UserInfo *user = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        user = [[self alloc] init];
    });
    
    return user;
}

+ (void)saveUserName
{
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userNameDict forKey:kUserToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userZhangHao forKey:userZhangHao];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userReal_name forKey:userReal_name];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userAvatar forKey:userAvatar];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userRole forKey:userRole];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userMobile forKey:userMobile];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)savekIsExplod
{
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].isExplod forKey:kIsExplod];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveUserImageUrl
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)buildUserName
{
    if (([[NSUserDefaults standardUserDefaults] objectForKey:kUserToken] != nil)&&([[NSUserDefaults standardUserDefaults] objectForKey:kIsExplod] != nil)) {
        self.userNameDict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserToken];
        self.userZhangHao = [[NSUserDefaults standardUserDefaults] objectForKey:userZhangHao];
        self.isExplod = [[NSUserDefaults standardUserDefaults] objectForKey:kIsExplod];
        self.userReal_name = [[NSUserDefaults standardUserDefaults] objectForKey:userReal_name];
        self.userAvatar = [[NSUserDefaults standardUserDefaults] objectForKey:userAvatar];
        self.userRole = [[NSUserDefaults standardUserDefaults] objectForKey:userRole];
        self.userMobile = [[NSUserDefaults standardUserDefaults] objectForKey:userMobile];
        self.isLogined = YES;
    }else{
        [self cleanUserInfor];
    }
}

- (void)cleanUserInfor
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userZhangHao];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kIsExplod];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userReal_name];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userAvatar];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userRole];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userMobile];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.isLogined = NO;
    self.userNameDict = [[NSDictionary alloc]init];
    
}

#pragma mark 无网络、升级alertView
- (void)showNotNetView
{
    //暂不使用
    if (m_userAlert != nil) {
        return;
    }
    m_userAlert = [[UIAlertView alloc]
                     initWithTitle:nil
                     message:@"网络连接失败，请稍后重试！"
                     delegate:self
                     cancelButtonTitle:@"确定"
                     otherButtonTitles: nil];
    [m_userAlert show];
}

- (void)updataAlertShowWithMessage:(NSString*)content version:(NSString*)version
{
    if (m_userAlert != nil) {
        return;
    }
    m_userAlert = [[UIAlertView alloc]
                   initWithTitle:[@"发现新版本" stringByAppendingString:version]
                   message:content
                   delegate:self
                   cancelButtonTitle:@"稍后再说"
                   otherButtonTitles:@"立即升级", nil];
    [m_userAlert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView == m_userAlert) {
        if ([alertView.title hasPrefix:@"发现新版本"]) {
            if(buttonIndex != alertView.cancelButtonIndex){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updataUrl]];
            }
        }
        m_userAlert = nil;
    }
}

#pragma mark - 缓存
+ (void)saveuserHuanCunXiTongArray:(NSDictionary *)dict
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userHuanCunXiTongArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableArray *xiTongArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<[UserInfo shareInstance].userHuanCunXiTongArray.count; i++) {
        [xiTongArray addObject:[UserInfo shareInstance].userHuanCunXiTongArray[i]];
    }
    
    [xiTongArray addObject:dict];
    
    [UserInfo shareInstance].userHuanCunXiTongArray = xiTongArray;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userHuanCunXiTongArray forKey:userHuanCunXiTongArray];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)cleanDingDanArray
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userDingDanArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserInfo shareInstance].userDingDanArray = [[NSArray alloc]init];
}

+ (void)cleanDingDanArrayDanTiao:(NSDictionary *)dict
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userDingDanArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableArray *xiTongArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<[UserInfo shareInstance].userDingDanArray.count; i++) {
        if (![KISDictionaryHaveKey([UserInfo shareInstance].userDingDanArray[i], @"ordercode") isEqualToString:KISDictionaryHaveKey(dict, @"ordercode")]) {
            [xiTongArray addObject:[UserInfo shareInstance].userDingDanArray[i]];
        }
    }
    [UserInfo shareInstance].userDingDanArray = xiTongArray;
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userDingDanArray forKey:userDingDanArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveuseruserDingDanArray:(NSDictionary *)dict
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userDingDanArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableArray *xiTongArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<[UserInfo shareInstance].userDingDanArray.count; i++) {
        [xiTongArray addObject:[UserInfo shareInstance].userDingDanArray[i]];
    }
    
    [xiTongArray addObject:dict];
    
    [UserInfo shareInstance].userDingDanArray = xiTongArray;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance].userDingDanArray forKey:userDingDanArray];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)buildHuanCunArray
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:userHuanCunXiTongArray] != nil) {
        self.userHuanCunXiTongArray = [[NSUserDefaults standardUserDefaults] objectForKey:userHuanCunXiTongArray];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:userDingDanArray] != nil) {
        self.userDingDanArray = [[NSUserDefaults standardUserDefaults] objectForKey:userDingDanArray];
    }
    
}


@end
