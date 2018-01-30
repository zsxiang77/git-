//
//  FillInforMationErCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillInforMationErCell.h"
#import "CheDianZhangCommon.h"

@implementation FillInforMationErCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.zuoTitelLabel = [[UILabel alloc]init];
        self.zuoTitelLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.zuoTitelLabel];
        [self.zuoTitelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.xuanZhongImaheView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.xuanZhongImaheView];
        [self.xuanZhongImaheView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
    }
    return self;
}

@end
