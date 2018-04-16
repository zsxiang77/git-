//
//  AITBaoGaoListCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "AITBaoGaoListCell.h"
#import "CheDianZhangCommon.h"

@implementation AITBaoGaoListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = kRGBColor(74, 74, 74);
        titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.textColor = kRGBColor(133, 133, 133);
        dateLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-45);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            
        }];

    }
    return self;
}

-(void)refeleseWithModel:(NSDictionary *)model withStr:(NSString *)str
{
    titleLabel.text = str;
    dateLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"time")];
}

@end
