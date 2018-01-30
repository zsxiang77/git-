//
//  SellerInForMetionView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface SellerInForMetionView : UIView<UIGestureRecognizerDelegate>
{
    UIView  *zhuView;
    UIImageView  *zhuImageView;
    UILabel  *nameLabel;
    UIButton  *phonebt;
}

-(void)setYeMianWithOrderDetailModel:(OrderDetailModel *)zhuModel;

@end
