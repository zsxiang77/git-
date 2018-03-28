//
//  AITListCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITListCell.h"


@implementation AITListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
        UIView *mainBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 127/2)];
        mainBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:mainBackView];
        
        self.numberLabel = [[UILabel alloc]init];
        self.numberLabel.adjustsFontSizeToFitWidth = YES;
        [mainBackView addSubview:self.numberLabel];
        self.numberLabel.backgroundColor = kRGBColor(255, 197, 0);
        self.numberLabel.textColor = [UIColor whiteColor];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.font = [UIFont systemFontOfSize:26];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(30);
        }];
        
        for (int i = 0; i<2; i++) {
            UILabel *la1 = [[UILabel alloc]init];
            la1.font = [UIFont systemFontOfSize:14];
            la1.textColor = [UIColor grayColor];
            [mainBackView addSubview:la1];
            [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.numberLabel.mas_right).mas_equalTo(5);
                make.top.mas_equalTo(i*127/4);
                make.height.mas_equalTo(127/4);
            }];
            if (i == 0) {
                la1.text = @"序列号";
                self.serialLabel = [[UILabel alloc]init];
                self.serialLabel.font = [UIFont systemFontOfSize:14];
                [mainBackView addSubview:self.serialLabel];
                [self.serialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(la1.mas_right).mas_equalTo(10);
                    make.top.mas_equalTo(i*127/4);
                    make.height.mas_equalTo(127/4);
                }];
            }else{
                la1.text = @"验证码";
                self.verifyLabel = [[UILabel alloc]init];
                self.verifyLabel.font = [UIFont systemFontOfSize:14];
                [mainBackView addSubview:self.verifyLabel];
                [self.verifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(la1.mas_right).mas_equalTo(10);
                    make.top.mas_equalTo(i*127/4);
                    make.height.mas_equalTo(127/4);
                }];
            }
        }
        
        
    }
    return self;
}

@end
