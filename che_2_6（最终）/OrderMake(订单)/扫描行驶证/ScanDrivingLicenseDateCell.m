//
//  ScanDrivingLicenseDateCell.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "ScanDrivingLicenseDateCell.h"

@interface ScanDrivingLicenseDateCell ()
@property (nonatomic, strong) UIImageView *arrowIv;
@property (nonatomic, strong) UIView *line;
@end

@implementation ScanDrivingLicenseDateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
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
            make.width.mas_lessThanOrEqualTo(110);
        }];
        lb.textColor = [UIColor colorWithHexString:@"666666"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        lb;
    });
    
    _arrowIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(iv.superview);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = [UIImage imageNamed:@"cell_arrow_right"];
        iv;
    });
    
    _contentLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowIv.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(lb.superview);
        }];
        lb.textColor = [UIColor colorWithHexString:@"666666"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        lb.textAlignment = NSTextAlignmentRight;
        lb;
    });
    
    _line = ({
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CGFloatFromPixel(1));
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
        vi;
    });
}

- (void)setIsHiddenLine:(BOOL)isHiddenLine
{
    _isHiddenLine = isHiddenLine;
    _line.hidden = isHiddenLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
