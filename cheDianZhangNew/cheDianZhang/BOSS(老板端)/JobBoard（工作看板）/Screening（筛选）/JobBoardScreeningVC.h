//
//  JobBoardScreeningVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"

@interface JobBoardScreeningVC : BOSSBaseViewController

@property(nonatomic,assign)NSInteger status;

@property(nonatomic,strong)void  (^dianJiChcickBlaock)(NSDictionary *dict);

@end
