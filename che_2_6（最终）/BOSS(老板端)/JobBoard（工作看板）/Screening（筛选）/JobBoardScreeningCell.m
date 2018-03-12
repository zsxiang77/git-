//
//  JobBoardScreeningCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardScreeningCell.h"
#import "BOSSCheDianZhangCommon.h"

@implementation JobBoardScreeningCell

-(UIImageView *)mianImageView
{
    if (!_mianImageView) {
        _mianImageView = [[UIImageView  alloc]init];
        [self.contentView addSubview:_mianImageView];
        [_mianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(20);
            make.width.height.mas_equalTo(22);
        }];
    }
    return _mianImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = kRGBColor(74, 74, 74);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.mianImageView.mas_bottom).mas_equalTo(10);
        }];
    }
    return _titleLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:17];
        _numberLabel.textColor = kRGBColor(208, 2, 27);
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(0);
        }];
    }
    return _numberLabel;
}

-(UILabel *)line1
{
    if (!_line1) {
        _line1 = [[UILabel alloc]init];
        _line1.backgroundColor = kLineBgColor;
        [self.contentView addSubview:_line1];
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.top.mas_equalTo(0);
            make.width.mas_equalTo(1);
        }];
    }
    return _line1;
}
-(UILabel *)line2
{
    if (!_line2) {
        _line2 = [[UILabel alloc]init];
        _line2.backgroundColor = kLineBgColor;
        [self.contentView addSubview:_line2];
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(-2);
            make.height.mas_equalTo(1);
        }];
    }
    return _line2;
}


/**
 task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
 9:工单回访 10:全部任务
 */
-(void)refilshData:(NSDictionary *)dict
{
    self.line1.hidden = NO;
    self.line2.hidden = NO;
    NSInteger task_type = [KISDictionaryHaveKey(dict, @"task_type") integerValue];
    if (task_type == 0) {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_LIuShi");
    }else if (task_type == 1)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_YiChang");
    }else if (task_type == 2)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_ChaPing");
    }else if (task_type == 3)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_YuYue");
    }else if (task_type == 4)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_baoYang");
    }else if (task_type == 5)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_baoXian");
    }else if (task_type == 6)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_NianJian");
    }else if (task_type == 7)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_shengRi");
    }else if (task_type == 8)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_xunJia");
    }else if (task_type == 9)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_gongDan");
    }else if (task_type == 10)
    {
        self.mianImageView.image = DJImageNamed(@"Boss_jopHeader_QuanBu");
    }else{
        self.mianImageView.image = DJImageNamed(@"");
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    self.numberLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"count")];
}


@end
