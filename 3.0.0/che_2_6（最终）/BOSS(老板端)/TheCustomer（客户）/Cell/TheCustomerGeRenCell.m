//
//  TheCustomerGeRenCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/19.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TheCustomerGeRenCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation TheCustomerGeRenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
        }];
        
        
        jiantouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_hall_jiantou")];
        [self.contentView addSubview:jiantouImageView];
        [jiantouImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
        
        
        _shangZuoLabel = [[UILabel alloc]init];
        _shangZuoLabel.font = [UIFont systemFontOfSize:17];
        _shangZuoLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:_shangZuoLabel];
        [_shangZuoLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        _xiaZuoLabel = [[UILabel alloc]init];
        _xiaZuoLabel.font = [UIFont systemFontOfSize:17];
        _xiaZuoLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:_xiaZuoLabel];
        [_xiaZuoLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(10);
        }];
    }
    return self;
}



@end
