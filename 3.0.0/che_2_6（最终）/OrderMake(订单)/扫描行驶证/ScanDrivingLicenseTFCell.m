//
//  ScanDrivingLicenseTFCell.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "ScanDrivingLicenseTFCell.h"

@interface ScanDrivingLicenseTFCell () <QMUITextFieldDelegate>
@property (nonatomic, strong) UIView *line;
@end

@implementation ScanDrivingLicenseTFCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
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
            make.centerY.mas_equalTo(lb.superview);
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
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.left.mas_equalTo(self.titleLb.mas_right).mas_offset(10);
        }];
        tf.textColor = [UIColor colorWithHexString:@"666666"];
        tf.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        tf.textAlignment = NSTextAlignmentRight;
        tf.returnKeyType = UIReturnKeyDone;
        tf.delegate = self;
        tf;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.textField becomeFirstResponder];
    }
    
    // Configure the view for the selected state
}

@end
