//
//  TheWorkbenchNewCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheWorkModel.h"
#import "UIImageView+WebCache.h"

@interface TheWorkbenchNewCell : UITableViewCell

@property(nonatomic,strong)UILabel *topCarNumberLa;
@property(nonatomic,strong)UIImageView *topMianImageView;
@property(nonatomic,strong)UILabel *topShuoMLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *topStateLabel;
@property(nonatomic,strong)UIImageView *stateImageView;

@property(nonatomic,strong)UIImageView  *suoImageView;

@property(nonatomic,strong)UIImageView *youShangImageView;
@property(nonatomic,strong)UILabel *youShangLabel;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel   *aitLabel;
@property(nonatomic,strong)UIImageView   *aitImageView;


-(void)refeleseWithModel:(TheWorkModel *)model;

@end
