//
//  UserMainCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/5.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "UserMainCell.h"
#import "CheDianZhangCommon.h"

@implementation UserMainCell

-(UIView *)mianView
{
    if (!_mianView) {
        self.backgroundColor = kRGBColor(200, 200, 200);
        _mianView = [[UIView alloc]init];
        _mianView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mianView];
        [_mianView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _mianView;
}

-(UIImageView *)tiaozhuanImageView
{
    if (!_tiaozhuanImageView) {
        _tiaozhuanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
        [self.mianView addSubview:_tiaozhuanImageView];
        [_tiaozhuanImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.mianView);
            make.width.height.mas_equalTo(25);
        }];
        
    }
    return _tiaozhuanImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = kZhuTiColor;
        [self.mianView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(10);
             make.centerY.mas_equalTo(self.mianView);
        }];
    }
    return _titleLabel;
}

@end
