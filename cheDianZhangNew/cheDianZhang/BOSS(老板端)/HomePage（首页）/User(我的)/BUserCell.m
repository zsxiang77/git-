//
//  BUserCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BUserCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation BUserCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(23);
        }];
    }
    return _mainImageView;
}

-(UILabel *)mainLabl
{
    if (!_mainLabl) {
        _mainLabl = [[UILabel alloc]init];
        _mainLabl.textColor = kRGBColor(74, 74, 74);
        _mainLabl.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_mainLabl];
        [_mainLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainImageView.mas_right).mas_equalTo(16);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _mainLabl;
}

-(UIImageView *)jianTouImageView
{
    if (!_jianTouImageView) {
        _jianTouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_hall_jiantou")];
        [self.contentView addSubview:_jianTouImageView];
        [_jianTouImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
    }
    return _jianTouImageView;
}

-(UILabel *)rightLabl
{
    if (!_rightLabl) {
        _rightLabl = [[UILabel alloc]init];
        _rightLabl.textColor = kRGBColor(155, 155, 155);
        _rightLabl.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_rightLabl];
        [_rightLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.jianTouImageView.mas_left).mas_equalTo(-10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _rightLabl;
}

@end
