//
//  ConstructionPersonnelCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ConstructionPersonnelCell.h"
#import "CheDianZhangCommon.h"

@implementation ConstructionPersonnelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.youImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.youImageView];
        [self.youImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.width.height.mas_equalTo(20);
        }];
        
        self.shangLabel = [[UILabel alloc]init];
        self.shangLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.shangLabel];
        [self.shangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-10);
        }];
        
        UIImageView *renImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"yonghu")];
        [self.contentView addSubview:renImageView];
        [renImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.shangLabel.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(40);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(30);
        }];
        
        self.xiaLabel = [[UILabel alloc]init];
        self.xiaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.xiaLabel];
        [self.xiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(renImageView);
            make.left.mas_equalTo(renImageView.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-10);
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


-(void)refeleseWithModel:(OrignalModel *)model
{
    self.shangLabel.text = model.subject;
    if (model.operation.length<=0) {
        self.xiaLabel.text = @"未选";
        self.xiaLabel.textColor = [UIColor redColor];
    }else{
        self.xiaLabel.text = model.operation;
        self.xiaLabel.textColor = [UIColor blackColor];
    }
    
    if (model.shiFouXuanZhong == YES) {
        self.youImageView.image = DJImageNamed(@"cell_select");
    }else
    {
        self.youImageView.image = DJImageNamed(@"cell_noselect");
    }
}

@end
