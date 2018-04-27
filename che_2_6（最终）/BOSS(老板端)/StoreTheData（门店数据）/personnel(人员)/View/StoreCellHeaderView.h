//
//  StoreCellHeaderView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreRenyuanModel.h"
#import "StoreDetliModel.h"
@interface StoreCellHeaderView : UIView
{
    UIImageView  *touImgview;
    UILabel      *shunxuLable;
    UIImageView  *renYuanimgview;
    UILabel      *nameLable;
}
@property(nonatomic,strong)listModel* modes;
@property(nonatomic,strong)StoreDetliModel * dataModel;
@property(nonatomic,assign)NSInteger indexRow;

-(void)reloadData;
@end
