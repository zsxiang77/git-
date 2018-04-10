//
//  LearningZuoCeShiViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "LearningVideoModel.h"
#import "LearningZuoCeShiModel.h"
@interface LearningZuoCeShiViewController : BOSSBaseViewController

@property(nonatomic,strong)LearningVideoModel *chuanZhiModel;
@property(nonatomic,strong)UILabel *numberLabel2;

@property(nonatomic,strong)NSMutableArray     *mainArray;

@property(nonatomic,strong)BOSSBaseViewController *fatherViewController;
-(void)qingQiuGet_questionData;
@end
