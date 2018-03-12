//
//  OrderDetailAccessoriesCell1.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailAccessoriesCell1.h"

@implementation OrderDetailAccessoriesCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *line1 = [[UILabel alloc]init];
        line1.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = kRGBColor(51, 51, 51);
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
        }];
        
        
        UIView *gongShiView = [[UIView alloc]init];
        [gongShiView.layer setMasksToBounds:YES];
        [gongShiView.layer setCornerRadius:4];
        [gongShiView.layer setBorderColor:kLineBgColor.CGColor];
        [gongShiView.layer setBorderWidth:1];
        [self.contentView addSubview:gongShiView];
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
        
        gongShiTextField = [[UITextField alloc]init];
        [gongShiTextField addTarget:self action:@selector(gongShiTextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
        gongShiTextField.textAlignment = NSTextAlignmentCenter;
        gongShiFeiTextField.returnKeyType = UIReturnKeyDone;
        gongShiTextField.delegate = self;
        [gongShiView addSubview:gongShiTextField];
        [gongShiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(jianBt.mas_right);
            make.right.mas_equalTo(jiaBt.mas_left);
        }];
        
        gongShiFeiTextField = [[UITextField alloc]init];
        gongShiFeiTextField.returnKeyType = UIReturnKeyDone;
        [gongShiFeiTextField addTarget:self action:@selector(gongShiFeiTextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
        gongShiFeiTextField.delegate = self;
        gongShiFeiTextField.font = [UIFont systemFontOfSize:15];
        gongShiFeiTextField.textColor = kRGBColor(255, 0, 31);
        gongShiFeiTextField.textAlignment = NSTextAlignmentCenter;
        [gongShiFeiTextField.layer setMasksToBounds:YES];
        [gongShiFeiTextField.layer setCornerRadius:4];
        [gongShiFeiTextField.layer setBorderColor:kLineBgColor.CGColor];
        [gongShiFeiTextField.layer setBorderWidth:1];
        [self.contentView addSubview:gongShiFeiTextField];
        [gongShiFeiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
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
        [self.contentView addSubview:qianL];
        [qianL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(gongShiFeiTextField.mas_centerY);
            make.right.mas_equalTo(gongShiFeiTextField.mas_left).mas_equalTo(-3);
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
        [self.contentView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(32);
        }];
        
        bianHaoLabel = [[UILabel alloc]init];
        bianHaoLabel.font = [UIFont systemFontOfSize:12];
        bianHaoLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:bianHaoLabel];
        [bianHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-97/2);
        }];
        
        kuCunLabel = [[UILabel alloc]init];
        kuCunLabel.font = [UIFont systemFontOfSize:12];
        kuCunLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:kuCunLabel];
        [kuCunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(150);
            make.bottom.mas_equalTo(-97/2);
        }];
        
        danWeiLabel = [[UILabel alloc]init];
        danWeiLabel.font = [UIFont systemFontOfSize:12];
        danWeiLabel.textColor = kRGBColor(133, 133, 133);
        [self.contentView addSubview:danWeiLabel];
        [danWeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kuCunLabel.mas_right).mas_equalTo(40);
            make.bottom.mas_equalTo(-97/2);
        }];
        
    }
    return self;
}

-(void)gongShiTextFieldChange:(UITextField *)sender
{
    self.model.parts_num = sender.text;
}
-(void)gongShiFeiTextFieldChange:(UITextField *)sender
{
    self.model.parts_fee = sender.text;
}
-(void)jianBtChick:(UIButton *)sender
{
    if ([self.model.parts_num floatValue]<=1) {
        return;
    }
    self.model.parts_num = [NSString stringWithFormat:@"%.1f",[self.model.parts_num floatValue]-1];
    self.baoCunChcickBlock();
}
-(void)jiaBtChick:(UIButton *)sender
{
    self.model.parts_num = [NSString stringWithFormat:@"%.1f",[self.model.parts_num floatValue]+1];
    self.baoCunChcickBlock();
}

-(void)baoCunChick:(UIButton *)sender
{
    [gongShiTextField resignFirstResponder];
    [gongShiFeiTextField resignFirstResponder];
    self.model.shiFouBianJi = !self.model.shiFouBianJi;
    self.baoCunChcickBlock();
}

-(void)refeleseWithModel:(OrderDetailPartsModel *)model
{
    self.model = model;
    titleLabel.text = model.parts_name;
    bianHaoLabel.text = [NSString stringWithFormat:@"编号：%@",model.parts_id];
    kuCunLabel.text = [NSString stringWithFormat:@"库存：%@",model.count];
    danWeiLabel.text = [NSString stringWithFormat:@"单位：%@",model.unit];
    
    gongShiTextField.text = model.parts_num;
    gongShiFeiTextField.text = model.parts_fee;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [gongShiTextField resignFirstResponder];
        [gongShiFeiTextField resignFirstResponder];
        
        return NO;
    }
    return YES;
}



@end
