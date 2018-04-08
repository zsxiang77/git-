//
//  HaoCaiViewController.h
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"

@interface HaoCaiViewController : BaseViewController

@property(nonatomic,strong)NSArray *chuanZhiArray;

@property(nonatomic,strong)NSString    *ordercode;
@property(nonatomic,strong)NSMutableArray *xinZengArray;

@property(nonatomic,strong)UITableView  *main_tabelView;
@end
