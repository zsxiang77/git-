//
//  CustomerInformationYYueCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CustomerInformationYYueCell.h"

@implementation CustomerInformationYYueCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        zuoLabel = [[UILabel alloc]init];
        zuoLabel.font = [UIFont systemFontOfSize:12];
        zuoLabel.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:zuoLabel];
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        youLabel = [[UILabel alloc]init];
        youLabel.font = [UIFont systemFontOfSize:12];
        youLabel.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:youLabel];
        [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        UILabel*lines=[[UILabel alloc]init];
        lines.backgroundColor=kLineBgColor;
        [self.contentView addSubview:lines];
        [lines mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(zuoLabel.mas_bottom).mas_equalTo(7);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
-(void)shuxinCellXiangMu:(OrderDetailSubjectsModel*)model
{
    zuoLabel.text=model.name;
    youLabel.text=model.reality_fee;
}
-(void)shuxinCellPeiJian:(OrderDetailPartsModel*)model{
    zuoLabel.text=model.parts_name;
    youLabel.text=model.parts_fee;
    
}

@end
