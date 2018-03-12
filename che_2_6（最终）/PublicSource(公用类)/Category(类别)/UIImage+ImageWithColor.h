//
//  UIImage+ImageWithColor.h
//  CalculatorForiPad
//
//  Created by shenyanping on 14-10-15.
//  Copyright (c) 2014年 shenyanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)

/**
 纯色图片
 */
+ (UIImage *)imageWithUIColor:(UIColor *)color;

/**
 制作带背景色和图片居中的图片
 */
+ (UIImage *)imageWithBgColor:(UIColor *)color overImage:(UIImage *)image drawInSize:(CGSize)size;

@end
