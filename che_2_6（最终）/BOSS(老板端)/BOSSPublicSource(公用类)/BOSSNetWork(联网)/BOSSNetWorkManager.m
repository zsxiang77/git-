//
//  BOSSNetWorkManager.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSNetWorkManager.h"
#import "BOSSBaseViewController.h"
#import "AFNetworking.h"
#import <sys/utsname.h>
#import "RealReachability.h"//网络类型
#import "UMMobClick/MobClick.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import "LonInViewController.h"
#import "VersionUpdate.h"


@implementation BOSSNetWorkManager



+ (NSMutableDictionary*)getCommonCookieDictionary
{
    UIDevice* device = [UIDevice currentDevice];
    //    NSString* deviceName = [device model];
    NSString *userPhoneNameStr = [device name];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:kCurrentVersion forKey:@"version"];
    return [NSMutableDictionary dictionaryWithDictionary:@{@"clientInfo":mDict}];
}

+ (void)requestWithParameters:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BOSSBaseViewController *)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure
{
    if (viewController != nil && isShow) {
        [viewController showOrHideLoadView:YES];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//@"text/plain"
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    
    //    NSMutableDictionary* requestDic = [NetWorkManager getCommonCookieDictionary];
    NSMutableDictionary* requestDic = [[NSMutableDictionary alloc]init];
    [requestDic addEntriesFromDictionary:parameters];
    
    
    
    
    NSError *error = nil;
    NSData *cookieData = [NSJSONSerialization dataWithJSONObject:requestDic
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
    NSString *path = [NSString stringWithFormat:@"%@%@",HOST_URL,url];
    
    if ([UserInfo shareInstance].isLogined==YES) {
        //创建你得请求url、设置请求头
        
        if (![[UserInfo shareInstance].userNameDict isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
        
        NPrintLog(@"qweasd:%@",KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie"));
        [manager POST:path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders = response.allHeaderFields;
            
            if (viewController != nil && isShow) {
                [viewController showOrHideLoadView:NO];
            }
            NSData *responseData = responseObject;
            NSData *filData = responseData;
            NSDictionary* parserDict = (NSDictionary *)filData;
            NPrintLog(@"\n参数：%@\n返回：%@", [[NSString alloc] initWithData:cookieData encoding:NSUTF8StringEncoding], parserDict);
            
            
            
            if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 404) {
                NPrintLog(@"msg:%@",KISDictionaryHaveKey(parserDict, @"msg"));
                [viewController showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
                return;
            }else if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 604)
            {
                [[UserInfo shareInstance] cleanUserInfor];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
                if (viewController != nil) {
                    [BOSSNetWorkManager loginAgain:viewController];
                }
                return;
            }else if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 605)
            {
                
                UIAlertView *alc = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(parserDict, @"msg") delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alc show];
                [[UserInfo shareInstance] cleanUserInfor];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
                [BOSSNetWorkManager loginAgain:viewController];
                return;
            }
            
            success(parserDict);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MobClick event:@"NetFail" attributes:[BOSSNetWorkManager getNetFailDictionary:error parameters:parameters]];
            NPrintLog(@"\n参数：%@\n", [[NSString alloc] initWithData:cookieData encoding:NSUTF8StringEncoding]);
            NPrintLog(@"请求失败 %@ \n参数：%@", error, requestDic);
            failure(error);
            if (viewController != nil && isShow) {
                [viewController showOrHideLoadView:NO];
            }
            [[UserInfo shareInstance] showNotNetView];
        }];
        
        
    }else
    {
        [manager POST:path parameters:requestDic progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders = response.allHeaderFields;
            NPrintLog(@"allHeaders%@\n",allHeaders);
            [UserInfo shareInstance].userNameDict = allHeaders;
            [UserInfo saveUserName];
            
            
            if (viewController != nil && isShow) {
                [viewController showOrHideLoadView:NO];
            }
            NSData *responseData = responseObject;
            NSData *filData = responseData;
            NSDictionary* parserDict = (NSDictionary *)filData;
            NPrintLog(@"\n参数：%@\n返回：%@", [[NSString alloc] initWithData:cookieData encoding:NSUTF8StringEncoding], parserDict);
            
            if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 404) {
                NPrintLog(@"msg:%@",KISDictionaryHaveKey(parserDict, @"msg"));
                [viewController showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
                return;
            }else if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 604)
            {
                [[UserInfo shareInstance] cleanUserInfor];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
                if (viewController != nil) {
                    [BOSSNetWorkManager loginAgain:viewController];
                }
                return;
            }
            
            success(parserDict);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NPrintLog(@"\n参数：%@\n", [[NSString alloc] initWithData:cookieData encoding:NSUTF8StringEncoding]);
            NPrintLog(@"请求失败 %@ \n参数：%@", error, requestDic);
            failure(error);
            if (viewController != nil && isShow) {
                [viewController showOrHideLoadView:NO];
            }
            [[UserInfo shareInstance] showNotNetView];
        }];
    }
    
}
+ (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message buttonTitle:(NSString*)btnTitle
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:btnTitle
                                          otherButtonTitles:nil];
    [alert show];
}

+ (NSString*)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return deviceString;
}


+ (NSDictionary*)getNetFailDictionary:(NSError*)error parameters:(NSDictionary*)parameters
{
    NSString* infoStr = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@|", KISDictionaryHaveKey(error.userInfo, @"NSLocalizedDescription"), [CommonRecordStatus getEndTimeWithTime:[[NSDate date] timeIntervalSince1970]*1000], [[UIDevice currentDevice] systemVersion], kCurrentVersion, [BOSSNetWorkManager deviceVersion], KISDictionaryHaveKey(parameters, @"command"),KISDictionaryHaveKey(error.userInfo, NSURLErrorFailingURLStringErrorKey)];
    
    [GLobalRealReachability startNotifier];
    switch ([GLobalRealReachability currentReachabilityStatus])
    {
        case RealStatusNotReachable:{
            infoStr = [infoStr stringByAppendingString:@"NotNet"];
            break;
        }
        case RealStatusViaWiFi:{
            infoStr = [infoStr stringByAppendingString:@"WIFI"];
            break;
        }
        case RealStatusViaWWAN:
        {
            infoStr = [infoStr stringByAppendingString:[BOSSNetWorkManager getNetWorkWithWWAN]];
            break;
        }
        default:
            break;
    }
    NPrintLog(@"失败log:%@", infoStr);
    return @{@"error":infoStr};
}



+ (NSString*)getNetWorkWithWWAN
{
    CTTelephonyNetworkInfo  *networkInfo = [[CTTelephonyNetworkInfo  alloc] init];
    
    NSString *currentStatus  = networkInfo.currentRadioAccessTechnology; //获取当前网络描述
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]) {
        return @"4G";
    } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge] || [currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
        return @"2G";
    } else {
        return @"3G";
    }
    
    return @"CellNetwork";
}


//+(UIImage *)reduceImage:(UIImage *)image
//{
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
//    UIImage *newImage = [UIImage imageWithData:imageData];
//    return newImage;
//}


+(void)requestWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(UIImage *)image  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure
{
    
    
    if (viewController != nil && isShow) {
        [viewController showOrHideLoadView:YES];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//@"text/plain"
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    //创建你得请求url、设置请求头
    
    [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
    NSString *path = [NSString stringWithFormat:@"%@%@",HOST_URL,url];
    
    
    [manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(image,0.1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"img"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        if (viewController != nil && isShow) {
            [viewController showOrHideLoadView:NO];
        }
        //上传成功
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@", parserDict);
        success(parserDict);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        failure(error);
        if (viewController != nil && isShow) {
            [viewController showOrHideLoadView:NO];
        }
        [[UserInfo shareInstance] showNotNetView];
    }];
    
}

+(void)touXiangrequestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(NSArray *)images  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure
{
    
    if (viewController != nil && isShow) {
        [viewController showOrHideLoadView:YES];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//@"text/plain"
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    //创建你得请求url、设置请求头
    
    [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
    NSString *path = [NSString stringWithFormat:@"%@%@",HOST_URL,url];
    /**
     *  post : 上传的网址
     *
     *  parameters 服务器需要上传的参数
     *
     */
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"img" forKey:@"type"];
    [dict setObject:@"1" forKey:@"avatar"];
    [manager POST:path parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        /*   参数说明：
         1. fileData:   要上传文件的数据
         2. name:       负责上传文件的远程服务中接收文件使用的字段名称
         3. fileName：   要上传文件的文件名
         4. mimeType：   要上传文件的文件类型
         
         提示，在日常开发中，如果要上传图片到服务器，一定记住不要出现文件重名的问题！
         这个问题，通常涉及到前端程序员和后端程序员的沟通。
         
         通常解决此问题，可以使用系统时间作为文件名！
         */
        // 1) 取当前系统时间
        NSDate *date = [NSDate date];
        // 2) 使用日期格式化工具
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        // 3) 指定日期格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateStr = [formatter stringFromDate:date];
        
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSData *data = UIImageJPEGRepresentation(image,0.1);
            // 4) 使用系统时间生成一个文件名
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", dateStr,i + 1];
            [formData appendPartWithFileData:data name:@"file[]" fileName:fileName mimeType:@"image/jpg"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        [viewController showOrHideLoadView:NO];
        //上传成功
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@", parserDict);
        success(parserDict);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        failure(error);
        [viewController showOrHideLoadView:NO];
        [[UserInfo shareInstance] showNotNetView];
    }];
}

+(void)requestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(NSArray *)images  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure
{
    
    if (viewController != nil && isShow) {
        [viewController showOrHideLoadView:YES];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//@"text/plain"
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    //创建你得请求url、设置请求头
    
    [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
    NSString *path = [NSString stringWithFormat:@"%@%@",HOST_URL,url];
    /**
     *  post : 上传的网址
     *
     *  parameters 服务器需要上传的参数
     *
     */
    NSDictionary *dict = @{@"type":@"img"};
    [manager POST:path parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        /*   参数说明：
         1. fileData:   要上传文件的数据
         2. name:       负责上传文件的远程服务中接收文件使用的字段名称
         3. fileName：   要上传文件的文件名
         4. mimeType：   要上传文件的文件类型
         
         提示，在日常开发中，如果要上传图片到服务器，一定记住不要出现文件重名的问题！
         这个问题，通常涉及到前端程序员和后端程序员的沟通。
         
         通常解决此问题，可以使用系统时间作为文件名！
         */
        // 1) 取当前系统时间
        NSDate *date = [NSDate date];
        // 2) 使用日期格式化工具
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        // 3) 指定日期格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateStr = [formatter stringFromDate:date];
        
        for (int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSData *data = UIImageJPEGRepresentation(image,0.1);
            // 4) 使用系统时间生成一个文件名
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", dateStr,i + 1];
            [formData appendPartWithFileData:data name:@"file[]" fileName:fileName mimeType:@"image/jpg"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        [viewController showOrHideLoadView:NO];
        //上传成功
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@", parserDict);
        success(parserDict);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        failure(error);
        [viewController showOrHideLoadView:NO];
        [[UserInfo shareInstance] showNotNetView];
    }];
}

+(void)requestDuoZhangWithParametersVideoRepresentationWithfileData:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withfileData:(NSData *)filedata success:(void (^)(id responseObject))success failure:(void (^)(id error))failure{
    
    if (viewController != nil && isShow) {
        [viewController showOrHideLoadView:YES];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//@"text/plain"
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    //创建你得请求url、设置请求头
    
    [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
    NSString *path = [NSString stringWithFormat:@"%@%@",HOST_URL,url];
    NSDictionary *dict = @{@"type":@"video"};
    
    [manager POST:path parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        // 1) 取当前系统时间
        NSDate *date = [NSDate date];
        // 2) 使用日期格式化工具
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        // 3) 指定日期格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateStr = [formatter stringFromDate:date];
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4", dateStr];
        [formData appendPartWithFileData:filedata name:@"file[]" fileName:fileName mimeType:@"video/mp4"];
        
        NPrintLog(@"fileName是%@",fileName);
        NPrintLog(@"name是file[]");
        NPrintLog(@"Content-Type:是video/mp4");
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        [viewController showOrHideLoadView:NO];
        //上传成功
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@", parserDict);
        NPrintLog(@"\nmsg：%@", parserDict[@"msg"]);
        success(parserDict);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        failure(error);
        [viewController showOrHideLoadView:NO];
        [[UserInfo shareInstance] showNotNetView];
    }];
    
}

#pragma mark 重新登录
+ (void)loginAgain:(BaseViewController*)viewController
{
    [[UserInfo shareInstance] cleanUserInfor];
    
    [viewController loginCheck];
}
#pragma mark 版本
+ (void)getReviewVersion
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [NetWorkManager requestWithParameters:mDict withUrl:@"soft/soft_info/app_package" viewController:nil withRedictLogin:NO isShowLoading:NO success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSString *version = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"version")];
        NSArray *versionArray1 = [version componentsSeparatedByString:@"."];
        NSArray *versionArray2 = [kCurrentVersion componentsSeparatedByString:@"."];
        
        if ([versionArray2[0] integerValue]>[versionArray1[0] integerValue]) {
            return;
        }else{
            if ([versionArray2[1] integerValue]>[versionArray1[1] integerValue]) {
                return;
            }else{
                if ([versionArray2[2] integerValue]>[versionArray1[2] integerValue]) {
                    return;
                }
            }
        }
        
        if ([KISDictionaryHaveKey(dataDic, @"version") isEqualToString:kCurrentVersion]) {
            return;
        }
        
        
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        if (!window)
        {
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        }
        VersionUpdate *updateview = [[VersionUpdate alloc]init];
        [updateview setYeMianArray:KISDictionaryHaveKey(dataDic, @"content") withbanBen:KISDictionaryHaveKey(dataDic, @"version")];
        [window addSubview:updateview];
    } failure:^(id error) {
        
    }];
}
static AFHTTPSessionManager *manager = nil;
#pragma mark - get
+ (void)requestWithParametersGET:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BOSSBaseViewController*)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure
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
                [BOSSNetWorkManager loginAgain:viewController];
            }
            return;
        }else if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 605)
        {
            
            UIAlertView *alc = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(parserDict, @"msg") delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alc show];
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:viewController];
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
