//
//  ScanDrivingView.h
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanDrivingView : UIView<UIGestureRecognizerDelegate>
{
    UIView *view;
    UIButton *leftBtn;
    UIButton *rightBtn;
}
@property(nonatomic,strong)UILabel*shangLable;
@property(nonatomic,strong)UILabel*xiaLable;
@property(nonatomic,strong)void (^leftBtnChcickBlock)(NSString *leftStr);
@property(nonatomic,strong)void (^rightBtnChcickBlock)(NSString *rightStr);
@property(nonatomic,strong)void (^shoDongChickBlock)(NSString *shoDongStr);
-(void)yingCangViwe;
- (void)displayViewWithChePai:(NSString *)chePai1 withChePai2:(NSString *)chePai2;//显示

@end
