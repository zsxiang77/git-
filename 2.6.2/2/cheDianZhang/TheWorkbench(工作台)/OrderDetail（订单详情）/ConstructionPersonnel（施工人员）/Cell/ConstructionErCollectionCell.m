//
//  ConstructionErCollectionCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ConstructionErCollectionCell.h"

@implementation ConstructionErCollectionCell

-(UIImageView *)maiImageView
{
    if (!_maiImageView) {
        _maiImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"jigong")];
        [self.contentView addSubview:_maiImageView];
        [_maiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(10);
            make.width.height.mas_equalTo(kWindowW/4-40);
        }];
    }
    return _maiImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.maiImageView.mas_bottom).mas_equalTo(5);
        }];
    }
    return _titleLabel;
}

-(UIButton *)youShangBt
{
    if (!_youShangBt) {
        _youShangBt = [[UIButton alloc]init];
        _youShangBt.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_youShangBt setImage:DJImageNamed(@"ic_clear_image_normal") forState:(UIControlStateNormal)];
        [_youShangBt setImage:DJImageNamed(@"chengong") forState:(UIControlStateSelected)];
        [_youShangBt setUserInteractionEnabled:NO];
        
        [_youShangBt addTarget:self action:@selector(youShangBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_youShangBt];
        [_youShangBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.width.height.mas_equalTo(25);
        }];
    }
    return _youShangBt;
}

-(void)youShangBtChick:(UIButton *)sender
{
    self.shanChuBtBlock(self.zhuModel);
}


@end
