//
//  PerctInfoCell.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "PerctInfoCell.h"

@interface PerctInfoCell ()
@property (nonatomic, strong) UIImageView *iconIv;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *perctLb;
@property (nonatomic, strong) UILabel *numberLb;
@property (nonatomic, strong) UIImageView *arrowIv;
@property (nonatomic, strong) UIView *line;
@end


@implementation PerctInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _iconIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.contentView addSubview:iv];
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
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconIv.mas_right).mas_offset(9);
            make.centerY.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"333333"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb;
    });
    
    _arrowIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(iv.superview);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"cell_arrow_right"];
        iv;
    });
    
    _numberLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowIv.mas_left);
            make.centerY.mas_equalTo(lb.superview);
            make.width.mas_equalTo(35);
        }];
        lb.textColor = [UIColor colorWithHexString:@"333333"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb;
    });
    
    _perctLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.numberLb.mas_left).mas_offset(-3);
            make.centerY.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"858488"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb;
    });
    
    _line = ({
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CGFloatFromPixel(1));
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
        vi;
    });
}

- (void)setModel:(PerctInfoCellModel *)model
{
    _model = model;
    
    _iconIv.image = [UIImage imageNamed:model.iconName];
    _titleLb.text = model.title;
    _perctLb.text = model.perct;
    _numberLb.text = model.number;
    _numberLb.textColor = model.numberColor;
    _line.hidden = model.isHiddenLine;
}


@end
