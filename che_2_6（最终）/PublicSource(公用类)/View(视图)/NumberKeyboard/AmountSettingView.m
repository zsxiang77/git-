//
//  AmountSettingView.m
//  zyyp
//
//  Created by shen yan ping on 15/6/1.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

#import "AmountSettingView.h"
#import "SomeCFuction.h"
#import "CheDianZhangCommon.h"
#import "CommonControlOrView.h"

static NSString* const NUMBERS  = @"0123456789\n";//只允许输入数字

@implementation AmountSettingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame maxValue:(NSInteger)maxValue
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxValue = maxValue;

        float viewHeight = CGRectGetHeight(frame);
        m_minusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewHeight, viewHeight)];
        [m_minusButton setBackgroundColor:kColorWithRGB(237, 237, 237, 1.0)];
        [m_minusButton setTitle:@"-" forState:UIControlStateNormal];
        [m_minusButton setTitleColor:kColorWithRGB(110, 110, 110, 1.0) forState:UIControlStateNormal];
        m_minusButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 0);
        m_minusButton.titleLabel.font = DJBoldSystemFont(20.0);
        m_minusButton.layer.masksToBounds = YES;
        m_minusButton.layer.borderColor = [kColorWithRGB(224, 224, 224, 1.0) CGColor];
        m_minusButton.layer.borderWidth = 0.5;
        [m_minusButton addTarget:self action:@selector(changedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_minusButton];
        
        float viewWidth = CGRectGetWidth(frame);
        m_amountField = [[UITextField alloc] initWithFrame:CGRectMake(viewHeight, 0, viewWidth - 2 * viewHeight, viewHeight)];
        m_amountField.font = DJSystemFont(13.0);
        m_amountField.delegate = self;
        m_amountField.textColor = [UIColor blackColor];
        m_amountField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        m_amountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        m_amountField.textAlignment = NSTextAlignmentCenter;
        m_amountField.returnKeyType = UIReturnKeyDone;
//        m_amountField.layer.masksToBounds = YES;
//        m_amountField.layer.borderColor = [kColorWithRGB(210, 210, 210, 1.0) CGColor];
//        m_amountField.layer.borderWidth = 0.5;
        [m_amountField addTarget:self action:@selector(textFieldTextChanged) forControlEvents:UIControlEventEditingChanged];
        m_amountField.adjustsFontSizeToFitWidth = YES;
        [self addSubview:m_amountField];
        NumberKeyboard* keyBord = [[NumberKeyboard alloc] init];
        keyBord.keyboardType = NumberKeyboardType_Number;
        keyBord.maxValue = self.maxValue;
        keyBord.myDelegate = self;
        keyBord.currentField = m_amountField;
        m_amountField.inputView = keyBord;

        m_plusButton = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth - viewHeight, 0, viewHeight, viewHeight)];
        [m_plusButton setBackgroundColor:kColorWithRGB(237, 237, 237, 1.0)];
        [m_plusButton setTitle:@"+" forState:UIControlStateNormal];
        m_plusButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 0);
        m_plusButton.titleLabel.font = DJBoldSystemFont(20.0);
        [m_plusButton setTitleColor:kColorWithRGB(110, 110, 110, 1.0) forState:UIControlStateNormal];
        m_plusButton.layer.masksToBounds = YES;
        m_plusButton.layer.borderColor = [kColorWithRGB(224, 224, 224, 1.0) CGColor];
        m_plusButton.layer.borderWidth = 0.5;
        [m_plusButton addTarget:self action:@selector(changedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_plusButton];
        
        UIImageView* topLine = [CommonControlOrView setLineImageWithFrame:CGRectMake(viewHeight, 0, viewWidth - 2 * viewHeight, 0.5)];
        [self addSubview:topLine];
        
        UIImageView* bottomLine = [CommonControlOrView setLineImageWithFrame:CGRectMake(viewHeight, viewHeight - 0.5, CGRectGetWidth(topLine.frame), 0.5)];
        [self addSubview:bottomLine];
    }
    return self;
}

- (void)setButtonHidden
{
    m_plusButton.hidden = YES;
    m_minusButton.hidden = YES;
    m_amountField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    m_amountField.layer.masksToBounds = YES;
    m_amountField.layer.borderColor = [kColorWithRGB(213, 213, 213, 1.0) CGColor];
    m_amountField.layer.borderWidth = 1;
    m_amountField.layer.cornerRadius = 3;
    m_amountField.adjustsFontSizeToFitWidth = YES;
}

- (void)setAmountFieldValue:(NSString*)amount
{
    if (m_amountField) {
        [m_amountField setText:amount];
    }
    [self refreshButtonTitleColor];
}

- (NSString*)getAmountFieldValue
{
    return m_amountField.text;
}

- (void)hideKeyBoard
{
    [m_amountField resignFirstResponder];
}

- (void)changedButtonClick:(UIButton*)button
{    
    NSInteger amountValue = [m_amountField.text integerValue];
    if (m_plusButton == button) {
        if (amountValue > self.maxValue-1) {
            return;
        }
        [m_amountField setText:[NSString stringWithFormat:@"%ld", (long)(amountValue+1)]];
    }
    else if (m_minusButton == button) {
        if (amountValue < 2) {
            return;
        }
        [m_amountField setText:[NSString stringWithFormat:@"%ld", (long)(amountValue-1)]];
    }
    if ([self.myDelegate respondsToSelector:@selector(textFieldChangedWithStatus:value:)]) {
        [self.myDelegate textFieldChangedWithStatus:AMOUNT_EDIT_ING value:[self getAmountFieldValue]];
    }
    [self refreshButtonTitleColor];
}

/**
 刷新button title的颜色 <2或>9999时
 */
- (void)refreshButtonTitleColor
{
    NSInteger amountValue = [m_amountField.text integerValue];
    if (amountValue < 2) {
        [m_plusButton setTitleColor:kColorWithRGB(110, 110, 110, 1.0) forState:UIControlStateNormal];
        [m_minusButton setTitleColor:kColorWithRGB(216, 216, 216, 1.0) forState:UIControlStateNormal];
    }
    else if (amountValue > self.maxValue-1){
        [m_plusButton setTitleColor:kColorWithRGB(216, 216, 216, 1.0) forState:UIControlStateNormal];
        [m_minusButton setTitleColor:kColorWithRGB(110, 110, 110, 1.0) forState:UIControlStateNormal];
    }
    else{
        [m_plusButton setTitleColor:kColorWithRGB(110, 110, 110, 1.0) forState:UIControlStateNormal];
        [m_minusButton setTitleColor:kColorWithRGB(110, 110, 110, 1.0) forState:UIControlStateNormal];
    }
}

#pragma mark textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.myDelegate respondsToSelector:@selector(textFieldChangedWithStatus:value:)]) {
        [self.myDelegate textFieldChangedWithStatus:AMOUNT_EDIT_BEGIN value:[self getAmountFieldValue]];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //选中输入的内容
    UITextPosition * position = textField.beginningOfDocument;
    UITextRange * textRange = [textField textRangeFromPosition:position toPosition:textField.selectedTextRange.end];
    textField.selectedTextRange = textRange;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([m_amountField.text integerValue] < 1) {
        m_amountField.text = @"1";
    }
    if ([self.myDelegate respondsToSelector:@selector(textFieldChangedWithStatus:value:)]) {
        [self.myDelegate textFieldChangedWithStatus:AMOUNT_EDIT_END value:[self getAmountFieldValue]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    if (canChange && [[m_amountField.text stringByAppendingString:string] integerValue] > self.maxValue) {
        m_amountField.text = [NSString stringWithFormat:@"%ld", (long)self.maxValue];
        [self refreshButtonTitleColor];
        return NO;
    }
    return canChange;
}

- (void)textFieldTextChanged
{
    [self refreshButtonTitleColor];
}
@end
