//
//  BossJianCeTableViewCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossJianCeTableViewCell.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"

@implementation BossJianCeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView*backView=[[UIView alloc]init];
        [backView.layer setMasksToBounds:YES];
        [backView.layer setCornerRadius:8];
        [backView.layer setBorderWidth:1];
        [backView.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(26);
            make.right.mas_equalTo(-26);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(0);
        }];
        titleUilable=[[UILabel alloc]init];
        titleUilable.font = [UIFont systemFontOfSize:17];
        titleUilable.textColor = kRGBColor(74, 74, 74);
        [backView addSubview:titleUilable];
        [titleUilable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backView);
            make.top.mas_equalTo(8);
        }];
        
        UILabel *defenLa=[[UILabel alloc]init];
        defenLa.font=[UIFont systemFontOfSize:17];
        defenLa.textColor=kRGBColor(74, 74, 74);
        defenLa.text=@"得分";
        [backView addSubview:defenLa];
        [defenLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.bottom.mas_equalTo(-12);
        }];
        
        codeUIlable=[[UILabel alloc]init];
        codeUIlable.font=[UIFont systemFontOfSize:17];
        //codeUIlable.textColor=[UIColor greenColor];
        [backView addSubview:codeUIlable];
        [codeUIlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(defenLa.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(defenLa);
        }];
        
        mainimgView=[[UIImageView alloc]init];
        [self.contentView addSubview:mainimgView];
        [mainimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(backView.mas_left).mas_equalTo(12);
            make.right.mas_equalTo(backView.mas_right).mas_equalTo(-12);
            make.bottom.mas_equalTo(backView.mas_bottom).mas_equalTo(-48);
            make.top.mas_equalTo(backView.mas_top).mas_equalTo(40);
        }];
        [self.contentView bringSubviewToFront:mainimgView];
        
        dateLabel=[[UILabel alloc]init];
        dateLabel.font=[UIFont systemFontOfSize:17];
        dateLabel.textColor=kRGBColor(74, 74, 74);
        [backView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-14);
            make.bottom.mas_equalTo(-12);
        }];
    }
    return self;
}
-(void)refleshData:(BossJianceModel *)dict
{
    titleUilable.text = dict.test_paper_name;
    int intString = [dict.score intValue];
    if(intString>=60){
      codeUIlable.text = dict.score;
        codeUIlable.textColor=[UIColor greenColor];
    }else{
        codeUIlable.textColor=[UIColor redColor];
        codeUIlable.text=dict.score;
    }
    [mainimgView sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_fond_beijing")];
    dateLabel.text = dict.time;
}

@end
