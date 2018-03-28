//
//  BossTableViewCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossTableViewCell.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"
@implementation BossTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        youImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:youImageView];
        [youImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.width.mas_equalTo(294/2);
            make.height.mas_equalTo(198/2);
        }];
        titleDate=[[UILabel alloc]init];
        titleDate.font = [UIFont systemFontOfSize:14];
        titleDate.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        [self.contentView addSubview:titleDate];
        [titleDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(youImageView.mas_right).mas_equalTo(9);
            make.top.mas_equalTo(8);
        }];
        titleLabel=[[UILabel alloc]init];
        titleLabel.numberOfLines=0;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1/1.0];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(youImageView.mas_right).mas_equalTo(9);
            make.right.mas_equalTo(-14);
            make.top.mas_equalTo(33);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    };
    return self;
}
-(void)refleshData:(BossShouCangModel *)dict
{
    titleDate.text=dict.time;
    titleLabel.text=dict.title;
    [youImageView sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_hall_jiantou")];
}



@end
