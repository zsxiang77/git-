//
//  OrderDetailGuZhangQiTaCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailGuZhangQiTaCell.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailGuZhangQiTaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        backView = [[UIView alloc]init];
        backView.backgroundColor = kRGBColor(250, 250, 250);
        [backView.layer setMasksToBounds:YES];
        [backView.layer setBorderWidth:1];
        [backView.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(36);
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)refeleseWithPeiJianModel:(NSArray *)model
{
    while ([backView.subviews lastObject] != nil)
    {
        [[backView.subviews lastObject] removeFromSuperview];
    }
    
    for (int i = 0; i<model.count; i++) {
        OrderDetailPartsModel *dataMode = model[i];
        UIView *dingView = [[UIView alloc]init];
        [backView addSubview:dingView];
        [dingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i*50);
            make.height.mas_equalTo(50);
        }];
        
        if (i != model.count-1) {
            UILabel *line = [[UILabel alloc]init];
            line.backgroundColor = kLineBgColor;
            [dingView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(0);
            }];
        }
        
        UILabel *titLe = [[UILabel alloc]init];
        titLe.text = dataMode.parts_name;
        titLe.adjustsFontSizeToFitWidth = YES;
        titLe.font = [UIFont systemFontOfSize:12];
        titLe.textColor = kRGBColor(51, 51, 51);
        titLe.numberOfLines = 2;
        [dingView addSubview:titLe];
        [titLe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(dingView);
            make.right.mas_equalTo(-150);
        }];
        
        
        CGFloat  parts_num = [dataMode.parts_num floatValue];
        CGFloat  parts_fee = [dataMode.parts_fee floatValue];
        UILabel *titLe2 = [[UILabel alloc]init];
        titLe2.text = [NSString stringWithFormat:@"¥%.2f",parts_num*parts_fee];
        titLe2.font = [UIFont systemFontOfSize:14];
        titLe2.textColor = kRGBColor(51, 51, 51);
        [dingView addSubview:titLe2];
        [titLe2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(dingView);
        }];
        
    }
}


-(void)refeleseWithXianMuModel:(NSArray *)model
{
    while ([backView.subviews lastObject] != nil)
    {
        [[backView.subviews lastObject] removeFromSuperview];
    }
    
    for (int i = 0; i<model.count; i++) {
        OrderDetailSubjectsModel *dataMode = model[i];
        UIView *dingView = [[UIView alloc]init];
        [backView addSubview:dingView];
        [dingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i*50);
            make.height.mas_equalTo(50);
        }];
        
        if (i != model.count-1) {
            UILabel *line = [[UILabel alloc]init];
            line.backgroundColor = kLineBgColor;
            [dingView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(0);
            }];
        }
        
        UILabel *titLe = [[UILabel alloc]init];
        titLe.text = [NSString stringWithFormat:@"%@",dataMode.name];
        titLe.adjustsFontSizeToFitWidth = YES;
        titLe.font = [UIFont systemFontOfSize:12];
        titLe.textColor = kRGBColor(51, 51, 51);
        titLe.numberOfLines = 2;
        [dingView addSubview:titLe];
        [titLe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(dingView);
            make.right.mas_equalTo(-150);
        }];
        
        
        CGFloat  reality_fee = [dataMode.reality_fee floatValue];
        CGFloat  hour = [dataMode.hour floatValue];
        UILabel *titLe2 = [[UILabel alloc]init];
        titLe2.text = [NSString stringWithFormat:@"¥%.2f",reality_fee*hour];
        titLe2.font = [UIFont systemFontOfSize:14];
        titLe2.textColor = kRGBColor(51, 51, 51);
        [dingView addSubview:titLe2];
        [titLe2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(dingView);
        }];
        
    }
}

-(void)refeleseWithServicesModel:(NSArray *)model
{
    while ([backView.subviews lastObject] != nil)
    {
        [[backView.subviews lastObject] removeFromSuperview];
    }
    
    for (int i = 0; i<model.count; i++) {
        NSDictionary *dataMode = model[i];
        UIView *dingView = [[UIView alloc]init];
        [backView addSubview:dingView];
        [dingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i*50);
            make.height.mas_equalTo(50);
        }];
        
        if (i != model.count-1) {
            UILabel *line = [[UILabel alloc]init];
            line.backgroundColor = kLineBgColor;
            [dingView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(0);
            }];
        }
        
        UILabel *titLe = [[UILabel alloc]init];
        titLe.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataMode, @"service")];
        titLe.adjustsFontSizeToFitWidth = YES;
        titLe.font = [UIFont systemFontOfSize:12];
        titLe.textColor = kRGBColor(51, 51, 51);
        titLe.numberOfLines = 2;
        [dingView addSubview:titLe];
        [titLe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(dingView);
            make.right.mas_equalTo(-150);
        }];
        
        
        UILabel *titLe2 = [[UILabel alloc]init];
        titLe2.text = [NSString stringWithFormat:@"¥%@",KISDictionaryHaveKey(dataMode, @"reality_price")];
        titLe2.font = [UIFont systemFontOfSize:14];
        titLe2.textColor = kRGBColor(51, 51, 51);
        [dingView addSubview:titLe2];
        [titLe2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(dingView);
        }];
        
    }
}

-(void)refeleseWithCommodsModel:(NSArray *)model
{
    while ([backView.subviews lastObject] != nil)
    {
        [[backView.subviews lastObject] removeFromSuperview];
    }
    
    for (int i = 0; i<model.count; i++) {
        NSDictionary *dataMode = model[i];
        UIView *dingView = [[UIView alloc]init];
        [backView addSubview:dingView];
        [dingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i*50);
            make.height.mas_equalTo(50);
        }];
        
        if (i != model.count-1) {
            UILabel *line = [[UILabel alloc]init];
            line.backgroundColor = kLineBgColor;
            [dingView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(0);
            }];
        }
        
        UILabel *titLe = [[UILabel alloc]init];
        titLe.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataMode, @"title")];
        titLe.adjustsFontSizeToFitWidth = YES;
        titLe.font = [UIFont systemFontOfSize:12];
        titLe.textColor = kRGBColor(51, 51, 51);
        titLe.numberOfLines = 2;
        [dingView addSubview:titLe];
        [titLe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(dingView);
            make.right.mas_equalTo(-150);
        }];
        
        
        CGFloat  count = [KISDictionaryHaveKey(dataMode, @"count") floatValue];
        CGFloat  reality_price = [KISDictionaryHaveKey(dataMode, @"reality_price") floatValue];
        UILabel *titLe2 = [[UILabel alloc]init];
        titLe2.text = [NSString stringWithFormat:@"¥%.2f",count*reality_price];
        titLe2.font = [UIFont systemFontOfSize:14];
        titLe2.textColor = kRGBColor(51, 51, 51);
        [dingView addSubview:titLe2];
        [titLe2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(dingView);
        }];
        
    }
}

@end
