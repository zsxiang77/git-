//
//  MykechengViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "MyKechengModel.h"
#import "LearningVideoViewController.h"
@interface MykechengViewController : BOSSBaseViewController
{
    NSInteger     page;
    NSMutableArray *main_dataArry;
}
@property(nonatomic,strong)UITableView *mainTableView;
@end
