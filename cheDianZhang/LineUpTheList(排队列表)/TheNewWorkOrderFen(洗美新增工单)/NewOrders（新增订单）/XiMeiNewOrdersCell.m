//
//  XiMeiNewOrdersCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersCell.h"
#import "Masonry.h"
#import "CheDianZhangCommon.h"

@implementation XiMeiNewOrdersCell
- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        float imageW = kWindowW*(60/414.0);
        _lotteryImage = [[UIImageView alloc] init];
        [_lotteryImage.layer setMasksToBounds:YES];
        [_lotteryImage.layer setCornerRadius:3];
        _lotteryImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_lotteryImage];
        [_lotteryImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(imageW);
        }];
        //        _lotteryImage.contentMode = UIViewContentModeScaleAspectFill;
        
        _lotteryName = [[UILabel alloc] init];
        _lotteryName.backgroundColor = [UIColor clearColor];
        _lotteryName.textAlignment = NSTextAlignmentCenter;
        _lotteryName.textColor = kRGBColor(51, 51, 51);
        _lotteryName.adjustsFontSizeToFitWidth = YES;
        _lotteryName.numberOfLines = 2;
        [self addSubview:_lotteryName];
        _lotteryName.font = [UIFont systemFontOfSize:13];
        [_lotteryName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.lotteryImage.mas_bottom).mas_equalTo(10);
        }];

    }
    
    return self;
    
}

@end
