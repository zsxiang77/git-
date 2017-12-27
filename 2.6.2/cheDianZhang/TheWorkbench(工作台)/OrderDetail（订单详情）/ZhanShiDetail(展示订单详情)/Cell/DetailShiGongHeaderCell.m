//
//  DetailShiGongHeaderCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "DetailShiGongHeaderCell.h"
#import "CheDianZhangCommon.h"

@implementation DetailShiGongHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kRGBColor(227, 227, 227);
        _zuoLabel = [[UILabel alloc]init];
        _zuoLabel.font = [UIFont systemFontOfSize:13];
        _zuoLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:_zuoLabel];
        [_zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        _youLabel = [[UILabel alloc]init];
        _youLabel.font = [UIFont systemFontOfSize:13];
        _youLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:_youLabel];
        [_youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
@end
