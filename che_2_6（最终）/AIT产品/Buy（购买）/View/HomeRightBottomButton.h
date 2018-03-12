//
//  HomeRightBottomButton.h
//  DaJiang365
//
//  Created by shenYanPing on 17/5/30.
//  Copyright © 2017年 泰宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRightBottomButton : UIButton
- (BOOL)isShowStatus;

/**
 0到45度 隐藏状态
 */
- (void)animationWithRotation0_45;

/**
 45到0度 正常状态
 */
- (void)animationWithRotation45_0;

- (void)animationWithRotation0_10;
- (void)animationWithRotation10_0;
@end
