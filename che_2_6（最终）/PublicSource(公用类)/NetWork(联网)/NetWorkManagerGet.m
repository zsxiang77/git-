//
//  NetWorkManagerGet.m
//  DaJiang365
//
//  Created by 周岁祥 on 16/4/25.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import "NetWorkManagerGet.h"


#define DDLogVerbose(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

static AFHTTPSessionManager *manager = nil;

@implementation NetWorkManagerGet

//把 path 和参数拼接起来,把字符串中的中文转换为百分号形势,因为有的服务器不接受中文编码
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *percentPath = [NSMutableString stringWithString:path];
    //提高 for 循环效率,方法调用在 for 循环外部
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    
    /**
     *  OC语言的特性是 runtime, 实际上调用一个方法的底层操作是在一个方法列表中搜索调用的方法所在的地址,然后调用完毕后把方法名转移到常用方法列表中.如果再次执行这个方法就在常用方法列表中搜索调用,效率更高
     */
    
    for (int i = 0; i < count; i ++) {
        
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@",keys
             [i],params[keys[i]]];
        }else{
            [percentPath appendFormat:@"&%@=%@",keys[i],params[keys[i]]];
        }
    }
    //把字符串中的中文转为百分号形式
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return manager;
}

@end
