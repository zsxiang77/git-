//
//  EnvironmentCell.m
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "EnvironmentCell.h"

@interface EnvironmentCell ()
@property (nonatomic, strong) UIView *dotVi;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *descLb;
@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, strong) UIButton *checkOutBtn;

@property (nonatomic, strong) UILabel *noneLb;
@property (nonatomic, strong) UIView *line;
@end

@implementation EnvironmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _dotVi = ({
        UIView *vi = [UIView new];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(6, 6));
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"4a4a4a"];
        vi.layer.cornerRadius = 3;
        vi;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotVi.mas_right).mas_offset(4.5);
            make.centerY.mas_equalTo(self.dotVi.mas_centerY);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:13];
        lb;
    });
    
    _checkOutBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLb.mas_centerY);
            make.right.mas_equalTo(-10);
        }];
        [btn setTitle:@"合格" forState:UIControlStateNormal];
        [btn setTitle:@"不合格" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"62AC0D"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"FF001F"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:12];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btn;
    });
    
    _descLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(3);
        }];
        lb.textColor = [UIColor colorWithHexString:@"858488"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb;
    });
    
    _arrowBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.centerY.mas_equalTo(self.descLb.mas_centerY);
            make.left.mas_equalTo(self.descLb.mas_right).mas_offset(9);
        }];
        [btn setImage:[UIImage imageNamed:@"environment_up_arrow"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"environment_down_arrow"] forState:UIControlStateSelected];
        btn;
    });
    
    _noneLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLb.mas_centerY);
            make.right.mas_equalTo(-10);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb;
    });
    
    _line = ({
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CGFloatFromPixel(1));
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"979797"];
        vi;
    });
}

- (void)setModel:(EnvironmentCellModel *)model
{
    _model = model;
    
    _titleLb.text = model.title;
    _descLb.attributedText = model.desc;
    
    _noneLb.text = model.model.value == 0 ? @"无" : @"";
    
    if (model.isIdleSpeed) {
        _line.hidden = NO;
        _noneLb.hidden = NO;
        _checkOutBtn.hidden = YES;
        _descLb.hidden = YES;
        _arrowBtn.hidden = YES;
    }
    else {
        _line.hidden = YES;
        _noneLb.hidden = YES;
        _checkOutBtn.hidden = NO;
        _descLb.hidden = NO;
        _arrowBtn.hidden = NO;
    }

    switch (model.valueType) {
        case EnvironmentValueTypeEqual:
            _checkOutBtn.selected = NO;
            _arrowBtn.hidden = YES;
            break;
        case EnvironmentValueTypeUp:
            _checkOutBtn.selected = YES;
            _arrowBtn.hidden = NO;
            _arrowBtn.selected = NO;
            break;
        case EnvironmentValueTypeDown:
            _checkOutBtn.selected = YES;
            _arrowBtn.hidden = NO;
            _arrowBtn.selected = YES;
            break;
    }
    
    _line.hidden = model.isHiddenLine;
}
@end
