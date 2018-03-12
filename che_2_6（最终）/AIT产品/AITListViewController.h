//
//  AITListViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "AITListCell.h"

@interface AITListViewController : BaseViewController
@property(nonatomic,strong)UITableView  *main_tabelView;

@property(nonatomic,strong)void (^shuXianNumber)(NSInteger sender);

@end
