//
//  TheWorkbenchNewCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchNewCell.h"
#import "CheDianZhangCommon.h"

@implementation TheWorkbenchNewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *chePaiV = [[UIView alloc]init];
        chePaiV.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:chePaiV];
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
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chePaiV.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(chePaiV);
            make.right.mas_equalTo(-80);
        }];
        
        self.topMianImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.topMianImageView];
        [self.topMianImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-7.5);
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(25);
        }];
        self.topShuoMLabel = [[UILabel alloc]init];
        self.topShuoMLabel.numberOfLines = 0;
        self.topShuoMLabel.textColor = kNavBarColor;
        self.topShuoMLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.topShuoMLabel];
        [self.topShuoMLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topMianImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.topMianImageView);
            make.right.mas_equalTo(-120);
        }];
        
        
        
        
        self.topStateLabel = [[UILabel alloc]init];
        self.topStateLabel.font = [UIFont systemFontOfSize:13];
        self.topStateLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:self.topStateLabel];
        [self.topStateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
        
        self.stateImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.stateImageView];
        [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.topStateLabel);
            make.right.mas_equalTo(self.topStateLabel.mas_left).mas_equalTo(-7);
            make.width.height.mas_equalTo(15);
        }];
        
        self.aitLabel = [[UILabel alloc]init];
        self.aitLabel.font = [UIFont systemFontOfSize:13];
        self.aitLabel.textColor = UIColorFromRGBA(0x63bcfe, 1);
        [self.contentView addSubview:self.aitLabel];
        [self.aitLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.topStateLabel.mas_bottom).mas_equalTo(3);
        }];
        
        self.aitImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"01_youbaogao")];
        self.aitImageView.hidden = YES;
        [self.contentView addSubview:self.aitImageView];
        [self.aitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.aitLabel);
            make.right.mas_equalTo(self.aitLabel.mas_left).mas_equalTo(-7);
            make.width.height.mas_equalTo(15);
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-14);
        }];
        
        self.suoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"yiSuoDan")];
        [self.contentView addSubview:self.suoImageView];
        [self.suoImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(-14);
            make.width.mas_equalTo(104/2);
            make.height.mas_equalTo(55/2);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}


-(void)refeleseWithModel:(TheWorkModel *)model
{
    
    
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
    
    if (model.ait_report.length>0) {
        self.aitLabel.hidden = NO;
        self.aitLabel.text = model.ait_report;
        self.aitImageView.hidden = NO;
    }else{
        self.aitLabel.hidden = YES;
        self.aitImageView.hidden = YES;
    }
}

@end
