//
//  MultipleKeyBoard.h
//  DaJiang365
//
//  Created by shen yan ping on 16/10/19.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleKeyBoard : UIView<UIGestureRecognizerDelegate>

@property(nonatomic ,retain) UIView*                 contentView;
@property(nonatomic ,copy) void(^okClick)(NSString*);

/**
 @param value 初始倍数
 */
- (instancetype)initWithFrame:(CGRect)frame value:(NSString*)value;

- (void)dissMissView;
- (void)displayView;//显示
@end
