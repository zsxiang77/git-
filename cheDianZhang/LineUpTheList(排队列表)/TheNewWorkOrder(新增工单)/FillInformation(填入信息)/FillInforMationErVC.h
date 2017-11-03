//
//  FillInforMationErVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "FillInforMationErCell.h"
#import "HPGrowingTextView.h"
#import "CarInspectionViewController.h"
#import "Car_zongModel.h"


@interface FillInforMationErVC : BaseViewController
@property(nonatomic,strong)HPGrowingTextView *schemeTextView;
@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@end
