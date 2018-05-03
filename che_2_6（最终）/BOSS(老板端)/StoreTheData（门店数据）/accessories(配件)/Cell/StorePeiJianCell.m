//
//  StorePeiJianCell.m
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StorePeiJianCell.h"

@implementation StorePeiJianCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        touImgview = [[UIImageView alloc]init];
        [self.contentView addSubview:touImgview];
        [touImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(56/2);
            make.width.mas_equalTo(66/2);
        }];
        
        shunxuLable = [[UILabel alloc]init];
        shunxuLable .font = [UIFont systemFontOfSize:14];
        [shunxuLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:shunxuLable];
        [shunxuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        nameLable = [[UILabel alloc]init];
        nameLable .font = [UIFont systemFontOfSize:14];
        [nameLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:nameLable];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(touImgview.mas_right).mas_equalTo(33);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        
        jiageLable = [[UILabel alloc]init];
        jiageLable .font = [UIFont systemFontOfSize:14];
        [jiageLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:jiageLable];
        [jiageLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLable.mas_right).mas_equalTo(144/2);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        peijianBiLable = [[UILabel alloc]init];
        peijianBiLable .font = [UIFont systemFontOfSize:14];
        [peijianBiLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:peijianBiLable];
        [peijianBiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        
        peijianpaiLable = [[UILabel alloc]init];
        peijianpaiLable .font = [UIFont systemFontOfSize:14];
        [peijianpaiLable setTextColor:kRGBColor(74, 74, 74)];
        [self.contentView addSubview:peijianpaiLable];
        [peijianpaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(peijianBiLable.mas_left).mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
-(void)refleshData:(listPeiJianModel *)dict dieIndex:(NSIndexPath*)index
{
    touImgview.hidden = YES;
    if (index.row ==0) {
        touImgview.hidden = NO;
        touImgview.image = [UIImage imageNamed:@"huangGuan1"];
        shunxuLable.hidden = YES;
    }else if(index.row == 1)
    {
        touImgview.hidden = NO;
        touImgview.image = [UIImage imageNamed:@"huangGuan2"];
        shunxuLable.hidden = YES;
    }else if(index.row == 2)
    {
        touImgview.hidden = NO;
        touImgview.image = [UIImage imageNamed:@"huangGuan3"];
        shunxuLable.hidden = YES;
    }else{
        shunxuLable.text = [NSString stringWithFormat:@"%ld",index.row+1];
        shunxuLable.hidden = NO;
    }
    nameLable.text = [NSString stringWithFormat:@"%@",dict.class_name];
    jiageLable.text = [NSString stringWithFormat:@"%@",dict.sales_price];
    peijianpaiLable.text = [NSString stringWithFormat:@"%@",dict.parts_brand];
    peijianBiLable.text = [NSString stringWithFormat:@"%@",dict.parts_percent];
}
@end
