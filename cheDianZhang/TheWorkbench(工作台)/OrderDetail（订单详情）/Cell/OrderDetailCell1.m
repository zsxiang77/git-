//
//  OrderDetailCell1.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/21.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderDetailCell1.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.zuoLabel = [[UILabel alloc]init];
        self.zuoLabel.textColor = [UIColor grayColor];
        self.zuoLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.zuoLabel];
        [self.zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.youLabel = [[UILabel alloc]init];
        self.youLabel.textColor = [UIColor grayColor];
        self.youLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.youLabel];
        [self.youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.youImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.youImageView];
        [self.youImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(15);
            make.right.mas_equalTo(self.youLabel.mas_left).mas_equalTo(-5);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end
