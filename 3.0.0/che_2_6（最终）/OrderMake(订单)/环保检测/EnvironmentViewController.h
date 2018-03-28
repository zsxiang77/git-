//
//  EnvironmentViewController.h
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//  环保检测

#import "BaseViewController.h"

@class EnvironmentDataModel;
@interface EnvironmentViewController : BaseViewController
@property (nonatomic, copy) NSString *ordercode;
@property (nonatomic, strong) EnvironmentDataModel *environmentDataModel;
@end
