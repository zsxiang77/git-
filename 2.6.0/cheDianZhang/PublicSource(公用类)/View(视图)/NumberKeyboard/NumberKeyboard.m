//
//  NumberKeyboard.m
//  zyyp
//
//  Created by shen yan ping on 15/7/27.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NumberKeyboard.h"
#import "UIImage+ImageWithColor.h"
#import "CheDianZhangCommon.h"

#define kButtonStartTag (154)

@implementation NumberKeyboard
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self customView:frame];
    }
    return self;
}


- (void)customView:(CGRect)frame
{
    // set the frame
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, 320.0f, 216.0f);
    self.backgroundColor = kRGBColor(250, 250, 250);
    
    
    // add the button
    for (int x = 0; x < 12; x++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(x%3*(kWindowW/3.0), x/3*(216.0/4.0),
                                 kWindowW/3.0, 216.0/4.0)];
        if (x <= 9)
        {
            [btn setTag:(x + 1) + kButtonStartTag];
        }
        else if (x == 11)
        {
            btn.tag = x + kButtonStartTag;
        }
        else if (x == 10)
        {
            btn.tag = kButtonStartTag;
        }
        [btn setBackgroundColor:[UIColor whiteColor]];
        if (btn.tag == 10 + kButtonStartTag) {
            [btn setImage:[UIImage imageNamed:@"IMG_0279"] forState:UIControlStateNormal];
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setBackgroundColor:kRGBColor(188, 191, 196)];
            [btn setBackgroundImage:[UIImage imageWithUIColor:kRGBColor(250, 250, 250)] forState:UIControlStateHighlighted];
            
            
        }else if (btn.tag == 11 + kButtonStartTag) {
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            [btn setBackgroundColor:kRGBColor(38, 129, 247)];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithUIColor:kRGBColor(250, 250, 250)] forState:UIControlStateHighlighted];
            
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%ld", (long)(btn.tag - kButtonStartTag)] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithUIColor:kRGBColor(200, 200, 200)] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:25];
        }
        [btn addTarget:self action:@selector(numbleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    //分割线
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, (216.0/4.0), kWindowW, 1)];
    lineView1.backgroundColor = kRGBColor(221, 221, 221);
    [self addSubview:lineView1];
    
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 2*(216.0/4.0), kWindowW, 1)];
    lineView2.backgroundColor = kRGBColor(221, 221, 221);
    [self addSubview:lineView2];
    
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 3*(216.0/4.0), kWindowW, 1)];
    lineView3.backgroundColor = kRGBColor(221, 221, 221);
    [self addSubview:lineView3];
    
    UIView * lineView4 = [[UIView alloc]initWithFrame:CGRectMake((kWindowW/3.0), 0, 1, 216.0)];
    lineView4.backgroundColor = kRGBColor(221, 221, 221);
    [self addSubview:lineView4];
    
    UIView * lineView5 = [[UIView alloc]initWithFrame:CGRectMake(2*(kWindowW/3.0), 0, 1, 216.0)];
    lineView5.backgroundColor = kRGBColor(221, 221, 221);
    [self addSubview:lineView5];
    
    
    UIView *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 1)];
    line.backgroundColor = kRGBColor(221, 221, 221);
    [self addSubview:line];
}

- (void)numbleButtonClicked:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    
    NSInteger number = btn.tag - kButtonStartTag;
    NSString* currentText = self.currentField.text;
    if (number <= 9 && number >= 0)
    {
        //两位数以上时，第一位不允许为0
        if (self.keyboardType == NumberKeyboardType_Number && [self.currentField.text intValue] == 0) {
            self.currentField.text = @"";
        }
        [self.currentField replaceRange:self.currentField.selectedTextRange withText:[NSString stringWithFormat:@"%ld", (long)number]];
        if (self.keyboardType == NumberKeyboardType_Number && [self.currentField.text intValue]>self.maxValue) {
            self.currentField.text = [NSString stringWithFormat:@"%ld",(long)self.maxValue];
        }
        else if (self.keyboardType == NumberKeyboardType_Normal && self.maxLength > 0 && self.currentField.text.length > self.maxLength){
            self.currentField.text = [self.currentField.text substringToIndex:self.maxLength];
        }
        if (self.myDelegate != nil && [self.myDelegate respondsToSelector:@selector(fieldChangeing:)]) {
            [self.myDelegate fieldChangeing:self];
        }
        return;
    }
    
    if (10 == number)
    {
        if (currentText.length == 0) {
            return;
        }
        if([self.currentField.selectedTextRange isEmpty])//没有选中字符
        {
            UITextPosition * position = [self.currentField positionFromPosition:self.currentField.selectedTextRange.start offset:-1];
            UITextRange * textRange = [self.currentField textRangeFromPosition:position toPosition:self.currentField.selectedTextRange.start];
            
            [self.currentField replaceRange:textRange withText:@""];
        }else{
            //删除所选中的字符
            [self.currentField replaceRange:self.currentField.selectedTextRange withText:@""];
        }
        if (self.myDelegate != nil && [self.myDelegate respondsToSelector:@selector(fieldChangeing:)]) {
            [self.myDelegate fieldChangeing:self];
        }
        return;
    }
    
    if (11 == number)
    {
        [self.currentField resignFirstResponder];
    }
}

@end
