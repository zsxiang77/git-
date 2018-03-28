//
//  ScanDrivingLicenseVinCell.m
//  cheDianZhang
//
//  Created by kingdream on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ScanDrivingLicenseVinCell.h"

@interface ScanDrivingLicenseVinCell () <QMUITextFieldDelegate>
@property (nonatomic, strong) UIView *line;
@end

@implementation ScanDrivingLicenseVinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
        [_textField addTarget:self action:@selector(textFieldChangeValue:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)setupView
{
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(lb.superview).mas_offset(-11);
            make.width.mas_lessThanOrEqualTo(110);
        }];
        lb.textColor = [UIColor colorWithHexString:@"666666"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        lb;
    });
    
    _textField = ({
        QMUITextField *tf = [[QMUITextField alloc] init];
        [self.contentView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.titleLb.mas_top);
            make.bottom.mas_equalTo(self.titleLb.mas_bottom);
            make.left.mas_equalTo(self.titleLb.mas_right).mas_offset(10);
        }];
        tf.textColor = [UIColor colorWithHexString:@"666666"];
        tf.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        tf.textAlignment = NSTextAlignmentRight;
        tf.returnKeyType = UIReturnKeyDone;
        tf.delegate = self;
        tf;
    });
    
    _numberTipLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(lb.superview).mas_offset(12);
        }];
        lb.textAlignment = NSTextAlignmentRight;
        lb.textColor = [UIColor colorWithHexString:@"666666"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.textFieldTextChangeBlock) {
        self.textFieldTextChangeBlock(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldChangeValue:(UITextField *)textField
{
    NSUInteger count = textField.text.length;
    _numberTipLb.text = [NSString stringWithFormat:@"还有%lu位", 17 - count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.textField becomeFirstResponder];
    }
    
    // Configure the view for the selected state
}

@end
