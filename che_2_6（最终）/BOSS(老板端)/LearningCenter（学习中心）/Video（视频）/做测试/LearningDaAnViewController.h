//
//  LearningDaAnViewController.h
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "LearningWrongModel.h"
#import "LearningZuoCeShiViewController.h"

@interface LearningDaAnViewController : BOSSBaseViewController

@property(nonatomic,strong)LearningWrongModel *chuanZhiDict;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)BOSSBaseViewController *fatherViewController;
@end
