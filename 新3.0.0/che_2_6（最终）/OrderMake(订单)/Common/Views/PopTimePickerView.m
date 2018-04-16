//
//  PopTimePickerView.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "PopTimePickerView.h"
#import "KLCPopup.h"

@interface PopTimePickerView ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong, readwrite) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, weak) KLCPopup *popup;

@property (nonatomic, assign) BOOL isCommit;
@end

@implementation PopTimePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc] init];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        lb.textColor = [UIColor colorWithHexString:@"333333"];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
        lb.text = @"请选择时间";
        lb;
    });
    
    _datePicker = ({
        UIDatePicker *pk = [[UIDatePicker alloc] init];
        [self addSubview:pk];
        [pk mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(-5);
            make.height.mas_equalTo(160);
        }];
        pk.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        pk.locale = locale;
        pk.date = [NSDate date];
        [pk addTarget:self action:@selector(dataChanged:) forControlEvents:UIControlEventValueChanged];
        pk;
    });
    
    _commitBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(47);
            make.bottom.mas_equalTo(-10);
        }];
        [btn setTitle:@"确 定" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}

- (void)dataChanged:(UIDatePicker *)sender
{
    _currDate = sender.date;
}

- (void)clickCommitButton:(UIButton *)btn
{
    _isCommit = YES;
    [self.popup dismiss:YES];
}

- (void)showWithDate:(NSDate *)date
{
    if (!date) {
        date = [NSDate date];
    }
    NSString *dateStr = [NSDate stringFromDate:date withFormat:@"yyyy-MM-dd"];
    date = [NSDate dateWithString:dateStr format:@"yyyy-MM-dd"];
    _currDate = date;
    
    [self.datePicker setDate:date animated:NO];
    
    KLCPopup *popup = [KLCPopup popupWithContentView:self showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    self.popup = popup;
    popup.willStartDismissingCompletion = ^{
        if (self.isCommit) {
            !self.didSecectedDataCallBack ?: self.didSecectedDataCallBack(self.currDate);
        }
    };
    
    [popup show];
}
@end
