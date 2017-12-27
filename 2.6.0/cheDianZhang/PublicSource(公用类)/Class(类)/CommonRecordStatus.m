//
//  CommonRecordStatus.m 
//  RuYiCai
// 
//  Created by ruyicai on 12-6-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
/*
 记录常用 的状态值
 
 */

#import "CommonRecordStatus.h"
#import "CheDianZhangCommon.h"

@interface CommonRecordStatus (internal)

@end

@implementation CommonRecordStatus

static CommonRecordStatus *s_commonRecordStatusManager = NULL;

- (id)init
{
    self = [super init];
    if (self) 
    {
        
    }
    return self;
}

+ (CommonRecordStatus *)commonRecordStatusManager
{
    @synchronized(self) //同步块－>同步锁
    {
		if (s_commonRecordStatusManager == nil) 
		{
			s_commonRecordStatusManager = [[self alloc] init];
		}
	}
	return s_commonRecordStatusManager;
}

+ (id)allocWithZone:(NSZone *)zone 
{
	@synchronized(self) 
	{
		if (s_commonRecordStatusManager == nil) 
		{
			s_commonRecordStatusManager = [super allocWithZone:zone];
			return s_commonRecordStatusManager;   
		}
	}	
	return nil;   
}

- (id)copyWithZone:(NSZone *)zone 
{
	return self;
}

#pragma mark 验证身份证和姓名 url
+ (BOOL)identityIScorrect:(NSString*)birthday
{
    int sum = 0;
    int weith[17] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    for (int i = 0; i < birthday.length - 1; i++) {
        NSString *itemString = [birthday substringWithRange:NSMakeRange(i,1)];
        sum += weith[i]*[itemString integerValue];
    }
    int num = sum%11;
    char checkCard[11] = {'1', '0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    char lastChar = [birthday characterAtIndex:birthday.length - 1];
    if (num == 2 && lastChar == 'x') {
        
        return YES;
    }
    if (checkCard[num] == lastChar) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)nameIScorrect:(NSString*)name
{
    if (name.length > 16 || name.length < 2) {//长度2-16
        return NO;
    }
    for (int j = 0; j < name.length; j ++) {
        UniChar chr = [name characterAtIndex:j];
        if(chr < 0x4e00 || chr > 0x9fa5)
        {
            if (![[name substringWithRange:NSMakeRange(j, 1)] isEqualToString:@"•"] && ![[name substringWithRange:NSMakeRange(j, 1)] isEqualToString:@"·"]) {
                return NO;
            }
        }
    }
    return YES;
}

+ (BOOL)URLIScorrect:(NSString*)urlString
{
    //是否为网址
    NSString *regTags = @"\\b(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";       // 设计好的正则表达式
    NSError  *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive    // 还可以加一些选项，例如：不区分大小写
                                                                             error:&error];
    // 执行匹配的过程
    NSRange matchedRange = [regex rangeOfFirstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
    if (matchedRange.location == NSNotFound) {
        return NO;
    }
    NSLog(@"%@", [urlString substringWithRange:matchedRange]);

    if ([urlString substringWithRange:matchedRange] && ![[urlString substringWithRange:matchedRange] isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

+ (NSString*)getEndTimeWithTime:(double)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];

    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000]];
}

+ (NSString*)getLeftTimeWithTime:(double)leftSeconds
{
    NSString* leftDate;
    if (leftSeconds > 3600*24) {//大于1天
        leftDate = [NSString stringWithFormat:@"%d天%d时", (int)leftSeconds/(3600*24), (int)(leftSeconds - ((int)(leftSeconds/(3600*24)) * (3600*24)))/3600];
    }
    else if (leftSeconds > 3600){//大于1小时
        leftDate = [NSString stringWithFormat:@"%d时%d分", (int)leftSeconds/3600, (int)(leftSeconds-(int)(leftSeconds/3600) * 3600)/60];
    }
    else{
        leftDate = [NSString stringWithFormat:@"%d分%d秒", (int)leftSeconds/60, (int)(leftSeconds-(int)(leftSeconds/60) * 60)];
    }
    
    return leftDate;
}
+ (NSString*)getLeftTimeQuLingWithTime:(double)leftSeconds
{
    int numDay = (int)(leftSeconds / (3600.0*24));
    if (leftSeconds>(numDay * (3600.0*24))) {
        leftSeconds -= numDay * (3600.0*24);
    }
    int numHours = (int)(leftSeconds / 3600.0);
    if (leftSeconds>(numHours * 3600.0)) {
        leftSeconds -= numHours * 3600.0;
    }
    
    int numMinute = (int)(leftSeconds / 60.0);
    if (leftSeconds>(numMinute * 60.0)) {
        leftSeconds -= numMinute * 60.0;
    }
    int numSecond = (int)(leftSeconds);
    NSString *dateStr = @"";
    if (numDay>0) {
        dateStr = [NSString stringWithFormat:@"%d天%d时%d分",numDay,numHours,numMinute];
        if (numHours == 0) {
            dateStr = [NSString stringWithFormat:@"%d天%d分",numDay,numMinute];
            if (numMinute == 0) {
                dateStr = [NSString stringWithFormat:@"%d天%d秒",numDay,numSecond];
            }
        }
        
    }else
    {
        dateStr = [NSString stringWithFormat:@"%d时%d分",numHours,numMinute];
        if (numHours == 0) {
            dateStr = [NSString stringWithFormat:@"%d分%d秒",numMinute,numSecond];
            if (numMinute == 0) {
                dateStr = [NSString stringWithFormat:@"%d秒",numSecond];
            }
        }
        
    }
    return dateStr;
}

+ (NSString*)getLeftSecondWithTime:(double)leftSeconds
{
    NSInteger hour = leftSeconds/3600;
    NSInteger minuter = (leftSeconds - hour*3600)/60;
    NSInteger second =  leftSeconds-hour*3600-minuter*60;

    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hour, (long)minuter, (long)second];
}

#pragma mark 剪裁图片
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (NSString*)getNickName:(NSString*)nickName userName:(NSString*)userName
{
    if (nickName && [nickName length] > 0) {
        return nickName;
    }
    if (userName && [userName length] > 0) {
        /*if (userName.length >= 5) {
            userName = [userName stringByReplacingCharactersInRange:NSMakeRange(1, 4) withString:@"****"];
        }
        else if(userName.length == 2){
            userName = [userName stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }
        else if(userName.length == 3){
            userName = [userName stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"**"];
        }
        else if(userName.length == 4){
            userName = [userName stringByReplacingCharactersInRange:NSMakeRange(1, 3) withString:@"***"];
        }*/
        return userName;
    }
    return @"";
}

+ (NSString*)getAvaildNumberWithDoubleStr:(NSString*)oldNumber
{
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:oldNumber];
    return [NSString stringWithFormat:@"%@",number];
}

+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (NSString*)getWeekNameWithWeekid:(NSInteger)weekId
{
    NSString *weekName = @"";
    switch (weekId) {
        case 2:
        {
            weekName = @"一";
            break;
        }
        case 3:
        {
            weekName = @"二";
            break;
        }
        case 4:
        {
            weekName = @"三";
            break;
        }
        case 5:
        {
            weekName = @"四";
            break;
        }
        case 6:
        {
            weekName = @"五";
            break;
        }
        case 7:
        {
            weekName = @"六";
            break;
        }
        case 1:
        {
            weekName = @"日";
            break;
        }
        default:
            break;
    }
    return weekName;
}

@end
