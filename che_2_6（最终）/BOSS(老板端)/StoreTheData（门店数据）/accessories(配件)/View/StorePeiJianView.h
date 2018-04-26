//
//  StorePeiJianView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreYuanXingtuView.h"
@interface StorePeiJianView : UIView<UITableViewDataSource,UITableViewDelegate>

{
    UIView * anNniuView;
}
@property(nonatomic,strong)StoreYuanXingtuView * headerView;
@property(nonatomic,strong)UITableView * mainTable;
@property(nonatomic,strong)UILabel* timeDateLable;
@property(nonatomic,strong)void  (^showRiLiBlock)(void);
@end
