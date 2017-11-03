//
//  TheWorkbenchCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/31.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchCell.h"
#import "CheDianZhangCommon.h"

#define kDELEBTWHIGHT  (60)

@implementation TheWorkbenchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW+kDELEBTWHIGHT, 80)];
        [self.contentView addSubview:self.backView];
        
        self.shanChuBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW, 0, kDELEBTWHIGHT, 80)];
        [self.shanChuBt addTarget:self action:@selector(shanChuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        self.shanChuBt.backgroundColor = [UIColor redColor];
        [self.shanChuBt setTitle:@"删除" forState:(UIControlStateNormal)];
        [self.shanChuBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.backView addSubview:self.shanChuBt];
        
        self.biXianShiAnniu = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-30, 0, 30, 80)];
        [self.biXianShiAnniu addTarget:self action:@selector(biXianShiAnniuChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.biXianShiAnniu setImage:DJImageNamed(@"found") forState:(UIControlStateNormal)];
        self.biXianShiAnniu.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 5);
        [self.backView addSubview:self.biXianShiAnniu];
        
        
        UIView *chePaiV = [[UIView alloc]init];
        chePaiV.backgroundColor = [UIColor blueColor];
        [self.backView addSubview:chePaiV];
        [chePaiV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(7.5);
        }];
        self.topCarNumberLa = [[UILabel alloc]init];
        self.topCarNumberLa.textColor = [UIColor whiteColor];
        self.topCarNumberLa.font = [UIFont systemFontOfSize:14];
        self.topCarNumberLa.textAlignment = NSTextAlignmentCenter;
        [self.topCarNumberLa.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [self.topCarNumberLa.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [self.topCarNumberLa.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [chePaiV addSubview:self.topCarNumberLa];
        [self.topCarNumberLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(3);
            make.right.bottom.mas_equalTo(-3);
        }];
        
        self.youShangImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"number_back")];
        [chePaiV addSubview:self.youShangImageView];
        [self.youShangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(chePaiV);
            make.left.mas_equalTo(chePaiV.mas_left).mas_equalTo(-3);
            make.width.mas_equalTo(39/2);
            make.height.mas_equalTo(33/2);
        }];
        self.youShangLabel = [[UILabel alloc]init];
        self.youShangLabel.adjustsFontSizeToFitWidth = YES;
        self.youShangLabel.font = [UIFont systemFontOfSize:12];
        self.youShangLabel.textColor = [UIColor whiteColor];
        [chePaiV addSubview:self.youShangLabel];
        [self.youShangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(chePaiV);
            make.left.mas_equalTo(chePaiV);
            make.width.mas_equalTo(18);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        self.nameLabel.textColor = kNavBarColor;
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self.backView addSubview:self.nameLabel];
        [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chePaiV.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(chePaiV);
            make.right.mas_equalTo(-135);
        }];
        
        self.topMianImageView = [[UIImageView alloc]init];
        [self.backView addSubview:self.topMianImageView];
        [self.topMianImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-7.5);
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(25);
        }];
        self.topShuoMLabel = [[UILabel alloc]init];
        self.topShuoMLabel.numberOfLines = 0;
        self.topShuoMLabel.textColor = kNavBarColor;
        self.topShuoMLabel.font = [UIFont systemFontOfSize:13];
        [self.backView addSubview:self.topShuoMLabel];
        [self.topShuoMLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topMianImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.topMianImageView);
            make.right.mas_equalTo(-165);
        }];
        
        self.topStateLabel = [[UILabel alloc]init];
        self.topStateLabel.font = [UIFont systemFontOfSize:13];
        self.topStateLabel.textColor = [UIColor orangeColor];
        [self.backView addSubview:self.topStateLabel];
        [self.topStateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-80);
            make.top.mas_equalTo(10);
        }];
        
        self.stateImageView = [[UIImageView alloc]init];
        [self.backView addSubview:self.stateImageView];
        [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.topStateLabel);
            make.right.mas_equalTo(self.topStateLabel.mas_left).mas_equalTo(-7);
            make.width.height.mas_equalTo(15);
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.backView addSubview:self.timeLabel];
        [self.timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-80);
            make.bottom.mas_equalTo(-14);
        }];
        
        self.suoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"yiSuoDan")];
        [self.backView addSubview:self.suoImageView];
        [self.suoImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-80);
            make.bottom.mas_equalTo(-14);
            make.width.mas_equalTo(104/2);
            make.height.mas_equalTo(55/2);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

-(void)shanChuBtChick:(UIButton *)sender
{
    self.shanChuBlock(self.zhuModel);
}

-(void)biXianShiAnniuChick:(UIButton *)sender
{
    if (self.shiFouKeShan == NO) {
        return;
    }
    
    self.biXianShiAnniuBlock(self.zhuModel);
}

-(void)refeleseWithModel:(TheWorkModel *)model WithShiFouKeShan:(BOOL)shan
{
    self.zhuModel = model;
    self.shiFouKeShan = shan;
    if (shan == NO) {
        self.backView.frame = CGRectMake(0, 0, kWindowW+kDELEBTWHIGHT, 80);
        self.biXianShiAnniu.hidden = YES;
    }else
    {
        if (model.shanChuState == YES) {
            self.backView.frame = CGRectMake(-kDELEBTWHIGHT, 0, kWindowW+kDELEBTWHIGHT, 80);
        }else
        {
            self.backView.frame = CGRectMake(0, 0, kWindowW+kDELEBTWHIGHT, 80);
        }
        self.biXianShiAnniu.hidden = NO;
    }
    
    self.topCarNumberLa.text = model.car_number;
    [self.topMianImageView  sd_setImageWithURL:[NSURL URLWithString:model.brand_img] placeholderImage:DJImageNamed(@"xiangMuBack")];
    
    
    self.topShuoMLabel.text = model.cars_spec;
    if ([model.class_name isEqualToString:@"维修"]) {
        self.nameLabel.hidden = YES;
    }else
    {
        self.nameLabel.hidden = NO;
    }
    self.nameLabel.text = model.service;
    self.topStateLabel.text = model.status;
    if ([model.status isEqualToString:@"待施工"]) {
        self.topStateLabel.textColor = kRGBColor(253, 183, 46);
        self.stateImageView.image = DJImageNamed(@"waiting_repair");
    }else if ([model.status isEqualToString:@"待结算"]) {
        self.topStateLabel.textColor = kRGBColor(114, 183, 95);
        self.stateImageView.image = DJImageNamed(@"waiting_statement");
    }
    self.timeLabel.text = model.add_time;
    if (model.is_lock == 1) {
        self.suoImageView.hidden = NO;
    }else
    {
        self.suoImageView.hidden = YES;
    }
    
    if ([model.queue_id integerValue]>0) {
        self.youShangLabel.hidden = NO;
        self.youShangImageView.hidden = NO;
        self.youShangLabel.text = model.queue_id;
    }else
    {
        self.youShangLabel.hidden = YES;
        self.youShangImageView.hidden = YES;
    }
}

@end
