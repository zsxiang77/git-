//
//  OrderDetailShaiXuanView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailShaiXuanView : UIView<UIGestureRecognizerDelegate>
{
    UIButton *daiShiGongBt;
    UIButton *yiWanChengBt;
    UIButton *daiChuChangBt;
    UIButton *daiDaiJieSuanBt;
}

@property(nonatomic,assign)NSInteger indexPage;

@property(nonatomic,strong)void (^yingCangViweBlock)(void);
@property(nonatomic,strong)void (^dianJiAnNiuBtChickBlock)(NSInteger index);

-(void)yingCangViwe;
- (void)displayView;

@end
