//
//  WritePersonalInputTFView.h
//  cheDianZhang
//
//  Created by sykj on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMUITextField.h"

@interface WritePersonalInputTFView : UIView
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) QMUITextField *textField;

@property (nonatomic, assign) BOOL isRedTitle;
@property (nonatomic, assign) BOOL isHiddenLine;

@property(nonatomic, copy) void (^textFieldTextChangeBlock)(NSString *text);

@property(nonatomic, copy) void (^textFieldValueChangeCallBack)(NSString *text);

@end
