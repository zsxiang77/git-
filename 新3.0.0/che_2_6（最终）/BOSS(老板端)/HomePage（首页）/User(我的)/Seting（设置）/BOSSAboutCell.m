//
//  BOSSAboutCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSAboutCell.h"

@implementation BOSSAboutCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
            self.zhongView = [[UIView alloc]init];
            [self.contentView addSubview:self.zhongView];
            [self.zhongView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        
    }
    return self;
}

-(void)chuLiData:(NSDictionary *)dict withIndex:(NSInteger)index
{
    //删除cell的所有子视图
    while ([self.zhongView.subviews lastObject] != nil)
    {
        [[self.zhongView.subviews lastObject] removeFromSuperview];
    }
    if (index == 0) {
        UILabel *jieshaoLabel = [[UILabel alloc]init];
        jieshaoLabel.text = @"车店长介绍";
        jieshaoLabel.font = [UIFont boldSystemFontOfSize:17];
        jieshaoLabel.textColor = kRGBColor(74, 74, 74);
        [self.zhongView addSubview:jieshaoLabel];
        [jieshaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.centerX.mas_equalTo(self.zhongView);
        }];
        
        UIImageView *xiaotouBiaoIm = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_logo")];
        [self.zhongView addSubview:xiaotouBiaoIm];
        [xiaotouBiaoIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(jieshaoLabel.mas_left).mas_equalTo(-5);
            make.centerY.mas_equalTo(jieshaoLabel);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(14);
        }];
        
        UILabel *jieShaoLabel = [[UILabel alloc]init];
        jieShaoLabel.font = [UIFont systemFontOfSize:14];
        jieShaoLabel.numberOfLines = 0;
        [self.zhongView addSubview:jieShaoLabel];
        [jieShaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(jieshaoLabel.mas_bottom).mas_equalTo(10);
        }];
        jieShaoLabel.text = [NSString stringWithFormat:@"        %@",KISDictionaryHaveKey(dict, @"introduce")];
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [self.zhongView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
        }];
    }else{
        
        
        UILabel *lainXiLabel = [[UILabel alloc]init];
        lainXiLabel.text = @"联系我们";
        lainXiLabel.font = [UIFont boldSystemFontOfSize:17];
        lainXiLabel.textColor = kRGBColor(74, 74, 74);
        [self.zhongView addSubview:lainXiLabel];
        [lainXiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.centerX.mas_equalTo(self.zhongView);
        }];
        
        
        UILabel *lianXilabel = [[UILabel alloc]init];
        lianXilabel.font = [UIFont systemFontOfSize:14];
        lianXilabel.numberOfLines = 0;
        [self.zhongView addSubview:lianXilabel];
        [lianXilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(lainXiLabel.mas_bottom).mas_equalTo(10);
        }];
        lianXilabel.text = [NSString stringWithFormat:@"        %@",KISDictionaryHaveKey(dict, @"contact")];
    }
}

@end
