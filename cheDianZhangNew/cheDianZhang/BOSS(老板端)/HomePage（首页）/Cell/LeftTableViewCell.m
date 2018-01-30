//
//  LeftTableViewCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation LeftTableViewCell

-(UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(20);
        }];
    }
    return _mainImageView;
}

-(UILabel *)mainLabl
{
    if (!_mainLabl) {
        _mainLabl = [[UILabel alloc]init];
        _mainLabl.textColor = [UIColor whiteColor];
        _mainLabl.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_mainLabl];
        [_mainLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainImageView.mas_right).mas_equalTo(16);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _mainLabl;
}


@end
