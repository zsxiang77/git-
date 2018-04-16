//
//  TopDanXuanCollectionView.h
//  cheDianZhang

//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCBaseCollectionViewCell.h"
#import "TopDanXuanViewModel.h"
@interface TopDanXuanCell : LCBaseCollectionViewCell

@end

@interface TopDanXuanCollectionView : UICollectionView
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) NSArray <TopDanXuanViewModel *>*dataArr; //给数据 set 方法赋值
@property (nonatomic, strong) void (^didSelect)(TopDanXuanViewModel  *vmodel);

@end
