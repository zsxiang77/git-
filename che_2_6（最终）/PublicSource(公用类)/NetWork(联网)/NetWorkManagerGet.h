//
//  NetWorkManagerGet.h
//  DaJiang365
//
//  Created by 周岁祥 on 16/4/25.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheDianZhangCommon.h"
#import "AFNetworking.h"

@interface NetWorkManagerGet : NSObject

+ (AFHTTPSessionManager *)sharedAFManager;
+ (void)requestWithParametersGet:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BaseViewController*)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;

@end
