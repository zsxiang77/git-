//
//  NumberKeyboard.h
//  zyyp
//
//  Created by shen yan ping on 15/7/27.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 自定义数字键盘
 */
typedef NS_ENUM(NSInteger, NumberKeyboardType) {
    NumberKeyboardType_Normal,
    NumberKeyboardType_Number,//int型
};

@protocol NumKeyboardDelegate;

@interface NumberKeyboard : UIView

@property(nonatomic, assign) id<NumKeyboardDelegate> myDelegate;
@property(nonatomic, strong) UITextField*  currentField;
@property(nonatomic, assign) NSInteger maxValue;//NumberKeyboardType_Number最大数值
@property(nonatomic, assign) NSInteger maxLength;//NumberKeyboardType_Normal最大长度
@property(nonatomic, assign) NumberKeyboardType keyboardType;
@end

@protocol NumKeyboardDelegate <NSObject>

@optional
- (void)fieldChangeing:(NumberKeyboard*) numKeyboard;

@end
