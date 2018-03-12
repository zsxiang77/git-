//
//  AITCheckIconView.m
//  测试
//
//  Created by sykj on 2018/1/31.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "AITCheckIconView.h"

@interface AITCheckIconView ()
@property (nonatomic, strong) UIImageView *arrowIv;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *aitIv;
@property (nonatomic, strong) UILabel *descLb;
@end

@implementation AITCheckIconView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _arrowIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(105, 45));
            make.top.mas_equalTo(20);
            make.centerX.mas_equalTo(iv.superview);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"ati_check_arrow_down"];
        iv;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.arrowIv.mas_top).mas_offset(9);
            make.centerX.mas_equalTo(lb.superview);
        }];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
        lb.text = @"序列号位置";
        lb;
    });
    
    _aitIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 185));
            make.top.mas_equalTo(self.arrowIv.mas_bottom).mas_offset(7);
            make.centerX.mas_equalTo(iv.superview);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"car_check_AIT"];
        iv;
    });
    
    _descLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.aitIv.mas_bottom).mas_offset(10);
            make.centerX.mas_equalTo(lb.superview);
        }];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithHexString:@"333333"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
        lb.text = @"AIT设备";
        lb;
    });
}
@end
