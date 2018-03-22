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
}
@property(nonatomic,strong)UILabel*shangLable;
@property(nonatomic,strong)UILabel*xiaLable;
-(void)yingCangViwe;
- (void)displayView;

@end
