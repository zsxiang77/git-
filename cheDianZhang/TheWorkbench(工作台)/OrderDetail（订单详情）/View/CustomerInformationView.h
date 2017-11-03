//
//  CustomerInformationView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/21.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface CustomerInformationView : UIView<UIGestureRecognizerDelegate>
{
    UIView  *zhuView;
    UIImageView  *zhuImageView;
    UILabel  *nameLabel;
    UILabel  *car_nmuber;
    UILabel  *car_xingxi;
    UIButton  *phonebt;
}

-(void)setYeMianWithOrderDetailModel:(OrderDetailModel *)zhuModel;

@end
