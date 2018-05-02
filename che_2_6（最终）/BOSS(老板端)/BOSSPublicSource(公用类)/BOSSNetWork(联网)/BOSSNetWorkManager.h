//
//  BOSSNetWorkManager.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "CommonRecordStatus.h"
#import "ALAsset+mExport.h"

@class BOSSBaseViewController;

@interface BOSSNetWorkManager : NSObject

+ (void)requestWithParameters:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BOSSBaseViewController*)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;

/**
 单张图片上传
 */
+(void)requestWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BOSSBaseViewController *)viewController  isShowLoading:(BOOL)isShow withimage:(UIImage *)image  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;
+ (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message buttonTitle:(NSString*)btnTitle;

/**
 多张图片上传
 
 */
+(void)requestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BOSSBaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(NSArray *)images  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;


+(void)requestDuoZhangWithParametersVideoRepresentationWithfileData:(NSString *)url viewController:(BOSSBaseViewController*)viewController  isShowLoading:(BOOL)isShow withfileData:(NSData *)filedata success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;
+(void)touXiangrequestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BOSSBaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(NSArray *)images  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;

+ (void)loginAgain:(BOSSBaseViewController*)viewController;

#pragma mark - get
+ (void)requestWithParametersGET:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BOSSBaseViewController*)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;


@end
