//
//  GTVerifyCodeView.h
//  codeView
//
//  Created by Thinkive on 2017/11/19.
//  Copyright © 2017年 Thinkive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VINinPutView.h"

typedef void(^OnFinishedEnterCode)(NSString *code);

@interface GTVerifyCodeView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITextField *mainTextField;
@property(nonatomic,strong)VINinPutView *vINinPutView;

- (instancetype)initWithFrame:(CGRect)frame onFinishedEnterCode:(OnFinishedEnterCode)onFinishedEnterCode;


- (void)codeBecomeFirstResponder;

@end
