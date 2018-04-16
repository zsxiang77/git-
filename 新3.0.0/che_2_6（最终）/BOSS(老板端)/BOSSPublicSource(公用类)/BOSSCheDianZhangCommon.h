//
//  CheDianZhangCommon.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "SomeCFuction.h"
#import "Masonry.h"
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"
#import "CommonRecordStatus.h"



#define kBOSSZhuTiColor ([UIColor colorWithRed:0/255.f green:122/255.f blue:255/255.f alpha:1.0])
#define kChePaiColor ([UIColor colorWithRed:0/255.f green:122/255.f blue:255/255.f alpha:1.0])
#define kNavBarColor ([UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0])
#define kViewBgColor ([UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1.0])
#define kLineBgColor ([UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0])
#define kButtonHighColor ([UIColor colorWithRed:245/255.f green:86/255.f blue:115/255.f alpha:1.0])


//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kColorWithRGB(r, g, b, a) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]



//设备信息
#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define KISHighVersion_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define KIS_IPHONE_6P ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] bounds].size.height == 736.0)//6plus
#define KAddFont_6P(font) (((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] bounds].size.height == 736.0)?font+2:font)//6plus font＋2

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]//16进制颜色转换

#define kCurrentVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;//block 弱化self

#define kParseCode(responseObject) (([[responseObject allKeys] containsObject:@"errorcode"] && [responseObject[@"errorcode"] integerValue] == 0) ? YES : NO)
#define kParseData(responseObject) (([[responseObject allKeys] containsObject:@"data"]) ? responseObject[@"data"] : nil)
#define kParseMessage(responseObject) (([[responseObject allKeys] containsObject:@"msg"]) ? responseObject[@"msg"] : @"")

#define KISDictionaryHaveKey(dict,key) [[dict allKeys] containsObject:key] && ([dict objectForKey:key] != (NSString*)[NSNull null]) ? [dict objectForKey:key] : @""

#define KDictionaryHaveKey(dict,key,return) [[dict allKeys] containsObject:key] && ([dict objectForKey:key] != (NSString*)[NSNull null]) ? [dict objectForKey:key] : return

#define KISEmptyOrEnter(text) ([text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)//是否除空格 换行外还有别的字符

#define KISNullValue(array,i,key) ([[[array objectAtIndex:i] allKeys] containsObject:key] && [[array objectAtIndex:i] objectForKey:key] != (NSString*)[NSNull null] ? [[array objectAtIndex:i] objectForKey:key] : @"")


#define DAJIANG_MULTILINE_TEXTSIZE(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;//计算字符宽高

//#define DEBUG_MODE//Debug模式 发布前注释掉

#ifdef DEBUG_MODE
#define NPrintLog(FORMAT, ...) printf("%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NPrintLog(...)
#endif

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define kStoryboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

//通过Storyboard ID 在对应Storyboard中获取场景对象
#define kVCFromSb(VCID, SbName)     [[UIStoryboard storyboardWithName:SbName bundle:nil] instantiateViewControllerWithIdentifier:VCID]

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject


#pragma mark - 处理消息

#define kWoDeXiaoXi  @"kWoDeXiaoXiNSNotificationCenter"//我的消息缓存
#define kKeChengXiaoXi  @"kKeChengXiaoXiNSNotificationCenter"//课程消息缓存
#define kXiTongTongZhi  @"kkXiTongTongZhiNotificationCenter"//系统通知缓存
#define kDianZanTongZhi  @"kDianZanTongZhiNotificationCenter"//点赞通知缓存




