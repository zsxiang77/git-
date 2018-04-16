//
//  NewInputView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewInputViewDelegate;
@interface NewInputView : UIView
@property(nonatomic,strong)UIView *hanziView;
@property(nonatomic,strong)UIView *shuziView;
@property(nonatomic,strong)UIView *qitaView;
@property(nonatomic,strong)UIButton *contentBtn;


@property(nonatomic, assign) id<NewInputViewDelegate> myDelegate;
@property(nonatomic,strong)UITextField *mainTextField;
@property(nonatomic,strong)void  (^quedingBlock)(void);
@property(nonatomic,strong)void  (^quxiaoBlock)(void);
@property(nonatomic,strong)void  (^shoWqieHuan)(BOOL stre);
@end

@protocol NewInputViewDelegate <NSObject>

@optional

- (void)shouldChangeCharactersInRangreplacementString:(NSString *)string;
- (void)fieldChangeing:(NewInputView*) vINinPutView;
@end
