//
//  NSDate+Additions.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)
/**
 *  通过字符串和格式返回日期
 *
 *  @param string 日期字符串 eg:2014-08-27
 *  @param format 格式化字符串 eg:yyyy-MM-dd
 */
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

@end
