//
//  OrderDetailProjectPGView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaiGongModel.h"

@interface OrderDetailProjectPGView : UIView<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *zhuView;
    UIView *erJiView;
    
    UITableView *zhuTableView;
    UITableView *erJiTableView;
    
    UILabel *yiXuanLabel;
}
-(void)zhuXianShi;


@property(nonatomic,strong)NSArray *chuanZhiArray;

@property(nonatomic,strong)NSArray *xuanZhongArray;
@property(nonatomic,strong)NSMutableArray *queDingArray;

@property(nonatomic,strong)void   (^queDingBlock)(void);
@end
