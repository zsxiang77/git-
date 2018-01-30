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
        codeUIlable.textColor=[UIColor greenColor];
        [backView addSubview:codeUIlable];
        [codeUIlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(defenLa.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(defenLa);
        }];
        
        mainimgView=[[UIImageView alloc]init];
        [backView addSubview:mainimgView];
        [mainimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(40);
            make.bottom.mas_equalTo(-48);
        }];
        
        UIImageView *jiantouimgview=[[UIImageView alloc]init];
        jiantouimgview.image=DJImageNamed(@"Boss_hall_jiantou");
        [backView addSubview:jiantouimgview];
        [jiantouimgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(defenLa);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
            
        }];
        
        UIButton*dianjiBt=[[UIButton alloc]init];
        [backView addSubview:dianjiBt];
        [dianjiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [backView bringSubviewToFront:dianjiBt];
        
        
        
        
    }
    return self;
}
-(void)refleshData:(BossJianceModel *)dict
{
    titleUilable.text = dict.test_paper_name;
    codeUIlable.text = dict.score;
    [mainimgView sd_setImageWithURL:[NSURL URLWithString:dict.image] placeholderImage:DJImageNamed(@"Boss_fond_beijing")];
}

@end
