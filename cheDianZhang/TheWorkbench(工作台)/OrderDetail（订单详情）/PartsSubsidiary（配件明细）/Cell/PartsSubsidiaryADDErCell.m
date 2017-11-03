//
//  PartsSubsidiaryADDErCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PartsSubsidiaryADDErCell.h"
#import "CheDianZhangCommon.h"

@implementation PartsSubsidiaryADDErCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.xuanZhongImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.xuanZhongImageView];
        [self.xuanZhongImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.width.height.mas_equalTo(15);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.top.mas_equalTo(10);
        }];
        
        self.kuCunLabel = [[UILabel alloc]init];
        self.kuCunLabel.font = [UIFont systemFontOfSize:13];
        self.kuCunLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.kuCunLabel];
        [self.kuCunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
        
        self.bianHaoLabel = [[UILabel alloc]init];
        self.bianHaoLabel.font = [UIFont systemFontOfSize:13];
        self.bianHaoLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.bianHaoLabel];
        [self.bianHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.bottom.mas_equalTo(-10);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(void)refelesePeiJianWithModel:(PeiJianListModel *)model
{
    if (model.shiFouXuanZhong == YES) {
        self.xuanZhongImageView.image = DJImageNamed(@"cell_select");
    }else
    {
        self.xuanZhongImageView.image = DJImageNamed(@"cell_noselect");
    }
    
    self.nameLabel.text = model.cname;
    self.kuCunLabel.text = [NSString stringWithFormat:@"库存：%@",model.parts_total];
    self.bianHaoLabel.text = [NSString stringWithFormat:@"编号：%@",model.commodity_code];
}

@end
