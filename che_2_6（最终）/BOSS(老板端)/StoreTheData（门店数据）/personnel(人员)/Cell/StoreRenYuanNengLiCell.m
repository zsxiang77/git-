//
//  StoreRenYuanNengLiCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenYuanNengLiCell.h"

@implementation StoreRenYuanNengLiCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        zuoLable = [[UILabel alloc]init];
        zuoLable.font = [UIFont boldSystemFontOfSize:16];
        [zuoLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:zuoLable];
        [zuoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        youLable = [[UILabel alloc]init];
        youLable.font = [UIFont boldSystemFontOfSize:16];
        [youLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:youLable];
        [youLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
-(void)refleshData:(achievementModel *)dict dieIndex:(NSIndexPath*)index
{
    switch (index.row) {
        case 0:
            zuoLable.text = @"业绩构成";
            youLable.text = [NSString stringWithFormat:@"%@",@"单位(元)"];
            break;
        case 1:
            zuoLable.text = @"维修";
            youLable.text = [NSString stringWithFormat:@"%@",dict.repair];
            break;
        case 2:
           zuoLable.text = @"保险出单";
            youLable.text = [NSString stringWithFormat:@"%@",dict.insurance];
            break;
        case 3:
            zuoLable.text = @"保养";
            youLable.text = [NSString stringWithFormat:@"%@",dict.maintain];
            break;
        case 4:
            zuoLable.text = @"美容";
            youLable.text = [NSString stringWithFormat:@"%@",dict.cosmetology];
            break;
        case 5:
            zuoLable.text = @"洗车";
            youLable.text = [NSString stringWithFormat:@"%@",dict.wash];
            break;
        case 6:
            zuoLable.text = @"零售";
            youLable.text = [NSString stringWithFormat:@"%@",dict.retail];
            break;
        case 7:
            zuoLable.text = @"会员卡";
            youLable.text = [NSString stringWithFormat:@"%@",dict.vip];
            break;
        default:
            break;
    }
}

@end
