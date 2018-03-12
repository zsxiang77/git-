//
//  AITCheckViewController.h
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//  AIT智能检测

#import "BaseViewController.h"
#import "CarCheckModel.h"

@interface AITCheckViewController : BaseViewController
@property (nonatomic, copy) NSString *ordercode;
@property (nonatomic, strong) CarCheckDataModel *carCheckDataModel;
@end
