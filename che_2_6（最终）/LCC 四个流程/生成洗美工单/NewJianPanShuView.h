//
//  NewJianPanShuView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewJianPanShuView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic ,retain) UIView*                 contentView;
@property(nonatomic ,copy) void(^okClick)(NSString*);

@property(nonatomic,assign)NSInteger       xiaoShuWeiShu;
@property(nonatomic,assign)CGFloat       zuiDaZhiFloat;

/**
 @param value 初始倍数
 */
- (instancetype)initWithFrame:(CGRect)frame value:(NSString*)value;

- (void)dissMissView;
- (void)displayView;//显示

@end
