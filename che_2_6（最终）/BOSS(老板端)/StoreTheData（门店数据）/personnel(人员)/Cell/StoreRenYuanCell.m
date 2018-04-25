//
//  StoreRenYuanCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenYuanCell.h"

@implementation StoreRenYuanCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView *zuoview = [[UIView alloc]init];
        [self.contentView addSubview:zuoview];
        [zuoview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(252*kWindowW/750);
            make.height.mas_equalTo(152/2);
        }];
        
        touImgview = [[UIImageView alloc]init];
        [zuoview addSubview:touImgview];
        [touImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(58/2);
            make.centerY.mas_equalTo(zuoview);
            make.height.mas_equalTo(56/2);
            make.width.mas_equalTo(66/2);
        }];
        
        shunxuLable = [[UILabel alloc]init];
        shunxuLable.font =[UIFont systemFontOfSize:17];
        [shunxuLable setTextColor:kRGBColor(74, 74, 74)];
        [zuoview addSubview:shunxuLable];
        [shunxuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(76/2);
            make.centerY.mas_equalTo(zuoview);
        }];
        
        
        
        
        
        
        UIView *centerview = [[UIView alloc]init];
        [self.contentView addSubview:centerview];
        [centerview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(zuoview.mas_left).mas_equalTo(0);
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(550*kWindowW/750);
            make.height.mas_equalTo(152/2);
        }];
        
        renYuanimgview = [[UIImageView alloc]init];
        [renYuanimgview.layer setMasksToBounds:YES];
        [renYuanimgview.layer setCornerRadius:18];
        [centerview addSubview:renYuanimgview];
        [renYuanimgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(centerview);
            make.height.mas_equalTo(72/2);
            make.width.mas_equalTo(72/2);
        }];
        
        nameLable= [[UILabel alloc]init];
        nameLable.font =[UIFont systemFontOfSize:16];
        [nameLable setTextColor:kRGBColor(132, 148, 165)];
        [centerview addSubview:nameLable];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(renYuanimgview.mas_right).mas_equalTo(9);
            make.centerY.mas_equalTo(zuoview);
        }];
        
        
        
        UIView *rightview = [[UIView alloc]init];
        [self.contentView addSubview:rightview];
        [rightview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(centerview.mas_left).mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(152/2);
        }];
        
        yejiLable = [[UILabel alloc]init];
        yejiLable.font =[UIFont systemFontOfSize:16];
        [yejiLable setTextColor:kRGBColor(132, 148, 165)];
        [rightview addSubview:yejiLable];
        [yejiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(rightview);
        }];
    }
    return self;
}

-(void)refleshData:(listModel *)dict dieIndex:(NSIndexPath*)index{
    if (index.row ==0) {
        touImgview.image = [UIImage imageNamed:@""];
        shunxuLable.hidden = YES;
    }else if(index.row == 1)
    {
         touImgview.image = [UIImage imageNamed:@""];
         shunxuLable.hidden = YES;
    }else if(index.row == 2)
    {
         touImgview.image = [UIImage imageNamed:@""];
         shunxuLable.hidden = YES;
    }else{
        shunxuLable.text = [NSString stringWithFormat:@"%ld",index.row];
        shunxuLable.hidden = NO;
        
    }
    yejiLable.text = dict.total_price;
    nameLable.text = dict.real_name;
    [renYuanimgview sd_setImageWithURL:[NSURL URLWithString:dict.avatar] placeholderImage:DJImageNamed(@"Boss_fond_beijing_new")];
}
@end
