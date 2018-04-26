//
//  StoreRenYuanView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreRenYuanView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTable;
@property(nonatomic,strong)UILabel * timeDateLable;
@property(nonatomic,strong)UIView * headerView;
@property(nonatomic,strong)NSMutableArray * zhuanzhiModel;
@property(nonatomic,strong)void  (^showRiLiBlock)(void);
@property(nonatomic,strong)void  (^xuanzhonRowBlock)(NSMutableArray *zhi,NSString* year,NSString*month);
@end
