//
//  FoundCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation FoundCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        m_titileLabel = [[UILabel alloc]init];
        m_titileLabel.font = [UIFont systemFontOfSize:17];
        m_titileLabel.textColor = kRGBColor(102, 102, 102);
        m_titileLabel.numberOfLines = 0;
        [self.contentView addSubview:m_titileLabel];
        [m_titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(48);
        }];
        
        m_mianImageView = [[UIImageView alloc]init];
        m_mianImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:m_mianImageView];
        [m_mianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(m_titileLabel.mas_bottom).mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(136);
        }];
        
        UIImageView *im1 = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_Found_pinglun")];
        [self.contentView addSubview:im1];
        [im1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(212);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(17.3);
        }];
        
        m_pingLunLabel = [[UILabel alloc]init];
        m_pingLunLabel.font = [UIFont systemFontOfSize:16];
        m_pingLunLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:m_pingLunLabel];
        [m_pingLunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(im1.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(im1);
        }];
        
        UIImageView *im2 = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_Found_dianZan")];
        [self.contentView addSubview:im2];
        [im2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_pingLunLabel.mas_right).mas_equalTo(40);
            make.top.mas_equalTo(212);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(18);
        }];
        
        m_zanLabel = [[UILabel alloc]init];
        m_zanLabel.font = [UIFont systemFontOfSize:16];
        m_zanLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:m_zanLabel];
        [m_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(im2.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(im2);
        }];
        
        m_dateLabel = [[UILabel alloc]init];
        m_dateLabel.font = [UIFont systemFontOfSize:16];
        m_dateLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:m_dateLabel];
        [m_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(im2);
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

-(void)refleshData:(FoundModel *)dict
{
    m_titileLabel.text = dict.title;
    [m_mianImageView  sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_fond_beijing")];
    m_pingLunLabel.text = dict.commentnum;
    m_zanLabel.text = dict.praisenum;
    m_dateLabel.text = dict.time;
}

@end
