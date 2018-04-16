//
//  UIFont+Addition.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#define IOS8_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending )

#import "UIFont+Addition.h"

@implementation UIFont (Addition)
+ (UIFont *)pf_PingFangSCLightFontOfSize:(CGFloat)fontSize
{
    if (IOS8_OR_LATER) return [UIFont systemFontOfSize:fontSize];
    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
}

+ (UIFont *)pf_PingFangSCRegularFontOfSize:(CGFloat)fontSize
{
    if (IOS8_OR_LATER) return [UIFont systemFontOfSize: fontSize];
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)pf_PingFangSCMediumFontOfSize:(CGFloat)fontSize
{
    if (IOS8_OR_LATER) return [UIFont boldSystemFontOfSize:fontSize];
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)pf_PingFangSCSemiboldFontOfSize:(CGFloat)fontSize
{
    if (IOS8_OR_LATER) return [UIFont boldSystemFontOfSize:fontSize];
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}
@end
