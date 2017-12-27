//
//  XiMeiNewOrdersErCell3.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErCell3.h"
#import "CheDianZhangCommon.h"

@implementation XiMeiNewOrdersErCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.zuoLabel = [[UILabel alloc]init];
        self.zuoLabel.textColor = [UIColor grayColor];
        self.zuoLabel.font= [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.zuoLabel];
        [self.zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        self.mainTextField = [[UITextField alloc]init];
        self.mainTextField.font = [UIFont systemFontOfSize:13];
        self.mainTextField.userInteractionEnabled = NO;
        [self.contentView addSubview:self.mainTextField];
        [self.mainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.bottom.top.mas_equalTo(0);
        }];
        
        NumberKeyboard *m_keyBoard2;
        m_keyBoard2 = [[NumberKeyboard alloc]init];
        m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
        m_keyBoard2.maxLength = 11;
        m_keyBoard2.myDelegate = self;
        m_keyBoard2.currentField = self.mainTextField;
        self.mainTextField.inputView = m_keyBoard2;
        
        self.youLabel = [[UILabel alloc]init];
        self.youLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.youLabel];
        [self.youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)fieldChangeing:(NumberKeyboard*) numKeyboard
{
    if (numKeyboard.currentField == self.mainTextField) {
        XiMeiNewOrdersErVC *vc = (XiMeiNewOrdersErVC *)self.superViewColler;
        CGFloat qian = [self.mainTextField.text floatValue];
        NSString *qianStr = [NSString stringWithFormat:@"%.2f",qian];
        self.model.price = qianStr;
        [vc jiSuanZongEQian];
    }
}

@end
