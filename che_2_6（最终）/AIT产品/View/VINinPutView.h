//
//  VINinPutView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VINinPutViewDelegate;

@interface VINinPutView : UIView

@property(nonatomic, assign) id<VINinPutViewDelegate> myDelegate;
@property(nonatomic,strong)UITextField *mainTextField;
@property(nonatomic,strong)void  (^quedingBlock)(void);

@end

@protocol VINinPutViewDelegate <NSObject>

@optional

- (void)shouldChangeCharactersInRangreplacementString:(NSString *)string;
- (void)fieldChangeing:(VINinPutView*) vINinPutView;



@end
