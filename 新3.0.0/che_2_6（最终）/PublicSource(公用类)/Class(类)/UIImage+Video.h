//
//  UIImage+Video.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/21.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Video)

+(UIImage *)imageWithVieo:(NSURL *)url;

//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content;

//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size;
//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
