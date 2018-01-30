//
//  DetailZhiJianCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "DetailZhiJianCell.h"
#import "CheDianZhangCommon.h"

@implementation DetailZhiJianCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kRGBColor(245, 245, 245);
        zuoLabel = [[UILabel alloc]init];
        zuoLabel.font = [UIFont systemFontOfSize:13];
        zuoLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:zuoLabel];
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        youLabel = [[UILabel alloc]init];
        youLabel.font = [UIFont systemFontOfSize:13];
        youLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:youLabel];
        [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(void)refleshData:(NSDictionary *)dict whitRow:(NSInteger)row
{
    if (row == 0) {
        line.hidden = NO;
        zuoLabel.text = @"质保期";
        youLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"plan_date")];
    }else if (row == 1) {
        line.hidden = NO;
        zuoLabel.text = @"质保里程";
        youLabel.text = [NSString stringWithFormat:@"%@KM",KISDictionaryHaveKey(dict, @"plan_km")];
    }else{
        line.hidden = YES;
        zuoLabel.text = @"质检人";
        NSDictionary *inspector = KISDictionaryHaveKey(dict, @"inspector");
        youLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(inspector, @"staff_name")];
    }
}

@end
