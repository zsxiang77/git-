//
//  ConstructionPersonnelCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface ConstructionPersonnelCell : UITableViewCell
@property(nonatomic,strong)UILabel *shangLabel;
@property(nonatomic,strong)UILabel *xiaLabel;
@property(nonatomic,strong)UIImageView *youImageView;

-(void)refeleseWithModel:(OrignalModel *)model;

@end
