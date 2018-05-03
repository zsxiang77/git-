//
//  StorePeiJianView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreYuanXingtuView.h"
#import "StoreCunView.h"
@interface StorePeiJianView : UIView

{
    UIView * anNniuView;
}


@property(nonatomic,strong)StoreYuanXingtuView * headerView;
@property(nonatomic,strong)StoreCunView * cunView;


@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UILabel* timeDateLable;
@property(nonatomic,strong)NSMutableArray *zhuanzhiModel;
@property(nonatomic,strong)void  (^showRiLiBlock)(void);
@property(nonatomic,strong)void(^dianjihide)(BOOL showBool);


@end
