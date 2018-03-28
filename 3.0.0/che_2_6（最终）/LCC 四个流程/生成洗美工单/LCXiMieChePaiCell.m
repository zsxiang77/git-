//
//  LCXiMieChePaiCell.m
//  测试
//
//  Created by lcc on 2018/2/4.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "LCXiMieChePaiCell.h"
@interface LCXiMieChePaiCell()
@property (nonatomic, strong) UILabel *carPlateNumLB;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIImageView *iconImageView;
@end
@implementation LCXiMieChePaiCell

- (void)setUpViews{
    
    UIView *backView = ({
        UIView *v = [[UIView alloc]init];
        [self.contentView addSubview:v];
        v.layer.cornerRadius = 2.5;
        v.layer.masksToBounds = YES;
        v.backgroundColor = UIColorHex(#007AFF);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(94);
        }];
        v;
    });
    
    self.carPlateNumLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [backView addSubview:lb];
        lb.layer.cornerRadius = 2.5;
        lb.layer.masksToBounds = YES;
        lb.layer.borderColor = UIColorHex(#FFFFFF).CGColor;
        lb.layer.borderWidth = 0.5;
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#FFFFFF);
        lb.textAlignment = NSTextAlignmentCenter;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(3, 3, 3, 3));
        }];
        lb.text = @"京A02009";
        lb;
    });
    
    
    
    self.nameLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#858488);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_offset(0);
        }];
        lb.text = @"宝马X5";
        lb;
    });
    
    self.iconImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.backgroundColor = [UIColor grayColor];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.mas_equalTo(self.nameLB.mas_left).mas_equalTo(-3);
        }];
        im;
    });
    
    UIView *lineView = ({
        UIView *v = [[UIView alloc]init];
        [self.contentView addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        v;
    });
}

- (void)bingViewModel:(id)viewModel{
    
}
@end
