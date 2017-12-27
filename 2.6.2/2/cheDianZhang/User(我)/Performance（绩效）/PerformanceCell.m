//
//  PerformanceCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/9.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PerformanceCell.h"
#import "CheDianZhangCommon.h"

@implementation PerformanceCell

-(UILabel *)zuoLabel
{
    if (!_zuoLabel) {
        _zuoLabel = [[UILabel alloc]init];
        _zuoLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_zuoLabel];
        [_zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _zuoLabel;
}

-(UILabel *)youLabel
{
    if (!_youLabel) {
        _youLabel = [[UILabel alloc]init];
        _youLabel.font = [UIFont systemFontOfSize:14];
        _youLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_youLabel];
        [_youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _youLabel;
}


@end
