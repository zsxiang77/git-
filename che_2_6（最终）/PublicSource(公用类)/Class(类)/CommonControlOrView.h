//
//  CommonControlOrView.h
//  GameGroup
//
//  Created by shenyanping on 13-12-16.
//  Copyright (c) 2013年 Swallow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonControlOrView : NSObject

+ (UIButton*)setButtonWithFrame:(CGRect)btnFrame title:(NSString*)title fontSize:(UIFont*)font textColor:(UIColor*)textColor bgImage:(UIImage*)bgImage HighImage:(UIImage*)highImg selectImage:(UIImage*)selectImg;

+ (UILabel*)setLabelWithFrame:(CGRect)myFrame textColor:(UIColor*)myColor font:(UIFont*)myFont text:(NSString*)text textAlignment:(NSTextAlignment)alignment;

+ (UIImageView*)setLineImageWithFrame:(CGRect)myFrame;

/** attributedstring处理html标签 
 warn 会卡 */
+(NSAttributedString *)attributedStringWithHtml:(NSString *)html;
@end
