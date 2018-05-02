//
//  HistroyLookUItableViewCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "HistroyLookUItableViewCell.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"
@implementation HistroyLookUItableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        mainimgView=[[UIImageView alloc]init];
        [self.contentView addSubview:mainimgView];
        [mainimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(312/2);
            make.height.mas_equalTo(226/2);
        }];
        titleUilable=[[UILabel alloc]init];
        titleUilable.font=[UIFont systemFontOfSize:17];
        titleUilable.textColor=kRGBColor(74, 74, 74);
        titleUilable.numberOfLines=0;
        [self.contentView addSubview:titleUilable];
        [titleUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mainimgView.mas_right).mas_equalTo(9);
            make.right.mas_equalTo(27);
            make.top.mas_equalTo(12);
        }];
        keshiUilable=[[UILabel alloc]init];
        keshiUilable.textColor=kRGBColor(153, 153, 153);
        keshiUilable.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:keshiUilable];
        [keshiUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mainimgView.mas_right).mas_equalTo(9);
            make.top.mas_equalTo(65);
            make.bottom.mas_equalTo(-57);
        }];
        studyUilable=[[UILabel alloc]init];
        studyUilable.textColor=kRGBColor(153, 153, 153);
        studyUilable.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:studyUilable];
        [studyUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mainimgView.mas_right).mas_equalTo(9);
            make.bottom.mas_equalTo(-12);
            make.top.mas_equalTo(108);
        }];
        timeLongLable=[[UILabel alloc]init];
        timeLongLable.textColor=kRGBColor(74, 144, 226);
        timeLongLable.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:timeLongLable];
        [timeLongLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(studyUilable.mas_right).mas_equalTo(7);
            make.centerY.mas_equalTo(studyUilable);
        }];
        UILabel *str=[[UILabel alloc]init];
        str.text=@"分钟";
        str.textColor=kRGBColor(0, 0, 0);
        str.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:str];
        [str mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(timeLongLable.mas_right).mas_equalTo(1);
            make.centerY.mas_equalTo(timeLongLable);
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
-(void)refleshData:(HistroyModel *)dict
{
    titleUilable.text=dict.title;
    keshiUilable.text=[NSString stringWithFormat:@"第%@课",dict.num];
    studyUilable.text=@"已学习";
    NSInteger minutes = [dict.minutes integerValue]/60000;
    timeLongLable.text=[NSString stringWithFormat:@"%ld",minutes];
    [mainimgView sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_fond_beijing")];
}
@end
