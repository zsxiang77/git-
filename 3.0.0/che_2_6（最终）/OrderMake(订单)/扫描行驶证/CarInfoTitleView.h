//
//  CarInfoTitleView.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoTitleView : UIView
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isHiddenButton;

@property(nonatomic, copy) void (^didChooseCarButtonCallBack)(void);
@end
