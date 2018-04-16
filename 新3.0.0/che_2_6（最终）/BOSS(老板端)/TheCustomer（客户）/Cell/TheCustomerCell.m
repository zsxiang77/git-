//
//  TheCustomerCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TheCustomerCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation TheCustomerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:16];
        nameLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        zhiWeiLabel = [[UILabel alloc]init];
        zhiWeiLabel.font = [UIFont systemFontOfSize:12];
        zhiWeiLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:zhiWeiLabel];
        [zhiWeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        zhiWeibackView = [[UIView alloc]init];
        [zhiWeibackView.layer setMasksToBounds:YES];
        [zhiWeibackView.layer setCornerRadius:9];
        [self.contentView addSubview:zhiWeibackView];
        [zhiWeibackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(zhiWeiLabel);
            make.left.mas_equalTo(zhiWeiLabel.mas_left).mas_equalTo(-5);
            make.right.mas_equalTo(zhiWeiLabel.mas_right).mas_equalTo(5);
            make.height.mas_equalTo(18);
        }];
        [self.contentView bringSubviewToFront:zhiWeiLabel];
        
        
        modileLabel = [[UILabel alloc]init];
        modileLabel.font = [UIFont systemFontOfSize:16];
        modileLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:modileLabel];
        [modileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

-(void)refleshData:(TheCustomerModel *)model
{
    if (model.store_alias.length>8) {
        nameLabel.text = [model.store_alias substringToIndex:8];
    }else{
        nameLabel.text = model.store_alias;
    }
    
    zhiWeiLabel.hidden = YES;
    zhiWeibackView.hidden = YES;
    if ([model.is_unit integerValue] == 1) {
        zhiWeiLabel.hidden = NO;
        zhiWeibackView.hidden = NO;
        zhiWeiLabel.text = @"企业";
        zhiWeibackView.backgroundColor = kRGBColor(98, 172, 13);
        [nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(59);
        }];
        
    }else{
        [nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
        }];
    }
    modileLabel.text = model.mobile;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:_line];
        [_line  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
        }];
    }
    return _line;
}

@end
