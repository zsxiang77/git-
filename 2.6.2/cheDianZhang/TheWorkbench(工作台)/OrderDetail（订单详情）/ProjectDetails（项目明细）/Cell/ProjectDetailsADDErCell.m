//
//  ProjectDetailsADDErCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDErCell.h"
#import "CheDianZhangCommon.h"

@implementation ProjectDetailsADDErCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.zuoImageView  = [[UIImageView alloc]init];
        [self.contentView addSubview:self.zuoImageView];
        [self.zuoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.mainLabel = [[UILabel alloc]init];
        self.mainLabel.numberOfLines = 0;
        self.mainLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.mainLabel];
        [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.zuoImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(-10);
        }];
        
        self.sanJiBt = [[UIButton alloc]init];
        [self.contentView addSubview:self.sanJiBt];
        [self.sanJiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW/2);
        }];
        self.sanJiBt.hidden = YES;
        [self.sanJiBt addTarget:self action:@selector(sanJiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

-(void)sanJiBtChick:(UIButton *)sender
{
    self.tiaoZhanSanJiBlock(self.model);
}


@end
