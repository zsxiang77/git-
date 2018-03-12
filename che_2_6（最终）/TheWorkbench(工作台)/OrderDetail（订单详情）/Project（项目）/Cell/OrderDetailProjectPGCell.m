//
//  OrderDetailProjectPGCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailProjectPGCell.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailProjectPGCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = kRGBColor(239, 239, 239);
        [backView.layer setMasksToBounds:YES];
        [backView.layer setBorderColor:kRGBColor(155, 155, 155).CGColor];
        [backView.layer setBorderWidth:1];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
        
        xuanZhongImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_checked_right")];
        [self.contentView addSubview:xuanZhongImageView];
        [xuanZhongImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
        
        touXiangImageView = [[UIImageView alloc]init];
        [touXiangImageView.layer setMasksToBounds:YES];
        [touXiangImageView.layer setCornerRadius:37/2];
        [self.contentView addSubview:touXiangImageView];
        [touXiangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xuanZhongImageView.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(37);
        }];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = kRGBColor(74, 74, 74);
        nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(touXiangImageView.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)refeleseWithModel:(PaiGongStaffModel *)model
{
    if (model.shiFouXuanZhong == YES) {
        xuanZhongImageView.hidden = NO;
    }else{
        xuanZhongImageView.hidden = YES;
    }
    
    [touXiangImageView sd_setImageWithURL:[NSURL URLWithString:model.staff_img]];
    nameLabel.text = model.real_name;
}

@end
