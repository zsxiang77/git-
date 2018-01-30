//
//  PartsSubsidiaryCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface PartsSubsidiaryCell : UITableViewCell

@property(nonatomic,strong)UILabel *biaoTiLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *gongShiLabel;
@property(nonatomic,strong)UILabel *gongShiFeiLabel;
@property(nonatomic,strong)UILabel *nuberLaber;

@property(nonatomic,strong)UILabel *benDiLael1;
@property(nonatomic,strong)UILabel *benDiLael2;
@property(nonatomic,strong)UILabel *benDiLael3;
@property(nonatomic,strong)UILabel *benDiLael4;

@property(nonatomic,strong)UIButton *xuanZhongBt;
@property(nonatomic,strong)UIButton *jianBt;
@property(nonatomic,strong)UIButton *jiaBt;
@property(nonatomic,strong)UIButton *xiuGaiGongShiBT;
@property(nonatomic,strong)UIButton *gongShiFeiBt;

@property(nonatomic,strong)void (^tableViewShuaXinBlock)(void);
@property(nonatomic,strong)void (^buNengWeiLing)(void);
@property(nonatomic,strong)void (^xiuGaiGongShiBlock)(PeiJianListModel *peiJianListModel);
@property(nonatomic,strong)void (^xiuGaiGongShiFeiBlock)(PeiJianListModel *peiJianListModel);


@property(nonatomic,strong)PeiJianListModel *peiJianListModel;

-(void)refelesePeiJianWithModel:(PeiJianListModel *)model;

@end
