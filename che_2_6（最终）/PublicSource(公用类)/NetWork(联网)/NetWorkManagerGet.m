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

+ (void)requestWithParametersGet:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BaseViewController*)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure
{
    if (viewController != nil && isShow) {
        [viewController showOrHideLoadView:YES];
    }
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    NSMutableDictionary* requestDic = [[NSMutableDictionary alloc]init];
    [requestDic addEntriesFromDictionary:parameters];
    
    
    NSString *path = [NSString stringWithFormat:@"%@%@",HOST_URL,url];

    
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (viewController != nil && isShow) {
            [viewController showOrHideLoadView:NO];
        }
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        
        
        
        if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 404) {
            NPrintLog(@"msg:%@",KISDictionaryHaveKey(parserDict, @"msg"));
            [viewController showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }else if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            if (viewController != nil) {
                [NetWorkManager loginAgain:viewController];
            }
            return;
        }else if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 605)
        {
            
            UIAlertView *alc = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(parserDict, @"msg") delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil];
            [alc show];
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:viewController];
            return;
        }
        
        success(parserDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MobClick event:@"NetFail" attributes:[NetWorkManager getNetFailDictionary:error parameters:parameters]];
        failure(error);
        if (viewController != nil && isShow) {
            [viewController showOrHideLoadView:NO];
        }
        [[UserInfo shareInstance] showNotNetView];
    }];
    
}

@end
