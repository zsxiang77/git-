//
//  JobBoardDeltailJiBenCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/19.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardDeltailJiBenCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation JobBoardDeltailJiBenCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
        }];
        
        
        zuoLabel = [[UILabel alloc]init];
        zuoLabel.font = [UIFont systemFontOfSize:17];
        zuoLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:zuoLabel];
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        
        youLabel = [[UILabel alloc]init];
        youLabel.font = [UIFont systemFontOfSize:17];
        youLabel.textColor = kRGBColor(74, 74, 74);
        youLabel.hidden = YES;
        [self.contentView addSubview:youLabel];
        [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-7);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        chePaiLabel = [[UILabel alloc]init];
        chePaiLabel.font = [UIFont systemFontOfSize:17];
        chePaiLabel.textColor = kRGBColor(74, 144, 226);
        chePaiLabel.hidden = YES;
        [self.contentView addSubview:chePaiLabel];
        [chePaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-14);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        chePaiView = [[UIView alloc]init];
        [chePaiView.layer setMasksToBounds:YES];
        chePaiView.backgroundColor = kColorWithRGB(0, 122, 255, 0.2);
        [chePaiView.layer setCornerRadius:3];
        chePaiView.hidden = YES;
        [self.contentView addSubview:chePaiView];
        [chePaiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chePaiLabel.mas_left).mas_equalTo(-5);
            make.right.mas_equalTo(chePaiLabel.mas_right).mas_equalTo(5);
            make.bottom.mas_equalTo(chePaiLabel.mas_bottom).mas_equalTo(3);
            make.top.mas_equalTo(chePaiLabel.mas_top).mas_equalTo(-3);
        }];
        [self.contentView bringSubviewToFront:chePaiLabel];
        
        jiantouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
        [self.contentView addSubview:jiantouImageView];
        [jiantouImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(25);
        }];
        
        haoLabel = [[UILabel alloc]init];
        haoLabel.font = [UIFont systemFontOfSize:15];
        haoLabel.textColor = kRGBColor(0, 122, 255);
        haoLabel.hidden = YES;
        [self.contentView addSubview:haoLabel];
        [haoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(jiantouImageView.mas_left);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)refreshIndex:(NSInteger )index withYouStr:(NSString *)str
{
    youLabel.hidden = YES;
    chePaiLabel.hidden = YES;
    chePaiView.hidden = YES;
    jiantouImageView.hidden = YES;
    haoLabel.hidden = YES;
    if (index == 0) {
        zuoLabel.text = @"车型";
        youLabel.hidden = NO;
        youLabel.text = str;
    }else if (index == 1) {
        zuoLabel.text = @"车牌";
        chePaiLabel.hidden = NO;
        chePaiView.hidden = NO;
        chePaiLabel.text = str;
    }else if (index == 2) {
        zuoLabel.text = @"工单号";
        jiantouImageView.hidden = NO;
        haoLabel.hidden = NO;
        haoLabel.text = str;
    }else if (index == 3) {
        zuoLabel.text = @"工单类型";
        youLabel.hidden = NO;
        youLabel.text = str;
    }else{
        zuoLabel.text = @"工单完成时间";
        youLabel.hidden = NO;
        youLabel.text = str;
    }
}

@end
