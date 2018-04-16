//
//  StoresInformationCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoresInformationCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation StoresInformationCell

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
        self.jianTouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_hall_jiantou")];
        [self.contentView addSubview:self.jianTouImageView];
        [self.jianTouImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
    }
    return self;
}

-(UILabel *)mainLabl
{
    if (!_mainLabl) {
        _mainLabl = [[UILabel alloc]init];
        _mainLabl.textColor = kRGBColor(155, 155, 155);
        _mainLabl.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_mainLabl];
        [_mainLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _mainLabl;
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


-(void)shuaXingCellWithZuo:(NSString *)zuoStr withRight:(NSString *)rightStr shiFouErwei:(BOOL)erwei
{
    self.mainLabl.text = zuoStr;
    
    self.rightLabl.hidden = NO;
    self.rightLabl.text = rightStr;
}

@end
