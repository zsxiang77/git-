//
//  LearningJieShaoView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/27.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearningJieShaoView : UIView<UIGestureRecognizerDelegate>
{
    UIView *mainView;
    UILabel *headerLabel;
    UILabel *contentLabel;
}

-(void)shuanXinDataWithTitle:(NSString *)title WithContent:(NSString *)content;

@end
