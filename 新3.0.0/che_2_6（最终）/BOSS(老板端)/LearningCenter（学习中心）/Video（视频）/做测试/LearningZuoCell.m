//
//  LearningZuoCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningZuoCell.h"

@implementation LearningZuoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        dianJiBt  = [[UIButton alloc]init];
       // dianJiBt.backgroundColor = [UIColor yellowColor];
        [dianJiBt setImage:[UIImage imageNamed:@"Boss_xuanZhong_no"] forState:UIControlStateNormal];
         [dianJiBt setImage:[UIImage imageNamed:@"Boss_xuanZhong"] forState:UIControlStateSelected];
        dianJiBt.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5,10);
        [dianJiBt addTarget:self action:@selector(dianJiChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:dianJiBt];
        [dianJiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(30);
        }];
        titleLabe = [[UILabel alloc]init];
        titleLabe.font = [UIFont systemFontOfSize:16];
        titleLabe.numberOfLines = 0;
        titleLabe.adjustsFontSizeToFitWidth = YES;
        titleLabe.textColor = kRGBColor(102, 102, 102);
        [self.contentView addSubview:titleLabe];
        [titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)dianJiChick:(UIButton *)sender
{
    self.dianJiChickBlock(m_model);
}
-(void)shuaXinData:(LearningZuoCeShiDaAnModel *)model
{
    m_model = model;
    dianJiBt.selected = model.shiFouXuanZhong;
    titleLabe.text = model.tiStr;
}

@end
