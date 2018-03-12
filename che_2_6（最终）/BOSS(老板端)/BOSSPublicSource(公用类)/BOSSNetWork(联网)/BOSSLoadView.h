//
//  BOSSLoadView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BOSSLoadView : UIView
{
    UIActivityIndicatorView *m_activityView;
}
- (void)displayView;
- (void)dismissView;

@end
