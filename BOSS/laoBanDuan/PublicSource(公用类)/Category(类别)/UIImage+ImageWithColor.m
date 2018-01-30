//
//  UIImage+ImageWithColor.m
//  CalculatorForiPad
//
//  Created by shenyanping on 14-10-15.
//  Copyright (c) 2014年 shenyanping. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithUIColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithBgColor:(UIColor *)color overImage:(UIImage *)image drawInSize:(CGSize)size
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGRect rect = CGRectZero;
    rect.size = size;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, screenScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    [image drawInRect:CGRectMake((rect.size.width-image.size.width)/2.0, (rect.size.height-image.size.height)/2.0, image.size.width, image.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
    
}
@end
