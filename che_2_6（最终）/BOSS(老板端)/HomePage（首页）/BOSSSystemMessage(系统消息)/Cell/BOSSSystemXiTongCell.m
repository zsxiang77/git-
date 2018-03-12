//
//  BOSSSystemXiTongCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSSystemXiTongCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation BOSSSystemXiTongCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = kRGBColor(250, 250, 250);
        gengXinDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 32)];
        gengXinDateLabel.textAlignment = NSTextAlignmentCenter;
        gengXinDateLabel.font = [UIFont systemFontOfSize:14];
        gengXinDateLabel.textColor = kRGBColor(153, 153, 153);
        [self.contentView addSubview:gengXinDateLabel];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.right.mas_equalTo(-19);
            make.top.mas_equalTo(39);
        }];
        
        
        neiRongLabel = [[UILabel alloc]init];
        neiRongLabel.numberOfLines = 0;
        neiRongLabel.textAlignment = NSTextAlignmentCenter;
        neiRongLabel.font = [UIFont systemFontOfSize:12];
        neiRongLabel.textColor = kRGBColor(51, 51, 51);
        [self.contentView addSubview:neiRongLabel];
        [neiRongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.right.mas_equalTo(-19);
            make.top.mas_equalTo(60);
        }];
        UIView *banView = [[UIView alloc]init];
        banView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:banView];
        [banView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_top).mas_equalTo(-5);
            make.bottom.mas_equalTo(neiRongLabel.mas_bottom).mas_equalTo(5);
            make.left.mas_equalTo(9);
            make.right.mas_equalTo(-9);
        }];
        
        [self.contentView bringSubviewToFront:titleLabel];
        [self.contentView bringSubviewToFront:neiRongLabel];
    }
    return self;
}

-(void)refleshData:(NSDictionary *)dict
{
    gengXinDateLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"time")];
    titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
    neiRongLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"content")];
}

@end
