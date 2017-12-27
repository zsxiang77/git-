//
//  ModelCarJiBenCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ModelCarJiBenCell.h"

@implementation ModelCarJiBenCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(UIImageView *)zuoZhuImageView
{
    if (!_zuoZhuImageView) {
        _zuoZhuImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_zuoZhuImageView];
        [_zuoZhuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _zuoZhuImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.zuoZhuImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLabel;
}

@end
