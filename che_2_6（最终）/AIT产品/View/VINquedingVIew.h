//
//  VINquedingVIew.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/29.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VINquedingVIew : UIView<UIGestureRecognizerDelegate>

@property(nonatomic,strong)void (^fanHuiPopBlock)(void);
@property(nonatomic,strong)UILabel *daoLabel;

@end
