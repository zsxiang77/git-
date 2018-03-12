//
//  XiMeiNewOrdersErCell4.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErCell4.h"
#import "CheDianZhangCommon.h"


@implementation XiMeiNewOrdersErCell4

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.zuoLabel = [[UILabel alloc]init];
        self.zuoLabel.textColor = [UIColor grayColor];
        self.zuoLabel.font= [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.zuoLabel];
        [self.zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        self.jiaButton = [[UIButton alloc]init];
        [self.jiaButton  addTarget:self action:@selector(jiaButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.jiaButton setImage:DJImageNamed(@"add_item_info.jpg") forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.jiaButton];
        [self.jiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(25);
        }];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.jiaButton.mas_left).mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentView);
        }];
        UIButton *shuLiangBt = [[UIButton alloc]init];
        [shuLiangBt addTarget:self action:@selector(shuLiangBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:shuLiangBt];
        [shuLiangBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self.titleLabel.mas_right);
            make.top.bottom.mas_equalTo(0);
        }];
        
        self.jianButton = [[UIButton alloc]init];
        [self.jianButton  addTarget:self action:@selector(jianButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.jianButton setImage:DJImageNamed(@"del_item_info.jpg") forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.jianButton];
        [self.jianButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.titleLabel.mas_left).mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(25);
        }];
    }
    return self;
}


-(void)jiaButtonChick:(UIButton *)sender
{
    
    CGFloat count = [self.model.count floatValue];
    if (count>= [self.model.current_count floatValue]) {
        return;
    }
    if (self.model.shiFouKeShan == YES) {
    count ++;
    }
    self.model.count = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",count]];
    
    self.jiaHuoJianDianJiBlock();
}

-(void)jianButtonChick:(UIButton *)sender
{
    CGFloat count = [self.model.count floatValue];
    if (count<=0) {
        return;
    }
    if (self.model.shiFouKeShan == YES) {
        count --;
    }
    self.model.count = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",count]];
    
    self.jiaHuoJianDianJiBlock();
}
-(void)shuLiangBtChick:(UIButton *)sender
{
    self.shuLiangXiuGai(self.model);
}

@end
