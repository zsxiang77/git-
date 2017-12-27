//
//  AITBuyView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AITBuyView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic,strong)void (^fanHuiPopBlock)(void);
@property(nonatomic,strong)UILabel *daoLabel;

@end
