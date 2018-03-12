//
//  CarInfoTitleView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarInfoTitleView.h"

@interface CarInfoTitleView ()
@property (nonatomic, strong) UIImageView *iconIv;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIButton *chooseBtn;
@end

@implementation CarInfoTitleView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _iconIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(iv.superview);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconIv.mas_right).mas_offset(6);
            make.centerY.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"333333"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb;
    });
    
    _chooseBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(72, 25));
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(btn.superview);
        }];
        [btn setTitle:@"手动选择" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"4A90E2"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        btn.layer.cornerRadius = 4;
        btn.layer.borderWidth = CGFloatFromPixel(1);
        btn.layer.borderColor = [UIColor colorWithHexString:@"4A90E2"].CGColor;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(clickChooseButton) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}

- (void)clickChooseButton
{
    !_didChooseCarButtonCallBack ?: _didChooseCarButtonCallBack();
}

#pragma mark -
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    _iconIv.image = [UIImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLb.text = title;
}

- (void)setIsHiddenButton:(BOOL)isHiddenButton
{
    _isHiddenButton = isHiddenButton;
    _chooseBtn.hidden = isHiddenButton;
}

@end
