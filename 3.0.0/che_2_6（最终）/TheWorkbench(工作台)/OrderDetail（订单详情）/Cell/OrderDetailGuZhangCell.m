//
//  OrderDetailGuZhangCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailGuZhangCell.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailGuZhangCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.font = [UIFont systemFontOfSize:11];
        dateLabel.adjustsFontSizeToFitWidth = YES;
        dateLabel.backgroundColor = kRGBColor(239, 239, 239);
        [dateLabel.layer setMasksToBounds:YES];
        [dateLabel.layer setCornerRadius:15];
        dateLabel.textColor = kRGBColor(51, 51, 51);
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(13);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(78);
            make.height.mas_equalTo(30);
        }];
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(118);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_lessThanOrEqualTo(-20);
        }];
        
        UIImageView *baVi = [[UIImageView alloc]initWithImage:DJImageNamed(@"guZhang_LiaoTian_qipao")];
        [self.contentView addSubview:baVi];
        [baVi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.bottom.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(5);
            make.right.mas_equalTo(titleLabel.mas_right).mas_equalTo(5);
            make.top.mas_equalTo(titleLabel.mas_top).mas_equalTo(-5);
        }];
        [self.contentView bringSubviewToFront:titleLabel];
        
        UILabel *lune = [[UILabel alloc]init];
        lune.backgroundColor = kLineBgColor;
        [self.contentView addSubview:lune];
        [lune mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(10);
        }];
    }
    return self;
}


-(void)refeleseWithModel:(NSDictionary *)model
{
    NSString *timeStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"time")];
    
    dateLabel.text = [self timeWithTimeIntervalString:timeStr];
    titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(model, @"info")];
}
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
