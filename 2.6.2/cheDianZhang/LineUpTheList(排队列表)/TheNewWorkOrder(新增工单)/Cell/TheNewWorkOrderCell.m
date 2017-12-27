//
//  TheNewWorkOrderCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheNewWorkOrderCell.h"
#import "CheDianZhangCommon.h"

@implementation TheNewWorkOrderCell

-(UILabel *)mainLabel
{
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc]init];
        _mainLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_mainLabel];
        _mainLabel.font = [UIFont systemFontOfSize:14];
        [_mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(80);
        }];
    }
    return _mainLabel;
}

-(UITextField *)mainTextField
{
    if (!_mainTextField) {
        _mainTextField = [[UITextField alloc]init];
        _mainTextField.textColor = kZhuTiColor;
        _mainTextField.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:_mainTextField];
        _mainTextField.font = [UIFont systemFontOfSize:14];
        [_mainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainLabel.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(kWindowW-100);
        }];
    }
    return _mainTextField;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return _line;
}
-(UIImageView *)tiaozhuanImageView
{
    if (!_tiaozhuanImageView) {
        _tiaozhuanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
        [self.contentView addSubview:_tiaozhuanImageView];
        [_tiaozhuanImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(25);
        }];
        
    }
    return _tiaozhuanImageView;
}


@end
