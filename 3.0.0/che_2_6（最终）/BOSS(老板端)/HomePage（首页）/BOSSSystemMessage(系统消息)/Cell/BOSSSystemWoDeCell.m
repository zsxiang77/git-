//
//  BOSSSystemWoDeCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSSystemWoDeCell.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"

@implementation BOSSSystemWoDeCell
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
        
        
        neiRongLabel = [[UILabel alloc]init];
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
        
        gengXinDateLabel = [[UILabel alloc]init];
        gengXinDateLabel.textColor = kRGBColor(126, 126, 126);
        gengXinDateLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:gengXinDateLabel];
        [gengXinDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-6);
            make.centerY.mas_equalTo(touImageView);
        }];
    }
    return self;
}


-(void)refleshData:(NSDictionary *)dict
{
    [touImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"avatar")]] placeholderImage:DJImageNamed(@"touxiang")];
    nameLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"to_user_name")];
    neiRongLabel.text = [NSString stringWithFormat:@"回复我：%@",KISDictionaryHaveKey(dict, @"reply_cont")];
    huiFuView.hidden = YES;
    huiFuLabel.hidden = YES;
    NSString *my_contentStr = [NSString stringWithFormat:@"我的评论：%@",KISDictionaryHaveKey(dict, @"my_content")];
    if (my_contentStr.length>0) {
        huiFuLabel.text = my_contentStr;
        huiFuView.hidden = NO;
        huiFuLabel.hidden = NO;
    }
}

@end
