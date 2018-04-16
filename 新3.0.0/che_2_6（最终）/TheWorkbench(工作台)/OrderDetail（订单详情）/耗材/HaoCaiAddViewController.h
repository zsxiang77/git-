//
//  HaoCaiAddViewController.h
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "XiMeiNewOrdersErModel.h"
#import "YYModel.h"
@interface HaoCaiAddViewController : BaseViewController
{
    UITableView *main_tableView[4];
    UIButton    *m_mySegBtn[4];
    NSMutableArray *main_dataArry[4];
    NSInteger yeMa[4];
}

@property(nonatomic,strong)NSMutableArray  *xuanZhongArray;

@property(nonatomic,strong)void (^xuanZhongArrayBlock)(NSArray *array);
-(void)postcommods_listWithIndex:(NSInteger )index isShuXin:(BOOL)shuaXin;
@end
