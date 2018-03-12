//
//  YCGDViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/20.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "JobBoardModel.h"
#import "CPHFWeiHeaderView.h"
#import "JobBoardDetailModel.h"

@interface YCGDViewController : BOSSBaseViewController
@property(nonatomic,strong)JobBoardModel *chuanZhiModel;

@property(nonatomic,strong)JobBoardDetailModel *mainDataDict;
@property(nonatomic,strong)NSMutableArray *maiChuLiArray;
@end
