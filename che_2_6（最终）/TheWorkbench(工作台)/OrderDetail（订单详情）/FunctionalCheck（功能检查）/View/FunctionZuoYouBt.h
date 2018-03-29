//
//  FunctionZuoYouBt.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionZuoYouBt : UIView
{
    UIView *zuoBeiView;
    UIView *youBeiView;
    UILabel *zuoBeiLabel;
    UILabel *youBeiLabel;

    UIButton *dianDianBt;
}

@property(nonatomic,assign)BOOL dianJiSelect;
-(void)setBuJuOrZhuangTai;

@end
