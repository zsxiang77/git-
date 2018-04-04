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
-(instancetype)initWithFrame:(CGRect)frame withZuoTitle:(NSString *)zuoStr withYouStr:(NSString *)youStr;
@property(nonatomic,assign)BOOL dianJiSelect;

@property(nonatomic,strong)void (^dianJiSelectBlock)(BOOL dianSender);
-(void)setBuJuOrZhuangTai;

@end

