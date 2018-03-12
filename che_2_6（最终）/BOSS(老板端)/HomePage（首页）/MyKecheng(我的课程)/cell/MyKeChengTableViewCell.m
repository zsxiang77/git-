//
//  MyKeChengTableViewCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "MyKeChengTableViewCell.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"
@implementation MyKeChengTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        leftuiImgView=[[UIImageView alloc]init];
        [self.contentView addSubview:leftuiImgView];
        [leftuiImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(312/2);
            make.height.mas_equalTo(226/2);
        }];
        titleUilable=[[UILabel alloc]init];
        titleUilable.font = [UIFont systemFontOfSize:32/2];
        titleUilable.textColor=kRGBColor(74, 74, 74);
        titleUilable.numberOfLines=0;
        [self.contentView addSubview:titleUilable];
        [titleUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftuiImgView.mas_right).mas_equalTo(9);
            make.top.mas_equalTo(12);
            make.right.mas_equalTo(-27);
        }];
        keshiUilable=[[UILabel alloc]init];
        keshiUilable.textColor=kRGBColor(153, 153, 153);
        keshiUilable.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:keshiUilable];
        [keshiUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftuiImgView.mas_right).mas_equalTo(9);
            make.top.mas_equalTo(130/2);
            make.bottom.mas_equalTo(-114/2);
        }];
        priceUilable=[[UILabel alloc]init];
        priceUilable.textColor=kRGBColor(98, 172, 13);
        priceUilable.font=[UIFont systemFontOfSize:40/2];
        [self.contentView addSubview:priceUilable];
        [priceUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(208/2);
            make.bottom.mas_equalTo(-8);
            make.left.mas_equalTo(leftuiImgView.mas_right).mas_equalTo(10);
        }];
        UILabel*line=[[UILabel alloc]init];
        line.backgroundColor=kRGBColor(200, 199, 204);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(140);
        }];
    }
    return self;
}
-(void)refleshData:(MyKechengModel *)dict
{
    titleUilable.text = dict.title;
    keshiUilable.text = [NSString stringWithFormat:@"第%@课",dict.num];
    priceUilable.text=[NSString stringWithFormat:@"¥%@",dict.total_fee];
    [leftuiImgView sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_fond_beijing")];
}
@end
