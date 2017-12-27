//
//  OrderMessageCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderMessageCell.h"
#import "CheDianZhangCommon.h"

@implementation OrderMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor =kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        self.zuoLabel = [[UILabel alloc]init];
        self.zuoLabel.font = [UIFont systemFontOfSize:13];
        self.zuoLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.zuoLabel];
        [self.zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
        self.youLabel = [[UILabel alloc]init];
        self.youLabel.font = [UIFont systemFontOfSize:13];
        self.youLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.youLabel];
        [self.youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
        
        UIView *xiaView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kWindowW, 60)];
        [self.contentView addSubview:xiaView];
        
        self.titileImageView = [[UIImageView alloc]init];
        [xiaView addSubview:self.titileImageView];
        [self.titileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(xiaView);
            make.width.height.mas_equalTo(40);
            make.left.mas_equalTo(10);
        }];
        self.biaoTiLabel = [[UILabel alloc]init];
        self.biaoTiLabel.font = [UIFont systemFontOfSize:14];
        self.biaoTiLabel.textAlignment = NSTextAlignmentLeft;
        self.biaoTiLabel.numberOfLines = 0;
        [xiaView addSubview:self.biaoTiLabel];
        [self.biaoTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(xiaView.mas_centerY);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(60);
        }];
        
        
        self.shuoMingLabel = [[UILabel alloc]init];
        self.shuoMingLabel.font = [UIFont systemFontOfSize:13];
        self.shuoMingLabel.textAlignment = NSTextAlignmentLeft;
        self.shuoMingLabel.numberOfLines = 0;
        self.shuoMingLabel.textColor = [UIColor grayColor];
        [xiaView addSubview:self.shuoMingLabel];
        [self.shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(xiaView.mas_centerY).mas_equalTo(3);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(60);
        }];
        
        
        
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

@end
