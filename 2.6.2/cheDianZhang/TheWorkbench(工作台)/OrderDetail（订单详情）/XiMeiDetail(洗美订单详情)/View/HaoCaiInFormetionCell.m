//
//  HaoCaiInFormetionCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "HaoCaiInFormetionCell.h"
#import "CheDianZhangCommon.h"

@implementation HaoCaiInFormetionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.mainImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
            make.width.height.mas_equalTo(60);
        }];
        
        self.mainLabel = [[UILabel alloc]init];
        self.mainLabel.font = [UIFont systemFontOfSize:14];
        self.mainLabel.numberOfLines = 0;
        [self.contentView addSubview:self.mainLabel];
        [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainImageView.mas_right).mas_equalTo(5);
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-10);
        }];
        
        
        self.duoShanJianLabel = [[UILabel alloc]init];
        self.duoShanJianLabel.textColor = [UIColor grayColor];
        self.duoShanJianLabel.font = [UIFont systemFontOfSize:13];
        self.duoShanJianLabel.numberOfLines = 0;
        [self.contentView addSubview:self.duoShanJianLabel];
        [self.duoShanJianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-5);
        }];
        
        self.shuXinLabel = [[UILabel alloc]init];
        self.shuXinLabel.font = [UIFont systemFontOfSize:13];
        self.shuXinLabel.numberOfLines = 0;
        self.shuXinLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.shuXinLabel];
        [self.shuXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainImageView.mas_right).mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
        }];
        
        UILabel *shuLabel = [[UILabel alloc]init];
        shuLabel.font = [UIFont systemFontOfSize:13];
        shuLabel.textColor = [UIColor grayColor];
        shuLabel.text = @"属性";
        shuLabel.numberOfLines = 0;
        [self.contentView addSubview:shuLabel];
        [shuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainImageView.mas_right).mas_equalTo(5);
            make.bottom.mas_equalTo(self.shuXinLabel.mas_top).mas_equalTo(-5);
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end
