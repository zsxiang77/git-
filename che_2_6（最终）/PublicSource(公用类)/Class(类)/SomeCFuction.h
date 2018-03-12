//
//  SomeCFuction.h
//  zyyp
//
//  Created by shen yan ping on 15/5/22.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

/**
 一些C函数
 */
#import <UIKit/UIKit.h>

#define kWangWeiKey  @"WangWei"
#define kQianWeiKey  @"QianWei"
#define kBaiWeiKey   @"BaiWei"

#if __cplusplus
extern "C" {
#endif
    
    UIImage* DJImageNamed(NSString* name);
    UIFont*  DJSystemFont(float fontSize);
    UIFont*  DJBoldSystemFont(float fontSize);
    /**
     计算字母长度
     */
    NSUInteger asciiLengthOfString(NSString * text);
    /**
     截取lgt长度
     */
    NSUInteger asciiLengthIndexOfString(NSString * text, NSUInteger lgt);
    /**
     计算汉字的长度
     */
    NSUInteger unicodeLengthOfString(NSString * text);
    
    /**
     计算字符长度（后台方法）
     */
    NSUInteger bytesOfString(NSString* text);
    
    /**
     是否包含汉子或字母
     */
    BOOL isValidInput(NSString* text);
    
    NSInteger RYCChoose(NSInteger m, NSInteger n);
    
    /**
     直选注数
     */
    int numZhuZhiWithDic(NSDictionary* tempDic);
    
    /**
     旋转动画
     */
    CABasicAnimation* refreshAnimation(void);
    
    /**
     string转json
     */
    NSDictionary *dictionaryWithJsonString(NSString *jsonString);
    id objectWithJsonString(NSString *jsonString, id returnData);
    
#if __cplusplus
}
#endif
