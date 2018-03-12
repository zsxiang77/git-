//
//  CarCheckCell.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarCheckCell.h"

@interface CarCheckCell ()
@property (nonatomic, strong) UILabel *indexLb;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *iconIv;
@property (nonatomic, strong) UIView *line;
@end

@implementation CarCheckCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _indexLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(lb.superview);
            make.size.mas_equalTo(CGSizeMake(41, 41));
        }];
        lb.textColor = [UIColor colorWithHexString:@"4A90E2"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:20];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.layer.cornerRadius = 41 * 0.5;
        lb.layer.backgroundColor = [UIColor colorWithHexString:@"E3F3FF"].CGColor;
        lb;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.indexLb.mas_right).mas_offset(11);
            make.centerY.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:20];
        lb;
    });
    
    _iconIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.right.mas_equalTo(-30);
            make.centerY.mas_equalTo(iv.superview);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv;
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

- (void)setModel:(CarCheckCellModel *)model
{
    _model = model;
    
    _indexLb.text = model.index;
    _titleLb.text = model.name;
    _iconIv.image = [UIImage imageNamed:model.iconName];
    _line.hidden = model.isHiddenLine;
}

@end
