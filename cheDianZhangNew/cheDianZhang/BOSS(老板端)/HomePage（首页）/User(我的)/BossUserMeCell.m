//
//  BossUserMeCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/10.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossUserMeCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation BossUserMeCell

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
        
        self.mainLabl = [[UILabel alloc]init];
        self.mainLabl.font = [UIFont systemFontOfSize:17];
        self.mainLabl.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:_mainLabl];
        [_mainLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return self;
}

-(UIImageView *)touXiangImageView
{
    if (!_touXiangImageView) {
        _touXiangImageView = [[UIImageView alloc]init];
        [_touXiangImageView.layer setMasksToBounds:YES];
        [_touXiangImageView.layer setCornerRadius:75/2];
        [self.contentView addSubview:_touXiangImageView];
        [_touXiangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-28);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(75);
        }];
    }
    return _touXiangImageView;
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
        _rightLabl.textColor = kRGBColor(74, 74, 74);
        _rightLabl.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_rightLabl];
        [_rightLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _rightLabl;
}

-(UIView *)rightLablView
{
    if (!_rightLablView) {
        _rightLablView = [[UIView alloc]init];
        _rightLablView.backgroundColor = kRGBColor(74, 144, 226);
        [_rightLablView.layer setMasksToBounds:YES];
        [_rightLablView.layer setCornerRadius:3];
        [self.contentView addSubview:_rightLablView];
        [_rightLablView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.rightLabl.mas_left).mas_equalTo(-10);
            make.top.mas_equalTo(self.rightLabl.mas_top).mas_equalTo(-5);
            make.right.mas_equalTo(self.rightLabl.mas_right).mas_equalTo(10);
            make.bottom.mas_equalTo(self.rightLabl.mas_bottom).mas_equalTo(5);
        }];
        [self.contentView bringSubviewToFront:_rightLabl];
    }
    return _rightLablView;
}

-(void)shanXinData:(NSString *)rightStr withZhanShi:(BOOL)zhanShui xianShiDI:(BOOL)xianshi
{
    self.rightLabl.textColor  = kRGBColor(74, 74, 74);
    if (zhanShui) {
        self.rightLablView.hidden = YES;
        self.jianTouImageView.hidden = NO;
        [self.rightLabl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
        }];
        self.rightLabl.text = rightStr;
    }else{
        self.jianTouImageView.hidden = YES;
        if (xianshi == YES) {
            self.rightLablView.hidden = NO;
            self.rightLabl.textColor  = [UIColor whiteColor];
            [self.rightLabl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20);
            }];
        }else
        {
            [self.rightLabl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
            }];
        }
        
        self.rightLabl.text = rightStr;
    }
}

@end
