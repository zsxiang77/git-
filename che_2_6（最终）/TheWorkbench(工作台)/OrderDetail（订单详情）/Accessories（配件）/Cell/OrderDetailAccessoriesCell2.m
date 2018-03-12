//
//  OrderDetailAccessoriesCell2.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailAccessoriesCell2.h"

@implementation OrderDetailAccessoriesCell2


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *line1 = [[UILabel alloc]init];
        line1.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
        }];
        
        bianHaoLabel = [[UILabel alloc]init];
        bianHaoLabel.font = [UIFont systemFontOfSize:12];
        bianHaoLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:bianHaoLabel];
        [bianHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-97/2);
        }];
        
        kuCunLabel = [[UILabel alloc]init];
        kuCunLabel.font = [UIFont systemFontOfSize:12];
        kuCunLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:kuCunLabel];
        [kuCunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(150);
            make.bottom.mas_equalTo(-97/2);
        }];
        
        danWeiLabel = [[UILabel alloc]init];
        danWeiLabel.font = [UIFont systemFontOfSize:12];
        danWeiLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:danWeiLabel];
        [danWeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kuCunLabel.mas_right).mas_equalTo(40);
            make.bottom.mas_equalTo(-97/2);
        }];
        
        
        numberLabel = [[UILabel alloc]init];
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-15);
        }];
        
        UILabel * jiaGeLabelzi = [[UILabel alloc]init];
        jiaGeLabelzi.font = [UIFont systemFontOfSize:12];
        jiaGeLabelzi.textColor = kRGBColor(133, 133, 133);
        jiaGeLabelzi.text = @"价格：";
        [self.contentView addSubview:jiaGeLabelzi];
        [jiaGeLabelzi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kuCunLabel);
            make.bottom.mas_equalTo(-15);
        }];
        
        jiaGeLabel = [[UILabel alloc]init];
        jiaGeLabel.font = [UIFont systemFontOfSize:12];
        jiaGeLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:jiaGeLabel];
        [jiaGeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jiaGeLabelzi.mas_right).mas_equalTo(0);
            make.bottom.mas_equalTo(-15);
        }];
        
        UIImageView *bianJiaTu = [[UIImageView alloc]initWithImage:DJImageNamed(@"order_xiangMu_BianJi")];
        [self.contentView addSubview:bianJiaTu];
        [bianJiaTu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jiaGeLabel.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(jiaGeLabel);
            make.width.height.mas_equalTo(15);
        }];
        
        UIButton *bianJiBT = [[UIButton alloc]init];
        [bianJiBT addTarget:self action:@selector(bianJiBTChcick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:bianJiBT];
        [bianJiBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jiaGeLabel.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(jiaGeLabel);
            make.width.height.mas_equalTo(30);
        }];
        
    }
    return self;
}
-(void)bianJiBTChcick:(UIButton *)sender
{
    self.model.shiFouBianJi = !self.model.shiFouBianJi;
    self.bianJiBTChcickBlock();
}

-(void)refeleseWithModel:(OrderDetailPartsModel *)model
{
    self.model = model;
    titleLabel.text = model.parts_name;
    bianHaoLabel.text = [NSString stringWithFormat:@"编号：%@",model.parts_id];
    kuCunLabel.text = [NSString stringWithFormat:@"库存：%@",model.count];
    danWeiLabel.text = [NSString stringWithFormat:@"单位：%@",model.unit];
    
    numberLabel.text = [NSString stringWithFormat:@"数量：%@",model.parts_num];
    jiaGeLabel.text = [NSString stringWithFormat:@"%@",model.parts_fee];
}

@end
