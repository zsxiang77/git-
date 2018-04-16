//
//  XiMeiNewOrdersErCell1.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErCell1.h"
#import "CheDianZhangCommon.h"

@implementation XiMeiNewOrdersErCell1


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.zuoLabel = [[UILabel alloc]init];
        self.zuoLabel.textColor = [UIColor grayColor];
        self.zuoLabel.numberOfLines = 0;
        self.zuoLabel.font= [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.zuoLabel];
        [self.zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-100);
        }];
        
        self.youLabel = [[UILabel alloc]init];
        self.youLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.youLabel];
        [self.youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}

@end
