//
//  OrderDetailProjectCell2.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailProjectCell2.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailProjectCell2


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
        }];
        
        UILabel *label3 = [[UILabel alloc]init];
        label3.textColor = kRGBColor(133, 133, 133);
        label3.text = @"工时：";
        label3.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(50);
        }];
        
        gongShiLabel = [[UILabel alloc]init];
        gongShiLabel.textColor = kRGBColor(133, 133, 133);
        gongShiLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:gongShiLabel];
        [gongShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label3.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label3);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.textColor = kRGBColor(133, 133, 133);
        label1.text = @"工时费：";
        label1.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gongShiLabel.mas_right).mas_equalTo(21);
            make.centerY.mas_equalTo(gongShiLabel);
        }];
        
        gongShiFeiLabel = [[UILabel alloc]init];
        gongShiFeiLabel.textColor = kRGBColor(255, 0, 31);
        gongShiFeiLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:gongShiFeiLabel];
        [gongShiFeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label1.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label1);
        }];
        
        UIImageView *bianJiaTu = [[UIImageView alloc]initWithImage:DJImageNamed(@"order_xiangMu_BianJi")];
        [backView addSubview:bianJiaTu];
        [bianJiaTu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gongShiFeiLabel.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(gongShiFeiLabel);
            make.width.height.mas_equalTo(15);
        }];
        
        UIButton *bianJiBT = [[UIButton alloc]init];
        [bianJiBT addTarget:self action:@selector(bianJiBTChcick:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:bianJiBT];
        [bianJiBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gongShiFeiLabel.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(gongShiFeiLabel);
            make.width.height.mas_equalTo(30);
        }];
        
        shiGongRenLabel = [[UILabel alloc]init];
        shiGongRenLabel.textColor = kRGBColor(132, 132, 132);
        shiGongRenLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:shiGongRenLabel];
        [shiGongRenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-8);
            make.left.mas_equalTo(10);
        }];
        
        UIButton *paiGongBt = [[UIButton alloc]init];
        [paiGongBt addTarget:self action:@selector(paiGongBtChcick:) forControlEvents:(UIControlEventTouchUpInside)];
        [paiGongBt setBackgroundImage:DJImageNamed(@"order_xiangMu_paiGong") forState:(UIControlStateNormal)];
        [backView addSubview:paiGongBt];
        [paiGongBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(17);
            make.width.height.mas_equalTo(45);
        }];
    }
    return self;
}

-(void)paiGongBtChcick:(UIButton *)sender
{
    self.paiGongBtChcickBlock(self.model);
}

-(void)bianJiBTChcick:(UIButton *)sender
{
    self.model.shiFouBianJi = !self.model.shiFouBianJi;
    self.bianJiBTChcickBlock();
}


-(void)refeleseWithModel:(OrderDetailSubjectsModel *)model
{
    self.model = model;
    titleLabel.text = model.name;
    gongShiLabel.text = model.hour;
    gongShiFeiLabel.text = model.reality_fee;
    if (model.operation_name.length>0) {
        shiGongRenLabel.text = [NSString stringWithFormat:@"施工人员:%@",model.operation_name];
    }else{
        shiGongRenLabel.text = @"施工人员:未派工";
    }
}

@end
