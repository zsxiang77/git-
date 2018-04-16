//
//  JobBoardCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation JobBoardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        zuoImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:zuoImageView];
        [zuoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(17);
            make.width.height.mas_equalTo(22);
        }];
        titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = kRGBColor(74, 74, 74);
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(13);
            make.centerY.mas_equalTo(zuoImageView);
        }];
        
        jingJiImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_ic_urgency")];
        [self.contentView addSubview:jingJiImageView];
        [jingJiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(titleLabel);
            make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(6);
        }];
        
        zhongYaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_ic_important")];
        [self.contentView addSubview:zhongYaoImageView];
        [zhongYaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(titleLabel);
            make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(38);
        }];
        
        rightLabel = [[UILabel alloc]init];
        rightLabel.textColor = kRGBColor(155, 155, 155);
        rightLabel.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
        
        rightXiaLabel = [[UILabel alloc]init];
        rightXiaLabel.textColor = kRGBColor(74, 74, 74);
        rightXiaLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:rightXiaLabel];
        [rightXiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
        
        chePaiLabel = [[UILabel alloc]init];
        chePaiLabel.textColor = kRGBColor(74, 144, 226);
        chePaiLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:chePaiLabel];
        [chePaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(48);
            make.bottom.mas_equalTo(-8);
        }];
        
        UIView *chediBackView = [[UIView alloc]init];
        chediBackView.backgroundColor = kColorWithRGB(0, 122, 255, 0.2);
        [chediBackView.layer setMasksToBounds:YES];
        [chediBackView.layer setCornerRadius:3];
        [self.contentView addSubview:chediBackView];
        [chediBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(chePaiLabel.mas_top).mas_equalTo(-2);
            make.bottom.mas_equalTo(chePaiLabel.mas_bottom).mas_equalTo(2);
            make.left.mas_equalTo(chePaiLabel.mas_left).mas_equalTo(-3);
            make.right.mas_equalTo(chePaiLabel.mas_right).mas_equalTo(3);
        }];
        [self.contentView bringSubviewToFront:chePaiLabel];
        
        cheLeiXinLabel = [[UILabel alloc]init];
        cheLeiXinLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:cheLeiXinLabel];
        [cheLeiXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(chePaiLabel);
            make.left.mas_equalTo(chePaiLabel.mas_right).mas_equalTo(7);
        }];
        
//        nameImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_jopHeader_renYuan")];
//        [self.contentView addSubview:nameImageView];
//        [nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(48);
//            make.bottom.mas_equalTo(-8);
//            make.width.height.mas_equalTo(13);
//        }];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cheLeiXinLabel);
            make.left.mas_equalTo(cheLeiXinLabel.mas_right).mas_equalTo(7);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(10);
        }];
    }
    return self;
}

-(void)refleshData:(JobBoardModel *)dict
{
    NSInteger task_type = [dict.task_type integerValue];
    if (task_type == 0) {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_LIuShi");
    }else if (task_type == 1)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_YiChang");
    }else if (task_type == 2)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_ChaPing");
    }else if (task_type == 3)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_YuYue");
    }else if (task_type == 4)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_baoYang");
    }else if (task_type == 5)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_baoXian");
    }else if (task_type == 6)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_NianJian");
    }else if (task_type == 7)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_shengRi");
    }else if (task_type == 8)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_xunJia");
    }else if (task_type == 9)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_gongDan");
    }else if (task_type == 10)
    {
        zuoImageView.image = DJImageNamed(@"Boss_jopHeader_QuanBu");
    }else{
        zuoImageView.image = DJImageNamed(@"");
    }
    
    titleLabel.text = dict.name;
    [zhongYaoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(38);
    }];
    if ([dict.is_urgent boolValue] == YES &&[dict.is_heavy boolValue] == YES ) {
        jingJiImageView.hidden = NO;
        zhongYaoImageView.hidden = NO;
        
    }else if ([dict.is_urgent boolValue] == YES &&[dict.is_heavy boolValue] == NO ) {
        jingJiImageView.hidden = NO;
        zhongYaoImageView.hidden = YES;
    }else if ([dict.is_urgent boolValue] == NO &&[dict.is_heavy boolValue] == YES ) {
        jingJiImageView.hidden = YES;
        zhongYaoImageView.hidden = NO;
        [zhongYaoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(titleLabel.mas_right).mas_equalTo(6);
        }];
    }else{
        jingJiImageView.hidden = YES;
        zhongYaoImageView.hidden = YES;
    }
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"还剩 %@ %@",dict.remain,dict.unit]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, dict.remain.length)];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(3, dict.remain.length)];
    rightLabel.attributedText = att;
    rightXiaLabel.text = dict.person_name;
    chePaiLabel.text = dict.car_number;
    cheLeiXinLabel.text = dict.car_info;
//    chePaiLabel.hidden = YES;
//    cheLeiXinLabel.hidden = YES;
//    nameImageView.hidden = YES;
    nameLabel.hidden = YES;
    if (task_type == 7 || task_type == 0){
        nameLabel.hidden = NO;
        nameLabel.text = dict.username;
    }
    
    if ([dict.remain integerValue] == 0) {
        rightLabel.hidden = YES;
    }else{
        rightLabel.hidden = NO;
    }
    
    if ([dict.status integerValue] == 1 ||[dict.status integerValue] == 2) {
        rightLabel.hidden = YES;
    }
}

@end
