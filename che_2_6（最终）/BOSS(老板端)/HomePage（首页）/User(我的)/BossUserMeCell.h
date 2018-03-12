//
//  BossUserMeCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/10.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BossUserMeCell : UITableViewCell

@property(nonatomic,strong)UIImageView *touXiangImageView;
@property(nonatomic,strong)UILabel *mainLabl;

@property(nonatomic,strong)UILabel *rightLabl;
@property(nonatomic,strong)UIView *rightLablView;
@property(nonatomic,strong)UIImageView *jianTouImageView;


-(void)shanXinData:(NSString *)rightStr withZhanShi:(BOOL)zhanShui xianShiDI:(BOOL)xianshi;

@end
