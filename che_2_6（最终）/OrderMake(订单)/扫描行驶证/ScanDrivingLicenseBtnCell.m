//
//  ScanDrivingLicenseBtnCell.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "ScanDrivingLicenseBtnCell.h"

@interface ScanDrivingLicenseBtnCell ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIImageView *arrowIv;
@property (nonatomic, strong) UIView *line;
@end

@implementation ScanDrivingLicenseBtnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
        
        _leftBtn.selected = YES;
        _rightBtn.selected = NO;
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
    
    _rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(50);
        }];
//        [btn setTitle:@"非运营" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"4c8ce2"] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        NSMutableAttributedString *titleNor = [[NSMutableAttributedString alloc] initWithString:@"非营运"];
        titleNor.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        titleNor.color = [UIColor colorWithHexString:@"666666"];
        
        NSMutableAttributedString *titleSel = [[NSMutableAttributedString alloc] initWithString:@"非营运"];
        titleSel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:16];
        titleSel.color = [UIColor colorWithHexString:@"4c8ce2"];
        [btn setAttributedTitle:titleNor forState:UIControlStateNormal];
        [btn setAttributedTitle:titleSel forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    UIView *padding = ({
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.rightBtn);
            make.right.mas_equalTo(self.rightBtn.mas_left).mas_offset(-2);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(16);
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"979797"];
        vi;
    });
    
    _leftBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(padding.mas_left).mas_offset(2);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(41);
        }];
//        [btn setTitle:@"运营" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"4c8ce2"] forState:UIControlStateSelected];
//        btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        btn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        NSMutableAttributedString *titleNor = [[NSMutableAttributedString alloc] initWithString:@"营运"];
        titleNor.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        titleNor.color = [UIColor colorWithHexString:@"666666"];
        
        NSMutableAttributedString *titleSel = [[NSMutableAttributedString alloc] initWithString:@"营运"];
        titleSel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:16];
        titleSel.color = [UIColor colorWithHexString:@"4c8ce2"];
        [btn setAttributedTitle:titleNor forState:UIControlStateNormal];
        [btn setAttributedTitle:titleSel forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        btn;
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

- (void)setIsOperate:(BOOL)isOperate
{
    _isOperate = isOperate;
    _leftBtn.selected = isOperate;
    _rightBtn.selected = !isOperate;
}

- (void)clickLeftButton:(UIButton *)sender {
    _leftBtn.selected = YES;
    _rightBtn.selected = NO;
    _isOperate = YES;
    !_valueChangeBlock ?: _valueChangeBlock(_leftBtn.titleLabel.text);
}

- (void)clickRightButton:(UIButton *)sender {
    _leftBtn.selected = NO;
    _rightBtn.selected = YES;
    _isOperate = NO;
    !_valueChangeBlock ?: _valueChangeBlock(_rightBtn.titleLabel.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
