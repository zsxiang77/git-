//
//  Car_TiShiView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Car_TiShiView : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *beiJingView;

@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@property(nonatomic,strong)UILabel *label5;
@property(nonatomic,strong)UILabel *label6;

-(void)sheZhiDataWithDict:(NSDictionary *)dict;

@end
