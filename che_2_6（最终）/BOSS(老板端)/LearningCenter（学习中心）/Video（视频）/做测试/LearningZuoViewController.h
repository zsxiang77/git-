//
//  LearningZuoViewController.h
//  cheDianZhang
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "LearningWrongModel.h"


@interface LearningZuoViewController : BOSSBaseViewController
@property(nonatomic,strong)NSString  *exam_id;
@property(nonatomic,assign)NSInteger diJiTi;
@property(nonatomic,strong)NSArray *chuanZhiArray;
@property(nonatomic,strong)BOSSBaseViewController *fatherViewController;
@property(nonatomic,strong)BOSSBaseViewController *backCeshiViewController;//返回答题页面
@end
