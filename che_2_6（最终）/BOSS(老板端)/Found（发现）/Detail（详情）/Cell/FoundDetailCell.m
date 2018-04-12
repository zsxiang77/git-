//
//  FoundDetailCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundDetailCell.h"

@implementation FoundDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        touImageView = [[UIImageView alloc]init];
        [touImageView.layer setMasksToBounds:YES];
        [touImageView.layer setCornerRadius:20];
        [self.contentView addSubview:touImageView];
        [touImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(18);
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(40);
        }];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = kZhuTiColor;
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(18);
            make.left.mas_equalTo(60);
        }];
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(41);
            make.left.mas_equalTo(60);
        }];
        
        zanImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:zanImageView];
        [zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(18);
            make.right.mas_equalTo(-10);
            make.width.height.mas_equalTo(18);
        }];
        
        zanLabel = [[UILabel alloc]init];
        zanLabel.font = [UIFont systemFontOfSize:15];
        zanLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:zanLabel];
        [zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(zanImageView);
            make.right.mas_equalTo(zanImageView.mas_left).mas_equalTo(-2);
        }];
        
        UIButton *zanBt = [[UIButton alloc]init];
        [zanBt addTarget:self action:@selector(zanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:zanBt];
        [zanBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-5);
            make.width.height.mas_equalTo(30);
        }];
        
        neiRongLabel = [[UILabel alloc]init];
        neiRongLabel.numberOfLines = 0;
        neiRongLabel.font = [UIFont systemFontOfSize:14];
        neiRongLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:neiRongLabel];
        [neiRongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(78);
        }];
        
        huiFuLabel = [[UILabel alloc]init];
        huiFuLabel.font = [UIFont systemFontOfSize:14];
        huiFuLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:huiFuLabel];
        [huiFuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(76);
            make.right.mas_equalTo(-19);
            make.top.mas_equalTo(neiRongLabel.mas_bottom).mas_equalTo(11);
        }];
        
        huiFuView = [[UIView alloc]init];
        huiFuView.backgroundColor = kRGBColor(247, 247, 247);
        [huiFuView.layer setMasksToBounds:YES];
        [huiFuView.layer setBorderWidth:0.5];
        [huiFuView.layer setBorderColor:kRGBColor(229, 229, 229).CGColor];
        [self.contentView addSubview:huiFuView];
        [huiFuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(huiFuLabel.mas_top).mas_equalTo(-7);
            make.bottom.mas_equalTo(huiFuLabel.mas_bottom).mas_equalTo(7);
            make.left.mas_equalTo(huiFuLabel.mas_left).mas_equalTo(-10);
            make.right.mas_equalTo(huiFuLabel.mas_right).mas_equalTo(10);
        }];
        
        [self.contentView bringSubviewToFront:huiFuLabel];
        
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(61);
            make.height.mas_equalTo(1);
            make.bottom.right.mas_equalTo(0);
        }];
        
    }
    return self;
}

-(void)zanBtChick:(UIButton *)sender
{
    self.zanBtChickBlock(self.zhuModel);
}

- (NSString *)timeBeforeInfoWithString:(NSString *)dangQianStr withguoLeDate:(NSString *)guoLeDate{
    NSInteger timeInt = [dangQianStr integerValue] - [guoLeDate integerValue]; //时间差
    
    NSInteger year = timeInt / (3600 * 24 * 30 *12);
    NSInteger month = timeInt / (3600 * 24 * 30);
    NSInteger day = timeInt / (3600 * 24);
    NSInteger hour = timeInt / 3600;
    NSInteger minute = timeInt / 60;
//    NSInteger seconstr = timeInt;
    if (year > 0) {
        return [NSString stringWithFormat:@"%ld年以前",(long)year];
    }else if(month > 0){
        return [NSString stringWithFormat:@"%ld个月以前",(long)month];
    }else if(day > 0){
        return [NSString stringWithFormat:@"%ld天以前",(long)day];
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%ld小时以前",(long)hour];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%ld分钟以前",(long)minute];
    }else{
        return [NSString stringWithFormat:@"刚刚"];
    }
}


-(void)refleshData:(FoundDetailListModel *)dict
{
    self.zhuModel = dict;
    [touImageView sd_setImageWithURL:[NSURL URLWithString:dict.avatar] placeholderImage:DJImageNamed(@"touxiang")];
    nameLabel.text = dict.username;
    dateLabel.text = [self timeBeforeInfoWithString:dict.now_time withguoLeDate:dict.createdate];
    
    if ([dict.is_praise boolValue] == YES) {
        zanImageView.image = DJImageNamed(@"boss_Found_dianZan_select");
        zanLabel.textColor = kRGBColor(208, 2, 17);
    }else{
        zanImageView.image = DJImageNamed(@"boss_Found_dianZan");
        zanLabel.textColor = kRGBColor(155, 155, 155);
    }
    zanLabel.text = dict.praise;
    neiRongLabel.text = dict.content;
    huiFuView.hidden = YES;
    huiFuLabel.hidden = YES;
    if (dict.original.length>0) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"@%@:%@",dict.to_username,dict.original]];
        [att addAttribute:NSForegroundColorAttributeName value:kZhuTiColor range:NSMakeRange(0, dict.to_username.length+1)];
        huiFuLabel.attributedText = att;
        huiFuView.hidden = NO;
        huiFuLabel.hidden = NO;

    }
}
@end
