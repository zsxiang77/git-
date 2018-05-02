//
//  StoreBottomView.h
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreBottomView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * mainTable;
@property(nonatomic,strong)NSMutableArray *listModel;
@end
