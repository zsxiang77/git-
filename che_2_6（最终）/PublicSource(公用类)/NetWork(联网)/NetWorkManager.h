//
//  NetWorkManager.h
//  DaJiang365
//
//  Created by 荣华 on 16/2/27.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "CommonRecordStatus.h"
#import "ALAsset+mExport.h"


@class BaseViewController;

@interface NetWorkManager : NSObject

+ (void)requestWithParameters:(NSDictionary *)parameters withUrl:(NSString *)url viewController:(BaseViewController*)viewController withRedictLogin:(BOOL)longin isShowLoading:(BOOL)isShow success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;

/**
 单张图片上传

 @param url <#url description#>
 @param viewController <#viewController description#>
 @param isShow <#isShow description#>
 @param image <#image description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)requestWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(UIImage *)image  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;
+ (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message buttonTitle:(NSString*)btnTitle;

/**
 多张图片上传

 @param url <#url description#>
 @param viewController <#viewController description#>
 @param isShow <#isShow description#>
 @param images <#images description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)requestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(NSArray *)images  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;


+(void)requestDuoZhangWithParametersVideoRepresentationWithfileData:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withfileData:(NSData *)filedata success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;
+(void)touXiangrequestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:(NSString *)url viewController:(BaseViewController*)viewController  isShowLoading:(BOOL)isShow withimage:(NSArray *)images  success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;

+ (void)loginAgain:(BaseViewController*)viewController;

+ (void)getReviewVersion;
//当前网络状态
+ (NSString*)getNetWorkWithWWAN;

+ (NSDictionary*)getNetFailDictionary:(NSError*)error parameters:(NSDictionary*)parameters;
@end
