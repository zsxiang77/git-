//
//  WritePersonalInputTFView.m
//  cheDianZhang
//
//  Created by sykj on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "WritePersonalInputTFView.h"

@interface WritePersonalInputTFView () <QMUITextFieldDelegate>
@property (nonatomic, strong) UIView *line;
@end

@implementation WritePersonalInputTFView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
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
        [self addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.left.mas_equalTo(self.titleLb.mas_right).mas_offset(10);
        }];
        tf.textColor = [UIColor colorWithHexString:@"666666"];
        tf.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        tf.textAlignment = NSTextAlignmentRight;
        tf.returnKeyType = UIReturnKeyDone;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.delegate = self;
        tf;
    });
    
    _line = ({
        UIView *vi = [[UIView alloc] init];
        [self addSubview:vi];
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

- (void)setIsRedTitle:(BOOL)isRedTitle
{
    _isRedTitle = isRedTitle;
    _titleLb.textColor = isRedTitle ? [UIColor colorWithHexString:@"FF383D"] :
                                        [UIColor colorWithHexString:@"666666"];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    !self.textFieldValueChangeCallBack ?: self.textFieldValueChangeCallBack(textField.text);
    return YES;
}

@end
