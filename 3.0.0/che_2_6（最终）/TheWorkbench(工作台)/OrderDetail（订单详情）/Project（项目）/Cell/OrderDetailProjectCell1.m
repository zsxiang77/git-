//
//  OrderDetailProjectCell1.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailProjectCell1.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailProjectCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
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
        
        gongShiTextBt = [[UIButton alloc]init];
        gongShiTextBt.titleLabel.font = [UIFont systemFontOfSize:13];
        [gongShiTextBt addTarget:self action:@selector(gongShiTextBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [gongShiTextBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [gongShiView addSubview:gongShiTextBt];
        [gongShiTextBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(jianBt.mas_right);
            make.right.mas_equalTo(jiaBt.mas_left);
        }];
        
        gongShiFeiTextBt = [[UIButton alloc]init];
        gongShiFeiTextBt.titleLabel.font=[UIFont systemFontOfSize:13];
        [gongShiFeiTextBt addTarget:self action:@selector(gongShiFeiTextFieldChange:) forControlEvents:(UIControlEventTouchUpInside)];
        //        gongShiFeiTextBt.returnKeyType = UIReturnKeyDone;
        //        [gongShiFeiTextBt addTarget:self action:@selector(gongShiFeiTextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
        //        gongShiFeiTextBt.delegate = self;
        //        gongShiFeiTextBt.font = [UIFont systemFontOfSize:15];
        [gongShiFeiTextBt setTitleColor:kRGBColor(255, 0, 31) forState:(UIControlStateNormal)];
        // gongShiFeiTextBt.textColor = kRGBColor(255, 0, 31);
        //  gongShiFeiTextBt.textAlignment = NSTextAlignmentCenter;
        [gongShiFeiTextBt.layer setMasksToBounds:YES];
        [gongShiFeiTextBt.layer setCornerRadius:4];
        [gongShiFeiTextBt.layer setBorderColor:kLineBgColor.CGColor];
        [gongShiFeiTextBt.layer setBorderWidth:1];
        [self.contentView addSubview:gongShiFeiTextBt];
        [gongShiFeiTextBt mas_makeConstraints:^(MASConstraintMaker *make) {
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
            make.centerY.mas_equalTo(gongShiFeiTextBt.mas_centerY);
            make.right.mas_equalTo(gongShiFeiTextBt.mas_left).mas_equalTo(-3);
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

//-(void)gongShiTextFieldChange:(UITextField *)sender
//{
//    self.model.hour = sender.text;
//}
-(void)gongShiFeiTextFieldChange:(UIButton *)sender
{
    //self.model.parts_fee = sender.text;
    self.gongShiTextBtnField();
}
-(void)gongShiTextBtChick:(UIButton *)sender
{
    self.gongShiTextBtChickBlock();
}

-(void)jianBtChick:(UIButton *)sender
{
    if ([self.model.hour floatValue]<=1) {
        return;
    }
    self.model.hour = [NSString stringWithFormat:@"%.1f",[self.model.hour floatValue]-1];
    self.baoCunChcickBlock();
}
-(void)jiaBtChick:(UIButton *)sender
{
    self.model.hour = [NSString stringWithFormat:@"%.1f",[self.model.hour floatValue]+1];
    self.baoCunChcickBlock();
}

-(void)baoCunChick:(UIButton *)sender
{
    [gongShiTextBt resignFirstResponder];
    [gongShiFeiTextBt resignFirstResponder];
    self.model.shiFouBianJi = !self.model.shiFouBianJi;
    self.baoCunChcickBlock();
}


-(void)refeleseWithModel:(OrderDetailSubjectsModel *)model
{
    self.model = model;
    titleLabel.text = model.name;
    [gongShiTextBt setTitle: model.hour forState:(UIControlStateNormal)];
    [gongShiFeiTextBt setTitle:model.reality_fee forState:(UIControlStateNormal)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [gongShiTextBt resignFirstResponder];
        [gongShiFeiTextBt resignFirstResponder];
        
        return NO;
    }
    return YES;
}
@end
