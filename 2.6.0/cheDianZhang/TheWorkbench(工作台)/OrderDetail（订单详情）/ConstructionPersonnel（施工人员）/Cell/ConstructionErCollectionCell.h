//
//  ConstructionErCollectionCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstructionPersonnelErModel.h"
#import "CheDianZhangCommon.h"

@interface ConstructionErCollectionCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *maiImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *youShangBt;
@property(nonatomic,strong)ConstructionStaffModel *zhuModel;

@property(nonatomic,strong)void (^shanChuBtBlock)(ConstructionStaffModel *model);

@end
