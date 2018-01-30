//
//  SomeCFuction.m
//  zyyp
//
//  Created by shen yan ping on 15/5/22.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

#import "SomeCFuction.h"



UIImage* DJImageNamed(NSString* name)
{
    return [UIImage imageNamed:name];//该方法图片有缓存，占内存，但快
}

UIFont*  DJSystemFont(float fontSize)
{
    return [UIFont systemFontOfSize:fontSize];
}

UIFont*  DJBoldSystemFont(float fontSize)
{
    return [UIFont boldSystemFontOfSize:fontSize];
}

#pragma mark 计算字符串长度
NSUInteger unicodeLengthOfString(NSString * text)
{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2)
    {
        unicodeLength++;
    }
    return unicodeLength;
}

NSUInteger asciiLengthOfString(NSString * text)
{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

NSUInteger asciiLengthIndexOfString(NSString * text, NSUInteger lgt)
{
    NSUInteger asciiIndex = 0;
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
        if (asciiLength > lgt) {
            break;
        }
        asciiIndex ++;
    }
    return asciiIndex;
}

NSUInteger bytesOfString(NSString* text)
{
    NSUInteger strlength = 0;
    // 这里一定要使用gbk的编码方式，网上有很多用Unicode的，但是混合的时候都不行
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);//一个汉子＝2
//    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);//一个汉子＝3
    char* p = (char*)[text cStringUsingEncoding:gbkEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:gbkEncoding] ;i++) {
        if (p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    NSLog(@"字节数：%ld", (long)strlength);
    return strlength;
}

BOOL isValidInput(NSString* text)
{
    for (int i = 0; i<text.length; i++) {
        unichar c = [text characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)        {
            return YES;//汉字
        }
        if (c >= 0x0041 && c <= 0x005a) {
            return YES;//大写字母
        }
        if (c >= 0x0061 && c <= 0x007a) {
            return YES;//小写字母
        }
    }
    return NO;
}

double lnChoose(int n, int m)
{
    if (m > n)
        return 0;
    
    if (m < n/2.0)
        m = n - m;
    
    double s1 = 0;
    for (int i = m + 1; i <= n; i++)
        s1 += log((double)i);
    
    double s2 = 0;
    int ub = n - m;
    for (int i = 2; i <= ub; i++)
        s2 += log((double)i);
    
    return s1 - s2;
}

NSInteger RYCChoose(NSInteger m, NSInteger n)
{
    if (m > n || m < 0)
        return 0;
    
    return (NSInteger)(exp(lnChoose(n, m)) + 0.5);
}

#pragma mark 高频彩直选注数算法（去掉含相同球注数）
int numZhuZhiWithDic(NSDictionary* tempDic)
{
    //    NSLog(@"tempDic %@", tempDic);
    if(tempDic == nil || [[tempDic allKeys] count] == 0)
        return 0;
    NSArray* wangWei = [tempDic objectForKey:kWangWeiKey];//直二
    NSArray* qianWei = [tempDic objectForKey:kQianWeiKey];
    NSArray* baiWei;
    if([[tempDic allKeys] count] > 2)//直三
    {
        baiWei = [tempDic objectForKey:kBaiWeiKey];
    }
    
    int zhuShu = 0;
    for (int i = 0; i < [wangWei count]; i++)
    {
        for (int j = 0; j < [qianWei count]; j++)
        {
            if(!([[wangWei objectAtIndex:i] intValue] == [[qianWei objectAtIndex:j] intValue]))
            {
                if([[tempDic allKeys] count] > 2)
                {
                    for (int k = 0; k < [baiWei count]; k++)
                    {
                        if(!([[baiWei objectAtIndex:k] intValue] == [[qianWei objectAtIndex:j] intValue]) && !([[baiWei objectAtIndex:k] intValue] == [[wangWei objectAtIndex:i] intValue]))
                            zhuShu++;
                    }
                }
                else
                {
                    zhuShu++;
                }
            }
        }
    }
    NSLog(@"zhuShu:::: %ld", (long)zhuShu);
    return zhuShu;
}

#pragma mark - 动画
CABasicAnimation* refreshAnimation()
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 1.0;
    rotationAnimation.repeatCount = 0;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    return rotationAnimation;
}

NSDictionary *dictionaryWithJsonString(NSString *jsonString)
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
    
}

id objectWithJsonString(NSString *jsonString, id returnData)
{
    if (jsonString == nil) {
        return returnData;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return returnData;
    }
    return dic;
}

