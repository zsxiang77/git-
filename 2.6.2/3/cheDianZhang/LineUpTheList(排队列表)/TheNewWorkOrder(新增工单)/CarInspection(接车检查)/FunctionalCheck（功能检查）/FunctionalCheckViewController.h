//
//  FunctionalCheckViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "JieCheInformiTionVC.h"
#import "Car_zongModel.h"


@interface FunctionalCheckViewController : BaseViewController

@property(nonatomic,strong)NSMutableArray *chuRuArray;

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@end
