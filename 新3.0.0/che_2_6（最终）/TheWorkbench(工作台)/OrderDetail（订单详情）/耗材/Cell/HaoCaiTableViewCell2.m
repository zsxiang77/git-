//
//  HaoCaiTableViewCell2.m
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "HaoCaiTableViewCell2.h"

@implementation HaoCaiTableViewCell2

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
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
        }];
        
        UILabel *label3 = [[UILabel alloc]init];
        label3.textColor = kRGBColor(133, 133, 133);
        label3.text = @"配件编码：";
        label3.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(50);
        }];
        
        bianmaFeiLabel = [[UILabel alloc]init];
        bianmaFeiLabel.textColor = kRGBColor(133, 133, 133);
        bianmaFeiLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:bianmaFeiLabel];
        [bianmaFeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label3.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label3);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.textColor = kRGBColor(133, 133, 133);
        label1.text = @"属性：";
        label1.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bianmaFeiLabel.mas_right).mas_equalTo(21);
            make.centerY.mas_equalTo(bianmaFeiLabel);
        }];
        
        shuxingLabel = [[UILabel alloc]init];
        shuxingLabel.textColor = kRGBColor(133, 133, 133);
        shuxingLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:shuxingLabel];
        [shuxingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label1.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label1);
        }];
        
        
        danweiLable = [[UILabel alloc]init];
        danweiLable.textColor = kRGBColor(133, 133, 133);
        danweiLable.font = [UIFont systemFontOfSize:12];
        [backView addSubview:danweiLable];
        [danweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(shuxingLabel.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(shuxingLabel);
        }];
        
        
        shuliangLabel = [[UILabel alloc]init];
        shuliangLabel.textColor = kRGBColor(133, 133, 133);
        shuliangLabel.font = [UIFont systemFontOfSize:12];
         [backView addSubview:shuliangLabel];
        [shuliangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
        
        UILabel *label4 = [[UILabel alloc]init];
        label4.textColor = kRGBColor(133, 133, 133);
        label4.text = @"价格：";
        label4.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label4];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(shuliangLabel.mas_right).mas_equalTo(20);
            make.centerY.mas_equalTo(shuliangLabel);
        }];
        
        jiageLabel = [[UILabel alloc]init];
        jiageLabel.textColor = kRGBColor(255, 0, 31);
        jiageLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:jiageLabel];
        [jiageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label4.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label4);
        }];
        
        
        bianJiaTu = [[UIImageView alloc]initWithImage:DJImageNamed(@"order_xiangMu_BianJi")];
        [backView addSubview:bianJiaTu];
        [bianJiaTu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jiageLabel.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(jiageLabel);
            make.width.height.mas_equalTo(15);
        }];
        
        bianJiBT = [[UIButton alloc]init];
        [bianJiBT addTarget:self action:@selector(bianJiBTChcick:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:bianJiBT];
        [bianJiBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jiageLabel.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(jiageLabel);
            make.width.height.mas_equalTo(30);
        }];
    }
    return self;
}


-(void)bianJiBTChcick:(UIButton *)sender
{
    self.model.shiFouKeShan = !self.model.shiFouKeShan;
    self.bianJiBTChcickBlock();
}


-(void)refeleseWithModel:(Service_commods *)model
{
    self.model = model;
    titleLabel.text = model.name;
    jiageLabel.text = [NSString stringWithFormat:@"%@",model.price];
    shuxingLabel.text = [NSString stringWithFormat:@"%@",model.sku_properties];
    bianmaFeiLabel.text = [NSString stringWithFormat:@"%@",model.commodity_id];
    shuliangLabel.text = [NSString stringWithFormat:@"数量：%@",model.count];
    danweiLable.text = [NSString stringWithFormat:@"单位：%@",model.unit];
    if([model.is_orignal boolValue] == YES){
        bianJiBT.hidden = YES;
        bianJiaTu.hidden = YES;
    }else{
        bianJiBT.hidden = NO;
        bianJiaTu.hidden = NO;
    }
}

@end
