//
//  LCBottomDianJiView.h
//  cheDianZhang
//
//  Created by apple on 2018/3/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCBottomDianJiView : UIView<UIGestureRecognizerDelegate>
{
    UIButton *chuFaBt;
    UIButton *dianJiBt;
    UILongPressGestureRecognizer *longPress;
}

@end
