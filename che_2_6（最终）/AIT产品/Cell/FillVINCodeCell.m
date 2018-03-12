//
//  FillVINCodeCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillVINCodeCell.h"
#import "CheDianZhangCommon.h"

@implementation FillVINCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = kRGBColor(250, 250, 250);
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *la1 = [[UILabel alloc]init];
        [self setnewLabel:la1];
        la1.textAlignment = NSTextAlignmentRight;
        la1.text = @"车牌号：";
        [self.contentView addSubview:la1];
        [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(56/2);
        }];
        
        chePaiLabel = [[UILabel alloc]init];
        [self setnewLabel:chePaiLabel];
        [self.contentView addSubview:chePaiLabel];
        [chePaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(la1);
            make.height.mas_equalTo(56/2);
            make.left.mas_equalTo(la1.mas_right);
        }];
        
        UILabel *la2 = [[UILabel alloc]init];
        [self setnewLabel:la2];
        la2.textAlignment = NSTextAlignmentRight;
        la2.text = @"V  I  N：";
        [self.contentView addSubview:la2];
        [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(56/2);
        }];
        
        vINLabel = [[UILabel alloc]init];
        [self setnewLabel:vINLabel];
        [self.contentView addSubview:vINLabel];
        [vINLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(la2);
            make.height.mas_equalTo(56/2);
            make.left.mas_equalTo(la2.mas_right);
        }];
        
        UIImageView *neImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"new_JianTou")];
        [self.contentView addSubview:neImageView];
        [neImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(-10);
            make.width.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(void)setnewLabel:(UILabel *)bel
{
    bel.textColor = kRGBColor(74, 74, 74);
    bel.font = [UIFont systemFontOfSize:13];
}

-(void)freshdata:(NSDictionary *)dict pipei:(NSString *)str
{
    chePaiLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    
    vINLabel.attributedText = [self setSearchResultStringColor:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"VIN")] isPhoneNumber:YES withsearchString:str];
    
}
- (NSMutableAttributedString *)setSearchResultStringColor:(NSString *)resultString isPhoneNumber:(BOOL)isPhoneNumber withsearchString:(NSString *)searchString{
    NSError *error = NULL;
    NSString *initStr = resultString;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:initStr];
    
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:searchString options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *rangeArray = [expression matchesInString:initStr options:0 range:NSMakeRange(0, initStr.length)];
    
    for (NSTextCheckingResult *result in rangeArray) {
        NSRange range = [result range];
        
        if (range.location != NSNotFound) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(range.location,range.length)];
        }
    }
    
    return str;
}

@end
