//
//  CommonControlOrView.m
//  GameGroup
//
//  Created by shenyanping on 13-12-16.
//  Copyright (c) 2013年 Swallow. All rights reserved.
//

#import "CommonControlOrView.h"
#import "CheDianZhangCommon.h"

@implementation CommonControlOrView

+ (UIButton*)setButtonWithFrame:(CGRect)btnFrame title:(NSString*)title fontSize:(UIFont*)font textColor:(UIColor*)textColor bgImage:(UIImage*)bgImage HighImage:(UIImage*)highImg selectImage:(UIImage*)selectImg;
{
    UIButton* tempButton = [[UIButton alloc] initWithFrame:btnFrame];
    [tempButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [tempButton setBackgroundImage:highImg forState:UIControlStateHighlighted];
    [tempButton setBackgroundImage:selectImg forState:UIControlStateSelected];
    [tempButton setTitle:title forState:UIControlStateNormal];
    [tempButton setTitleColor:textColor forState:UIControlStateNormal];
    tempButton.titleLabel.font = font;
    
    return tempButton;
}

+ (UILabel*)setLabelWithFrame:(CGRect)myFrame textColor:(UIColor*)myColor font:(UIFont*)myFont text:(NSString*)text textAlignment:(NSTextAlignment)alignment
{
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:myFrame];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = myColor;
    nameLabel.font = myFont;
    nameLabel.text = text;
    nameLabel.textAlignment = alignment;
    
    return nameLabel;
}

+ (UIImageView*)setLineImageWithFrame:(CGRect)myFrame
{
    UIImageView *line = [[UIImageView alloc] initWithFrame:myFrame];
    line.backgroundColor = kLineBgColor;

    return line;
}

+(NSAttributedString *)attributedStringWithHtml:(NSString *)html
{
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding allowLossyConversion:YES] options:options documentAttributes:nil error:nil];
    return attrString;
    
}

@end
