//
//  AmountSettingView.h
//  zyyp
//
//  Created by shen yan ping on 15/6/1.
//  Copyright (c) 2015年 寻医问药. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberKeyboard.h"

/**
 数量(倍数)选择 支持输入 加减
 */
typedef NS_ENUM(NSInteger, AmountFieldEditStatus) {
    AMOUNT_EDIT_BEGIN,//开始编辑
    AMOUNT_EDIT_ING,//点击按钮修改中
    AMOUNT_EDIT_END,//结束编辑
};

@protocol AmountSettingDelegate;

@interface AmountSettingView : UIView<UITextFieldDelegate, NumKeyboardDelegate>
{
    UIButton* m_plusButton;
    UIButton* m_minusButton;
    
    UITextField* m_amountField;
}
@property(nonatomic, assign)id<AmountSettingDelegate> myDelegate;
@property(nonatomic, assign)NSInteger maxValue;

- (instancetype)initWithFrame:(CGRect)frame maxValue:(NSInteger)maxValue;
/**
 设置默认的textfield value
 */
- (void)setAmountFieldValue:(NSString*)amount;

/**
 得到textfield value
 */
- (NSString*)getAmountFieldValue;

/** 不需要加减号 */
- (void)setButtonHidden;

- (void)hideKeyBoard;
@end

@protocol AmountSettingDelegate <NSObject>

/**
 * @brief textField开始或完成编辑.
 *
 * @param  value 值.
 *
 * @return nil.
 */
/**
  amountSetting textField开始或完成编辑
 */
- (void)textFieldChangedWithStatus:(AmountFieldEditStatus)editStatus value:(NSString*)amountValue;

@end
