//
//  NewMaterialViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "XiMeiXinZengZuiZongModel.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "XiMeiNewOrdersErModel.h"
#import "YYModel.h"


@interface NewMaterialViewController : BaseViewController
{
    UITableView *main_tableView[4];
    UIButton    *m_mySegBtn[4];
    NSMutableArray *main_dataArry[4];
    NSInteger yeMa[4];
}
@property(nonatomic,strong)XiMeiXinZengZuiZongModel *zuiZongModel;

@property(nonatomic,strong)NSMutableArray  *xuanZhongArray;

@property(nonatomic,strong)void (^xuanZhongArrayBlock)(NSArray *array);

@end


@interface NewMaterialViewController (Net)
-(void)postcommods_listWithIndex:(NSInteger )index isShuXin:(BOOL)shuaXin;

@end
