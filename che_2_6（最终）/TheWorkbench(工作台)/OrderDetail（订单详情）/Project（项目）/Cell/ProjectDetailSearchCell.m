//
//  ProjectDetailSearchCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ProjectDetailSearchCell.h"

@implementation ProjectDetailSearchCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        titleLable = [[UILabel alloc]init];
        titleLable.font = [UIFont systemFontOfSize:15];
        titleLable.textColor = kRGBColor(51, 51, 51);
        titleLable.numberOfLines = 0;
        [self.contentView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(8);
        }];
        
        gongshiLable = [[UILabel alloc]init];
        gongshiLable.font = [UIFont systemFontOfSize:12];
        gongshiLable.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:gongshiLable];
        [gongshiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-8);
        }];
        
        
        gonsghiFeiLable = [[UILabel alloc]init];
        gonsghiFeiLable.font = [UIFont systemFontOfSize:12];
        gonsghiFeiLable.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:gonsghiFeiLable];
        [gonsghiFeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gongshiLable.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(gongshiLable);
        }];
        
        UILabel * line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
-(void)refelesePeiJianWithModel:(NSDictionary *)model
{
    ProjectModeChangYong * modes =[[ProjectModeChangYong alloc]init];
    [modes setdataWithDict:model];
    titleLable.text = modes.name;
    gongshiLable.text = [NSString stringWithFormat:@"共时:%@",modes.hour];
    gonsghiFeiLable.text = [NSString stringWithFormat:@"共时费:%@",modes.fee];
    
}


@end
