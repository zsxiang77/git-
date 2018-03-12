//
//  LCBottomView.m
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LCBottomView.h"
#import "LCMessageViewModel.h"

@interface LCBottomView() <UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *leftBT;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UIButton *xiaYibuBT;
@property (nonatomic, strong) LCBottomView *bottomView;
@end

@implementation LCBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillChangeFream:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        self.frame = CGRectMake(0, kWindowH-50, kScreenWidth,50);
        self.backgroundColor = UIColorHex(#f6f6f6);
    }
    return self;
}

- (void)setUpViews{
    self.leftBT = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self addSubview:im];
        im.userInteractionEnabled = YES;
        im.image = [UIImage imageNamed:@"语音图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_offset(11.5);
            make.size.mas_equalTo(CGSizeMake(23.5, 23.5));
        }];
        @weakify(self)
//        [im bk_whenTapped:^(UITapGestureRecognizer * _Nonnull tap) {
//            @strongify(self)
//            
//        }];
        im;
    });
    
    self.leftBT.hidden = YES;
    
    self.xiaYibuBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [self addSubview:bt];
        bt.backgroundColor = UIColorHex(#4A90E2);
        [bt setTitle:@"下一步" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];//[UIFont systemFontOfSize:14];
        [bt setTitleColor:UIColorHex(#ffffff) forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(114);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            if (!LC_isStrEmpty(self.textFiled.text)) {
                LCMessageViewModel *model = [LCMessageViewModel new];
                model.message = self.textFiled.text;
                NSDate *date = [[NSDate alloc]init];
                model.timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //@"yyyy-MM-dd HH:mm:ss zzz"
                // 2018-02-05 23:36:55 GMT+8
                [dateFormatter setDateFormat:@"MM-dd HH:mm"];
                model.time = [dateFormatter stringFromDate:date];
                NSLog(@"currentDateString = %@",model.time);
                !self.sendMessage ? : self.sendMessage(model);
                self.textFiled.text = nil;
            }
            !self.nextStep ? : self.nextStep();
            [self hidenKeyboard];
        }];
        bt;
    });
    
    self.textFiled = [UITextField new];
    _textFiled.delegate = self;
    _textFiled.keyboardType = UIKeyboardTypeDefault;
    _textFiled.returnKeyType = UIReturnKeySend;
    _textFiled.layer.cornerRadius = 2.5;
    _textFiled.layer.borderColor = UIColorHex(#C2C2C2).CGColor;
    _textFiled.layer.borderWidth = 0.5;
    [self addSubview:_textFiled];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.leftBT.mas_right).mas_equalTo(5);
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-125);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (!LC_isStrEmpty(textField.text)) {
        LCMessageViewModel *model = [LCMessageViewModel new];
        model.message = textField.text;
        
        NSDate *date = [[NSDate alloc]init];
        model.timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //@"yyyy-MM-dd HH:mm:ss zzz"
        // 2018-02-05 23:36:55 GMT+8
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        model.time = [dateFormatter stringFromDate:date];
        NSLog(@"currentDateString = %@",model.time);
        !self.sendMessage ? : self.sendMessage(model);
        textField.text = nil;
    }
    return YES;
}

- (void)hidenKeyboard{
    if ([self.textFiled canResignFirstResponder]) {
        [self.textFiled resignFirstResponder];
    }
}

- (void)keyboardWillChangeFream:(NSNotification *)fication{
//    NSLog(@"----- %@",fication.userInfo); //
    CGRect endframe = [[fication.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect endf = CGRectMake(0, endframe.origin.y-50, kScreenWidth, 50);
    NSTimeInterval time  = [[fication.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = endf;
    }];
    
    if ((endframe.origin.y-kWindowH)<(-10)) {
        self.xiaYibuBT.hidden = YES;
        [self.textFiled mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
    }else{
        self.xiaYibuBT.hidden = NO;
        [self.textFiled mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-125);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
    }
}

- (void)dealloc{
    
}

@end
