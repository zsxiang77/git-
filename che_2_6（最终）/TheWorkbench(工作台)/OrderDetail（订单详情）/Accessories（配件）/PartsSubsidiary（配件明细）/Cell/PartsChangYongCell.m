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
        [self.contentView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(8);
        }];
        
        bianhaoLable = [[UILabel alloc]init];
        [self.contentView addSubview:bianhaoLable];
        [bianhaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(8);
        }];
    }
    return self;
}

-(void)refelesePeiJianWithModel:(OrderDetailPartsModel *)model
{
    
}
@end
