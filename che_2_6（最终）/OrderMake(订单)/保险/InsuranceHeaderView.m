//
//  InsuranceHeaderView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "InsuranceHeaderView.h"

@interface InsuranceHeaderView ()
@property (nonatomic, strong) UILabel *titleLb;
@end

@implementation InsuranceHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
        lb;
    });
}

- (void)setModel:(InsuranceSectionModel *)model
{
    _model = model;
    
    _titleLb.text = model.title;
}

@end
