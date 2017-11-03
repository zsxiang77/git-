//
//  CommonRecordStatus.h
//  RuYiCai
//
//  Created by ruyicai on 12-6-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonRecordStatus : NSObject {

}
@property(nonatomic, retain)NSDictionary* homeRightBottom;//首页右下角图标url

+ (CommonRecordStatus *)commonRecordStatusManager;


+ (NSString*)lotNameWithLotNo:(NSString*)lotNo;

+ (BOOL)identityIScorrect:(NSString*)birthday;
+ (BOOL)nameIScorrect:(NSString*)name;
+ (BOOL)URLIScorrect:(NSString*)name;

//获取有隐藏位数的身份证
//+ (NSString *)getHidingCertID;

/**
 截止时间
 */
+ (NSString*)getEndTimeWithTime:(double)time;
+ (NSString*)getLeftTimeWithTime:(double)leftSeconds;
/**去掉0时0分*/
+ (NSString*)getLeftTimeQuLingWithTime:(double)leftSeconds;
+ (NSString*)getLeftSecondWithTime:(double)leftSeconds;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/** 没有昵称 就返回隐藏了几位的用户名 */
+ (NSString*)getNickName:(NSString*)nickName userName:(NSString*)userName;

/** 去除小数没意义的0 */
+ (NSString*)getAvaildNumberWithDoubleStr:(NSString*)oldNumber;
/** 16进制颜色使用 */
+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/** 换算周 */
+ (NSString*)getWeekNameWithWeekid:(NSInteger)weekId;
@end
