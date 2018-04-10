//
//  LearningZiCeViewController.h
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "LearningWrongModel.h"

@interface LearningZiCeViewController : BOSSBaseViewController
@property(nonatomic,strong)UILabel * cuoTiCount;
@property(nonatomic,strong)LearningWrongModel *chuanZhiDict;
@property(nonatomic,strong)BOSSBaseViewController *fatherViewController;
@property(nonatomic,strong)BOSSBaseViewController *backCeshiViewController;//返回答题页面
@end
