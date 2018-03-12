//
//  BOSSSystemKeChengCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSSystemKeChengCell.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"

@implementation BOSSSystemKeChengCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        titleUilable=[[UILabel alloc]init];
        titleUilable.font = [UIFont systemFontOfSize:32/2];
        titleUilable.textColor=kRGBColor(74, 74, 74);
        titleUilable.numberOfLines=0;
        [self.contentView addSubview:titleUilable];
        [titleUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
        }];
        
        gengXinDateLabel = [[UILabel alloc]init];
        gengXinDateLabel.textColor = kRGBColor(126, 126, 126);
        gengXinDateLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:gengXinDateLabel];
        [gengXinDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleUilable.mas_right).mas_equalTo(20);
            make.centerY.mas_equalTo(titleUilable);
        }];
        
        
        leftuiImgView=[[UIImageView alloc]init];
        [self.contentView addSubview:leftuiImgView];
        [leftuiImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(72/2);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(80);
        }];
        
        keshiUilable=[[UILabel alloc]init];
        keshiUilable.textColor=kRGBColor(74, 74, 74);
        keshiUilable.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:keshiUilable];
        [keshiUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftuiImgView.mas_right).mas_equalTo(9);
            make.top.mas_equalTo(72/2);
        }];
        
        
        priceUilable=[[UILabel alloc]init];
        priceUilable.textColor=kRGBColor(153, 153, 153);
        priceUilable.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:priceUilable];
        [priceUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(leftuiImgView);
            make.left.mas_equalTo(leftuiImgView.mas_right).mas_equalTo(10);
        }];
        UILabel*line=[[UILabel alloc]init];
        line.backgroundColor=kRGBColor(200, 199, 204);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(140);
        }];
    }
    return self;
}
-(void)refleshData:(NSDictionary *)dict
{
    [leftuiImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"images")]] placeholderImage:DJImageNamed(@"Boss_fond_beijing")];
    titleUilable.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"list_name")];
    gengXinDateLabel.text = [NSString stringWithFormat:@"%@更新了",KISDictionaryHaveKey(dict, @"time")];
    keshiUilable.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
//    priceUilable.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"title")];
}

@end
