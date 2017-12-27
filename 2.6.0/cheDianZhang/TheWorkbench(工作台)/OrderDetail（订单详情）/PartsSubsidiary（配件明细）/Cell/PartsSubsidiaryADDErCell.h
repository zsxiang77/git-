//
//  PartsSubsidiaryADDErCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface PartsSubsidiaryADDErCell : UITableViewCell

@property(nonatomic,strong)UIImageView  *xuanZhongImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *kuCunLabel;
@property(nonatomic,strong)UILabel *bianHaoLabel;

-(void)refelesePeiJianWithModel:(PeiJianListModel *)model;

@end
