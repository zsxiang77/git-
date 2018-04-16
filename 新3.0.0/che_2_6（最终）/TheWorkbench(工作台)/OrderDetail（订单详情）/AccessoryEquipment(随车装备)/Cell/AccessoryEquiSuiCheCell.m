//
//  AccessoryEquiSuiCheCell.m
//  cheDianZhang
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "AccessoryEquiSuiCheCell.h"

@implementation AccessoryEquiSuiCheCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
        
        UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 45)];
        mainView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:mainView];
        
        
        _xuanZhongImaheView=[[UIImageView alloc]init];
        [mainView addSubview:_xuanZhongImaheView];
        [_xuanZhongImaheView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(mainView);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(18);
        }];
        
        _zuoTitelLabel = [[UILabel alloc]init];
        _zuoTitelLabel.font=[UIFont systemFontOfSize:14];
        [_zuoTitelLabel setTextColor:kRGBColor(74, 74, 74)];
        [mainView addSubview:_zuoTitelLabel];
        [_zuoTitelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_xuanZhongImaheView.mas_right).mas_equalTo(11);
            make.centerY.mas_equalTo(mainView);
        }];
        
        UILabel * line =[[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [mainView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

@end
