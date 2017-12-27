//
//  ModelCarReMenCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ModelCarReMenCell.h"

@implementation ModelCarReMenCell

- (void) refleshTableCellWith:(NSArray *)array
{
    [[self.contentView.subviews lastObject] removeFromSuperview];
    
    for (int i = 0; i<array.count; i++) {
        ErMenModel *model = array[i];
        UIView *buJuView = [[UIView alloc]init];
        [self.contentView addSubview:buJuView];
        [buJuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(((kWindowW-10)/5)*i);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo((kWindowW-10)/5);
        }];
        
        UIImageView *im = [[UIImageView alloc]init];
        [buJuView addSubview:im];
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo((kWindowW-10)/5-20);
        }];
        [im  sd_setImageWithURL:[NSURL URLWithString:model.imges] placeholderImage:DJImageNamed(@"xiangMuBack")];
        
        
        UILabel *la = [[UILabel alloc]init];
        la.textColor = [UIColor blackColor];
        la.text = model.name;
        [buJuView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(buJuView);
            make.top.mas_equalTo(im.mas_bottom).mas_equalTo(5);
        }];
        
        UIButton *dianJiBT =[[UIButton alloc]init];
        dianJiBT.tag = 3000+i;
        [dianJiBT addTarget:self action:@selector(dianJiBTChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [buJuView addSubview:dianJiBT];
        [dianJiBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
}

-(void)dianJiBTChick:(UIButton *)sender
{
    NSInteger index = sender.tag - 3000;
    self.userDianJiTiaoZhuan(self.tiaozhuanArray[index]);
}

@end
