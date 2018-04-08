//
//  HaoCaiTableViewCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "HaoCaiTableViewCell.h"

@implementation HaoCaiTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor  = kRGBColor(51, 51, 51);
        titleLabel.numberOfLines = 0;
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
        }];
        
        UILabel *label3 = [[UILabel alloc]init];
        label3.textColor = kRGBColor(133, 133, 133);
        label3.text = @"配件编码：";
        label3.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(50);
        }];
        
        bianmaFeiLabel = [[UILabel alloc]init];
        bianmaFeiLabel.textColor = kRGBColor(133, 133, 133);
        bianmaFeiLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:bianmaFeiLabel];
        [bianmaFeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label3.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label3);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.textColor = kRGBColor(133, 133, 133);
        label1.text = @"属性：";
        label1.font = [UIFont systemFontOfSize:12];
        [backView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bianmaFeiLabel.mas_right).mas_equalTo(21);
            make.centerY.mas_equalTo(bianmaFeiLabel);
        }];
        
        shuxingLabel = [[UILabel alloc]init];
        shuxingLabel.textColor = kRGBColor(133, 133, 133);
        shuxingLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:shuxingLabel];
        [shuxingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label1.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(label1);
        }];
        
        
        danweiLable = [[UILabel alloc]init];
        danweiLable.textColor = kRGBColor(133, 133, 133);
        danweiLable.font = [UIFont systemFontOfSize:12];
        [backView addSubview:danweiLable];
        [danweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(shuxingLabel.mas_right).mas_equalTo(2);
            make.centerY.mas_equalTo(shuxingLabel);
        }];
        
        
        UIView *gongShiView = [[UIView alloc]init];
        [gongShiView.layer setMasksToBounds:YES];
        [gongShiView.layer setCornerRadius:4];
        [gongShiView.layer setBorderColor:kLineBgColor.CGColor];
        [gongShiView.layer setBorderWidth:1];
        [backView addSubview:gongShiView];
        [gongShiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(32);
        }];
        
        UIButton *jianBt = [[UIButton alloc]init];
        jianBt.backgroundColor = kRGBColor(240, 240, 240);
        [jianBt addTarget:self action:@selector(jianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        jianBt.titleLabel.font = [UIFont systemFontOfSize:17];
        [jianBt setTitleColor:kRGBColor(132, 132, 132) forState:(UIControlStateNormal)];
        [jianBt setTitle:@"-" forState:(UIControlStateNormal)];
        [gongShiView addSubview:jianBt];
        [jianBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(30);
        }];
        
        UIButton *jiaBt = [[UIButton alloc]init];
        jiaBt.backgroundColor = kRGBColor(240, 240, 240);
        [jiaBt addTarget:self action:@selector(jiaBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        jiaBt.titleLabel.font = [UIFont systemFontOfSize:17];
        [jiaBt setTitleColor:kRGBColor(132, 132, 132) forState:(UIControlStateNormal)];
        [jiaBt setTitle:@"+" forState:(UIControlStateNormal)];
        [gongShiView addSubview:jiaBt];
        [jiaBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(30);
        }];
        
        shuliangTextBt = [[UIButton alloc]init];
        shuliangTextBt.titleLabel.font = [UIFont systemFontOfSize:13];
        [shuliangTextBt addTarget:self action:@selector(gongShiTextBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [shuliangTextBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [gongShiView addSubview:shuliangTextBt];
        [shuliangTextBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(jianBt.mas_right);
            make.right.mas_equalTo(jiaBt.mas_left);
        }];
        
        jiageTextBt = [[UIButton alloc]init];
        jiageTextBt.titleLabel.font=[UIFont systemFontOfSize:13];
        [jiageTextBt addTarget:self action:@selector(gongShiFeiTextFieldChange:) forControlEvents:(UIControlEventTouchUpInside)];
        //        gongShiFeiTextBt.returnKeyType = UIReturnKeyDone;
        //        [gongShiFeiTextBt addTarget:self action:@selector(gongShiFeiTextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
        //        gongShiFeiTextBt.delegate = self;
        //        gongShiFeiTextBt.font = [UIFont systemFontOfSize:15];
        [jiageTextBt setTitleColor:kRGBColor(255, 0, 31) forState:(UIControlStateNormal)];
        // gongShiFeiTextBt.textColor = kRGBColor(255, 0, 31);
        //  gongShiFeiTextBt.textAlignment = NSTextAlignmentCenter;
        [jiageTextBt.layer setMasksToBounds:YES];
        [jiageTextBt.layer setCornerRadius:4];
        [jiageTextBt.layer setBorderColor:kLineBgColor.CGColor];
        [jiageTextBt.layer setBorderWidth:1];
        [self.contentView addSubview:jiageTextBt];
        [jiageTextBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(125);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(32);
        }];
        
        
        
        UILabel *qianL = [[UILabel alloc]init];
        qianL.text = @"¥";
        qianL.textAlignment = NSTextAlignmentRight;
        qianL.font = [UIFont systemFontOfSize:12];
        qianL.textColor = kRGBColor(255, 0, 31);
        [backView addSubview:qianL];
        [qianL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(jiageTextBt.mas_centerY);
            make.right.mas_equalTo(jiageTextBt.mas_left).mas_equalTo(-3);
            make.width.mas_equalTo(20);
        }];
        
        
        UIButton *bt = [[UIButton alloc]init];
        bt.backgroundColor = kZhuTiColor;
        [bt addTarget:self action:@selector(baoCunChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [bt.layer setMasksToBounds:YES];
        [bt.layer setCornerRadius:4];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt setTitle:@"保存" forState:(UIControlStateNormal)];
        [bt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [backView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(32);
        }];
        
    }
    return self;
}
-(void)gongShiFeiTextFieldChange:(UIButton *)sender
{
        self.jiageTextBtnField(self.model);
}
-(void)gongShiTextBtChick:(UIButton *)sender
{
        self.shuliangTextBtChickBlock(self.model);
   
}

-(void)jianBtChick:(UIButton *)sender
{
    if ([self.model.count floatValue]<=1) {
        return;
    }
    self.model.count = [NSString stringWithFormat:@"%.1f",[self.model.count floatValue]-1];
    self.baoCunChcickBlock();
}
-(void)jiaBtChick:(UIButton *)sender
{
    self.model.count = [NSString stringWithFormat:@"%.1f",[self.model.count floatValue]+1];
    self.baoCunChcickBlock();
}

-(void)baoCunChick:(UIButton *)sender
{
    self.model.shiFouKeShan = !self.model.shiFouKeShan;
    self.baoCunChcickBlock();
}


-(void)refeleseWithModel:(Service_commods *)model
{
    self.model = model;
    titleLabel.text = model.name;
    [shuliangTextBt setTitle: model.count forState:(UIControlStateNormal)];
    [jiageTextBt setTitle:model.price forState:(UIControlStateNormal)];
    shuxingLabel.text = [NSString stringWithFormat:@"%@",model.sku_properties];
    bianmaFeiLabel.text = [NSString stringWithFormat:@"%@",model.commodity_id];
    danweiLable.text = [NSString stringWithFormat:@"单位：%@",model.unit];
}
@end
