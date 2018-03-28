//
//  WritePersonalUnitInfoView.h
//  cheDianZhang
//
//  Created by sykj on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WritePersonalViewController.h"
#import "WriteSaoMiaoView.h"

@interface WritePersonalUnitInfoView : UIView
@property (nonatomic, strong) NSString *unit_full_name;
@property (nonatomic, strong) NSString *store_alias; ///< 企业简称
@property (nonatomic, strong) NSString *mobile;


@property (nonatomic, strong) WriteSaoMiaoView *sendInfoView;
@property (nonatomic, weak) WritePersonalViewController *viewController;

@property (nonatomic, copy) void (^userInfoChangeCallBack)(void);

@end
