//
//  OrderDetailCell2.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/21.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailCell2 : UITableViewCell

@property(nonatomic,strong)UILabel *biaoTiLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *gongShiLabel;
@property(nonatomic,strong)UILabel *gongShiFeiLabel;
@property(nonatomic,strong)UILabel *nuberLaber;

@property(nonatomic,strong)UILabel *benDiLael1;
@property(nonatomic,strong)UILabel *benDiLael2;
@property(nonatomic,strong)UILabel *benDiLael3;
@property(nonatomic,strong)UILabel *benDiLael4;

-(void)refeleseWithModel:(OrignalModel *)model;
-(void)refelesePeiJianWithModel:(PeiJianListModel *)model;

@end
