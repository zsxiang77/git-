//
//  ProjectDetailsADDErCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailsADDErCell : UITableViewCell

@property(nonatomic,strong)UIImageView *zuoImageView;
@property(nonatomic,strong)UILabel *mainLabel;

@property(nonatomic,strong)UIButton *sanJiBt;
@property(nonatomic,strong)NSDictionary *model;

@property(nonatomic,strong)void (^tiaoZhanSanJiBlock)(NSDictionary *dict);

@end
