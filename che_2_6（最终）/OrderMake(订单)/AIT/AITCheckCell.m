//
//  AITCheckCell.m
//  测试
//
//  Created by sykj on 2018/1/31.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "AITCheckCell.h"

@interface AITCheckCell ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIView *line;
@end

@implementation AITCheckCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _selectBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.centerY.mas_equalTo(btn.superview);
        }];
        [btn setImage:[UIImage imageNamed:@"ait_check_box_round_unselect"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ait_check_box_round_selected"] forState:UIControlStateSelected];
        btn;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(lb.superview);
            make.right.mas_equalTo(-2);
        }];
        lb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
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

- (void)setModel:(AITCheckCellModel *)model
{
    _model = model;
    
    _selectBtn.selected = model.isSelected;
    _titleLb.text = model.title;
    _line.hidden = model.isHiddenLine;
}


@end
