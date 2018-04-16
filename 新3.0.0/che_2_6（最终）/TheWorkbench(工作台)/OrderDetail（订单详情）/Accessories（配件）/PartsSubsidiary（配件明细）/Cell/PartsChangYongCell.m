//
//  PartsChangYongCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "PartsChangYongCell.h"

@implementation PartsChangYongCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        titleLable = [[UILabel alloc]init];
        titleLable.font = [UIFont systemFontOfSize:15];
        titleLable.textColor = kRGBColor(51, 51, 51);
        titleLable.numberOfLines = 0;
        [self.contentView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(8);
        }];
        
        bianhaoLable = [[UILabel alloc]init];
        bianhaoLable.font = [UIFont systemFontOfSize:12];
        bianhaoLable.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:bianhaoLable];
        [bianhaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-8);
        }];
        
        
        kucunLable = [[UILabel alloc]init];
        kucunLable.font = [UIFont systemFontOfSize:12];
        kucunLable.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:kucunLable];
        [kucunLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bianhaoLable.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(bianhaoLable);
        }];
        
        
        danweiLable = [[UILabel alloc]init];
        danweiLable.font = [UIFont systemFontOfSize:12];
        danweiLable.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:danweiLable];
        [danweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kucunLable.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(kucunLable);
        }];
        
        
        danjiaLable = [[UILabel alloc]init];
        danjiaLable.font = [UIFont systemFontOfSize:12];
        danjiaLable.textColor = kRGBColor(133, 132, 136);
        [self.contentView addSubview:danjiaLable];
        [danjiaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(danweiLable.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(danweiLable);
        }];
        
    }
    return self;
}

-(void)refelesePeiJianWithModel:(NSDictionary *)model
{
    OrderDetailPartsModel * modes =[[OrderDetailPartsModel alloc]init];
    [modes setdataWithDict:model];
    titleLable.text  =  modes.parts_name;
    bianhaoLable.text  = [NSString stringWithFormat:@"编号:%@",modes.parts_code];
    kucunLable.text  =  [NSString stringWithFormat:@"库存:%@",modes.count];
    danweiLable.text  =  [NSString stringWithFormat:@"单位:%@",modes.unit];
    danjiaLable.text  =  [NSString stringWithFormat:@"单价:%@",modes.parts_fee];
}
@end
