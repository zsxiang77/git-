//
//  PushMessageCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PushMessageCell.h"
#import "CheDianZhangCommon.h"

@implementation PushMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titileImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.titileImageView];
        [self.titileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(60);
            make.left.mas_equalTo(10);
        }];
        self.biaoTiLabel = [[UILabel alloc]init];
        self.biaoTiLabel.font = [UIFont systemFontOfSize:14];
        self.biaoTiLabel.textAlignment = NSTextAlignmentLeft;
        self.biaoTiLabel.numberOfLines = 0;
        [self.contentView addSubview:self.biaoTiLabel];
        [self.biaoTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(80);
        }];
        
        
        self.shuoMingLabel = [[UILabel alloc]init];
        self.shuoMingLabel.font = [UIFont systemFontOfSize:13];
        self.shuoMingLabel.textAlignment = NSTextAlignmentLeft;
        self.shuoMingLabel.numberOfLines = 0;
        self.shuoMingLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.shuoMingLabel];
        [self.shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_centerY).mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(80);
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor =kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end
