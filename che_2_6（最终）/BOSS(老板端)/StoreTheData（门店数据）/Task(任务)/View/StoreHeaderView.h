//
//  StoreHeaderView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreHeaderView : UIView
{
    UIScrollView * scrollView;
    UIView * anNniuView;
}
@property(nonatomic,strong)UILabel * timeDateLable;
@property(nonatomic,strong)void  (^showRiLiBlock)(void);
@property(nonatomic,strong)void  (^renYuanShiXiangQieBlock)(NSInteger index);
@end
