//
//  FillVINCodeHeaderView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTVerifyCodeView.h"
#import "CheDianZhangCommon.h"

@interface FillVINCodeHeaderView : UIView

@property(nonatomic,strong)UILabel *zhuLabel;
@property (nonatomic, strong) GTVerifyCodeView *codeView;
@property(nonatomic,strong)UILabel *shengLabel;
@property(nonatomic,strong)UILabel *renTishilabel;

@property(nonatomic,strong)void (^codeChange)(NSString *str);

@end
