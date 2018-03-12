//
//  NewMaterialCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "NewMaterialCell.h"
#import "CheDianZhangCommon.h"

@implementation NewMaterialCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.zhuImageView = [[UIImageView alloc]init];
        self.zhuImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.zhuImageView];
        [self.zhuImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(50);
        }];
        
        self.xuanZhonImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.xuanZhonImageView];
        [self.xuanZhonImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.width.height.mas_equalTo(20);
        }];
        
        self.titleLabel  = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        self.shuXinLabel  = [[UILabel alloc]init];
        self.shuXinLabel.font = [UIFont systemFontOfSize:13];
        self.shuXinLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.shuXinLabel];
        [self.shuXinLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.top.mas_equalTo(self.xuanZhonImageView.mas_bottom).mas_equalTo(10);
        }];
        
        self.kuCunLabel  = [[UILabel alloc]init];
        self.kuCunLabel.font = [UIFont systemFontOfSize:13];
        self.kuCunLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.kuCunLabel];
        [self.kuCunLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shuXinLabel.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(self.xuanZhonImageView.mas_bottom).mas_equalTo(10);
        }];
        
        self.danJiaLabel  = [[UILabel alloc]init];
        self.danJiaLabel.font = [UIFont systemFontOfSize:13];
        self.danJiaLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:self.danJiaLabel];
        [self.danJiaLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.kuCunLabel.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(self.xuanZhonImageView.mas_bottom).mas_equalTo(10);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end
