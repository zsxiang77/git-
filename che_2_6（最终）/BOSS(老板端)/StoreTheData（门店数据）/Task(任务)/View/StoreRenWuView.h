//
//  StoreRenWuView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTheDataModel.h"
#import "StoreHeaderView.h"
@interface StoreRenWuView : UIView<UITableViewDataSource,UITableViewDelegate>

{
    UIScrollView * scrollView;
    UIView * anNniuView;
}
@property(nonatomic,strong)UITableView *mainTable;
@property(nonatomic,strong)UILabel * timeDateLable;
@property(nonatomic,strong)StoreHeaderView * headerView;

@property(nonatomic,strong)StoreTheDataModel * zhauModel;

@property(nonatomic,assign)BOOL shiFouRenYuan;
@end
