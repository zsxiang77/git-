//
//  CarInformeTionCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarInformeTionCell.h"

@implementation CarInformeTionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.yingYView = [[UIView alloc]init];
        self.yingYView.backgroundColor  = kRGBColor(244, 245, 246);
        self.yingYView.layer.shadowOpacity = 0.8;// 阴影透明度
        
        self.yingYView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        
        self.yingYView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        
        self.yingYView.layer.shadowOffset = CGSizeMake(3, 3);// 阴影的范围
        self.yingYView.layer.cornerRadius = 3;
        self.yingYView.layer.borderColor = kRGBColor(200, 200, 200).CGColor;//边框颜色
        
        self.yingYView.layer.borderWidth = 1;//边框宽度
        
        [self.contentView addSubview:self.yingYView];
        [self.yingYView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(-5);
        }];
    }
    return self;
}

-(UIImageView *)xuanZhongBt
{
    if (!_xuanZhongBt) {
        _xuanZhongBt = [[UIImageView alloc]init];
        
        [self.yingYView addSubview:_xuanZhongBt];
        [_xuanZhongBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.yingYView);
            make.width.height.mas_equalTo(20);
        }];
    }
    return _xuanZhongBt;
}

-(UILabel *)cheColorLabel
{
    if (!_cheColorLabel) {
        _cheColorLabel = [[UILabel alloc]init];
        _cheColorLabel.numberOfLines = 0;
        _cheColorLabel.font = [UIFont systemFontOfSize:13];
        _cheColorLabel.textColor = kNavBarColor;
        [self.yingYView addSubview:_cheColorLabel];
        [_cheColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(135);
            make.centerY.mas_equalTo(self.yingYView);
            make.width.mas_equalTo(90);
        }];
        
    }
    return _cheColorLabel;
}
-(UILabel *)colorLabel
{
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc]init];
        _colorLabel.numberOfLines = 0;
        _colorLabel.font = [UIFont systemFontOfSize:13];
        [self.yingYView addSubview:_colorLabel];
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(130+100);
            make.centerY.mas_equalTo(self.yingYView);
        }];
        
    }
    return _colorLabel;
}

-(UIButton *)shanChuButton
{
    if (!_shanChuButton) {
        _shanChuButton = [[UIButton alloc]init];
        [self.yingYView addSubview:_shanChuButton];
        [_shanChuButton addTarget:self action:@selector(shanChuButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_shanChuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.yingYView);
            make.width.height.mas_equalTo(30);
        }];
    }
    return _shanChuButton;
}

-(void)shanChuButtonChick:(UIButton *)sender
{
    self.shanChuButtonBlock(self.chuLiModel);
}


-(UILabel *)carNumeberLabel
{
    if (!_carNumeberLabel) {
        _carNumeberLabel = [[UILabel alloc]init];
        _carNumeberLabel.font = [UIFont systemFontOfSize:13];
        _carNumeberLabel.textAlignment =NSTextAlignmentCenter;
        _carNumeberLabel.textColor = [UIColor whiteColor];
        [_carNumeberLabel.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_carNumeberLabel.layer setCornerRadius:3];
        [_carNumeberLabel.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [_carNumeberLabel.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        
        [self.yingYView addSubview:_carNumeberLabel];
        [_carNumeberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.xuanZhongBt.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(self.yingYView);
            make.width.mas_equalTo(80);
        }];
        
        
        UIView *beijingView = [[UIView alloc]init];
        beijingView.backgroundColor = [UIColor blueColor];
        [self.yingYView addSubview:beijingView];
        [beijingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carNumeberLabel.mas_left).mas_equalTo(-5);
            make.right.mas_equalTo(self.carNumeberLabel.mas_right).mas_equalTo(5);
            make.top.mas_equalTo(self.carNumeberLabel.mas_top).mas_equalTo(-5);
            make.bottom.mas_equalTo(self.carNumeberLabel.mas_bottom).mas_equalTo(5);
        }];
        
        [self.yingYView bringSubviewToFront:_carNumeberLabel];
        
    }
    return _carNumeberLabel;
}


@end
