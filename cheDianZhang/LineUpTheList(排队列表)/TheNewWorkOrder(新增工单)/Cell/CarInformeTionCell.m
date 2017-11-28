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

-(UIView *)shangView
{
    if (!_shangView) {
        _shangView  = [[UIView alloc]init];
        [self.yingYView addSubview:_shangView];
        [_shangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
            make.top.left.right.mas_equalTo(0);
        }];
    }
    return _shangView;
}

-(UIImageView *)xuanZhongBt
{
    if (!_xuanZhongBt) {
        _xuanZhongBt = [[UIImageView alloc]init];
        
        [self.shangView addSubview:_xuanZhongBt];
        [_xuanZhongBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.shangView);
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
        [self.shangView addSubview:_cheColorLabel];
        [_cheColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(135);
            make.centerY.mas_equalTo(self.carNumeberLabel);
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
        [self.shangView addSubview:_colorLabel];
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(130+100);
            make.centerY.mas_equalTo(self.carNumeberLabel);
        }];
        
    }
    return _colorLabel;
}

-(UIButton *)shanChuButton
{
    if (!_shanChuButton) {
        _shanChuButton = [[UIButton alloc]init];
        [self.shangView addSubview:_shanChuButton];
        [_shanChuButton addTarget:self action:@selector(shanChuButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_shanChuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.shangView);
            make.width.height.mas_equalTo(30);
        }];
    }
    return _shanChuButton;
}

-(void)shanChuButtonChick:(UIButton *)sender
{
    self.shanChuButtonBlock(self.chuLiModel);
}

-(UIView *)xiaView
{
    if (!_xiaView) {
        _xiaView = [[UIView alloc]init];
        [self.yingYView addSubview:_xiaView];
        [_xiaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        _xiaView.hidden = YES;
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [_xiaView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *zuoLai = [[UILabel alloc]init];
        zuoLai.font = [UIFont systemFontOfSize:14];
        zuoLai.textColor = [UIColor grayColor];
        zuoLai.text = @"AIT检测报告";
        [_xiaView addSubview:zuoLai];
        [zuoLai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.xiaView);
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"ait_tiaoZhuan")];
        [_xiaView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.xiaView);
            make.width.mas_equalTo(19/2);
            make.height.mas_equalTo(((19/2)*33)/19);
        }];
        
        UILabel *rightLabel = [[UILabel alloc]init];
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = [UIColor orangeColor];
        rightLabel.text = @"该车型可使用AIT产品检测";
        [_xiaView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightImageView.mas_left).mas_equalTo(-5);
            make.centerY.mas_equalTo(self.xiaView);
        }];
        
        UIButton *bt = [[UIButton alloc]init];
        [bt addTarget:self action:@selector(tiaoZHuanAitChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_xiaView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _xiaView;
}

-(void)tiaoZHuanAitChick:(UIButton *)sender
{
    self.tiaoZhuanAitBlock();
}

//-(UILabel *)tiShiLabel
//{
//    if (!_tiShiLabel) {
//        _tiShiLabel = [[UILabel alloc]init];
//        _tiShiLabel.numberOfLines = 0;
//        _tiShiLabel.font = [UIFont systemFontOfSize:13];
//        _tiShiLabel.textColor = [UIColor redColor];
//        [self.yingYView addSubview:_tiShiLabel];
//        [_tiShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.carNumeberLabel);
//            make.right.mas_equalTo(-50);
//            make.top.mas_equalTo(self.carNumeberLabel.mas_bottom).mas_equalTo(15);
//        }];
//    }
//    return _tiShiLabel;
//}

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
        
        [self.shangView addSubview:_carNumeberLabel];
        [_carNumeberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.xuanZhongBt.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(self.shangView);
            make.width.mas_equalTo(80);
        }];
        
        
        UIView *beijingView = [[UIView alloc]init];
        beijingView.backgroundColor = [UIColor blueColor];
        [self.shangView addSubview:beijingView];
        [beijingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carNumeberLabel.mas_left).mas_equalTo(-5);
            make.right.mas_equalTo(self.carNumeberLabel.mas_right).mas_equalTo(5);
            make.top.mas_equalTo(self.carNumeberLabel.mas_top).mas_equalTo(-5);
            make.bottom.mas_equalTo(self.carNumeberLabel.mas_bottom).mas_equalTo(5);
        }];
        
        [self.shangView bringSubviewToFront:_carNumeberLabel];
        
    }
    return _carNumeberLabel;
}


@end
