//
//  LearningCenterViewController.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "WKWebViewViewController.h"
#import "LearningModel.h"
@interface LearningCenterViewController : BOSSBaseViewController
{
    NSInteger  page;
}

@property(nonatomic,strong)NSMutableArray *mainListArray;
@property(nonatomic,strong)NSMutableArray *adDatas;
@property(nonatomic,strong)UITableView *main_tableView;
- (void)buildAdView;

@end
@interface LearningCenterViewController (Net)
-(void)qingQiuLuoBoData;

@end
