//
//  DetailShiGongCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "DetailShiGongCell.h"
#import "CheDianZhangCommon.h"

@implementation DetailShiGongCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kRGBColor(245, 245, 245);
        zuoLabel = [[UILabel alloc]init];
        zuoLabel.font = [UIFont systemFontOfSize:13];
        zuoLabel.textColor = kRGBColor(74, 74, 74);
        zuoLabel.numberOfLines  = 3;
        [self.contentView addSubview:zuoLabel];
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(-100);
        }];
        
        youLabel = [[UILabel alloc]init];
        youLabel.font = [UIFont systemFontOfSize:13];
        youLabel.textColor = kRGBColor(155, 155, 155);
        [self.contentView addSubview:youLabel];
        [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.line = [[UILabel alloc]init];
        self.line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}
-(void)refleshDataXiMei:(NSDictionary *)dict whitshiFouXian:(BOOL)line
{
    self.line.hidden = YES;
    zuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"service")];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"价格：%@",KISDictionaryHaveKey(dict, @"service_fee")]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"service_fee")].length)];
    youLabel.attributedText = att;
}

-(void)refleshData:(PeiJianListModel *)dict whitshiFouXian:(BOOL)line{
    self.line.hidden = line;
    zuoLabel.text = dict.cname;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"数量：%@   总价：%@",dict.parts_num,dict.parts_total]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, dict.parts_num.length)];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(6+dict.parts_num.length+3, dict.parts_total.length)];
    youLabel.attributedText = att;

}
-(void)refleshDataxianMu:(OrignalModel *)dict whitshiFouXian:(BOOL)line{
    self.line.hidden = line;
    zuoLabel.text = dict.subject;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"价格：%@",dict.reality_fee]];
    [att addAttribute:NSForegroundColorAttributeName value:kRGBColor(74, 74, 74) range:NSMakeRange(3, dict.reality_fee.length)];
    youLabel.attributedText = att;
}

@end
