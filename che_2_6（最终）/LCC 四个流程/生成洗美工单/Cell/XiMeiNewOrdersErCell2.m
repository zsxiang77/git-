//
//  XiMeiNewOrdersErCell2.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErCell2.h"
#import "CheDianZhangCommon.h"

@implementation XiMeiNewOrdersErCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.zuoShangLabel = [[UILabel alloc]init];
        self.zuoShangLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.zuoShangLabel];
        [self.zuoShangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(12.5);
        }];
        
        self.zuoXiaLabel = [[UILabel alloc]init];
        self.zuoXiaLabel.font = [UIFont systemFontOfSize:10];
        self.zuoXiaLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.zuoXiaLabel];
        [self.zuoXiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-12.5);
        }];
        
        self.youLabel = [[UILabel alloc]init];
        self.youLabel.font = [UIFont systemFontOfSize:10];
        self.youLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.youLabel];
        [self.youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-12.5);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

@end
