//
//  TianRuXXCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TianRuXXCell.h"

@implementation TianRuXXCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.zuoLabel = [[UILabel alloc]init];
        self.zuoLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.zuoLabel];
        [self.zuoLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.youTextField = [[UITextField alloc]init];
        self.youTextField.textAlignment = NSTextAlignmentRight;
        self.youTextField.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.youTextField];
        [self.youTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(100);
            make.top.bottom.mas_equalTo(0);
        }];
        
        self.line = [[UILabel alloc]init];
        self.line.backgroundColor = kLineBgColor;
        [self.contentView addSubview:self.line];
        [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

@end
