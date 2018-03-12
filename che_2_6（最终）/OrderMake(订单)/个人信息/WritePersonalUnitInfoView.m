//
//  WritePersonalUnitInfoView.m
//  cheDianZhang
//
//  Created by sykj on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "WritePersonalUnitInfoView.h"
#import "WritePersonalInputTFView.h"
#import "NumberKeyboard.h"
#import "SaoMiaoSFZViewController.h"

@interface WritePersonalUnitInfoView ()
@property (nonatomic, strong) WritePersonalInputTFView *unit_full_namet_tf;
@property (nonatomic, strong) WritePersonalInputTFView *store_alias_tf;
@property (nonatomic, strong) WritePersonalInputTFView *mobile_tf;
@end

@implementation WritePersonalUnitInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _unit_full_namet_tf = ({
        WritePersonalInputTFView *tf = [[WritePersonalInputTFView alloc] init];
        [self addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        tf.titleLb.text = @"企业全称";
        tf.textField.placeholder = @"请输入企业全称";
        tf.isRedTitle = NO;
        tf.isHiddenLine = NO;
        @weakify(self)
        tf.textFieldTextChangeBlock = ^(NSString *text) {
            @strongify(self)
            self.unit_full_name = text;
        };
        tf;
    });
    
    _store_alias_tf = ({
        WritePersonalInputTFView *tf = [[WritePersonalInputTFView alloc] init];
        [self addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.unit_full_namet_tf.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(self.unit_full_namet_tf.mas_height);
        }];
        tf.titleLb.text = @"企业简称";
        tf.textField.placeholder = @"请输入企业简称";
        tf.isRedTitle = NO;
        tf.isHiddenLine = NO;
        @weakify(self)
        tf.textFieldTextChangeBlock = ^(NSString *text) {
            @strongify(self)
            self.store_alias = text;
            !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
        };
        tf;
    });
    
    _mobile_tf = ({
        WritePersonalInputTFView *tf = [[WritePersonalInputTFView alloc] init];
        [self addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.store_alias_tf.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(self.unit_full_namet_tf.mas_height);
        }];
        tf.titleLb.text = @"企业电话";
        tf.textField.placeholder = @"请输入企业电话";
        tf.isRedTitle = NO;
        tf.isHiddenLine = YES;
//        tf.textField.maximumTextLength = 12;
        
        NumberKeyboard *m_keyBoard2;
        m_keyBoard2 = [[NumberKeyboard alloc]init];
        m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
        m_keyBoard2.maxLength = 12;
//        m_keyBoard2.myDelegate = self;
        m_keyBoard2.currentField = tf.textField;
        tf.textField.inputView = m_keyBoard2;
        
        @weakify(self)
        tf.textFieldTextChangeBlock = ^(NSString *text) {
            @strongify(self)
            self.mobile = text;
            !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
        };
        tf;
    });
    
    UILabel *songLabel = [[UILabel alloc]init];
    [self addSubview:songLabel];
    [songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobile_tf.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(48);
    }];
    songLabel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
    songLabel.textColor = kRGBColor(74,74 , 74);
    songLabel.textAlignment = NSTextAlignmentLeft;
    [songLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [songLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    songLabel.text = @"送修人信息";
    
    _sendInfoView = [[WriteSaoMiaoView alloc] init];
    [self addSubview:_sendInfoView];
    [_sendInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(songLabel.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(45 * 7);
    }];
//
//
//    kWeakSelf(weakSelf)
//    _sendInfoView.scanIDCard = ^{
//
//        SaoMiaoSFZViewController *cameraVC = [[SaoMiaoSFZViewController alloc] init];
//        cameraVC.recogType = 2;
//        cameraVC.typeName = @"身份证";
//        cameraVC.recogOrientation = 0;
//
//        //    [self.navigationController pushViewController:cameraVC animated:YES];
//        [weakSelf.viewController presentViewController:cameraVC animated:YES completion:nil];
//    };
}

- (void)setUnit_full_name:(NSString *)unit_full_name
{
    _unit_full_name = unit_full_name;
    _unit_full_namet_tf.textField.text = unit_full_name;
}

- (void)setStore_alias:(NSString *)store_alias
{
    _store_alias = store_alias;
    _store_alias_tf.textField.text = store_alias;
}

- (void)setMobile:(NSString *)mobile
{
    _mobile = mobile;
    _mobile_tf.textField.text = mobile;
}



@end
