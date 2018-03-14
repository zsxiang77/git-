//
//  WriteSaoMiaoView.m
//  cheDianZhang
//
//  Created by lcc on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "WriteSaoMiaoView.h"

#import "NumberKeyboard.h"

@interface WriteSaoMiaoView()<NumKeyboardDelegate>

@property (nonatomic, strong) UIButton *saomiao_id_car_bt;
@end

@implementation WriteSaoMiaoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    for (int i = 0;i<2; i++) {
        WritePersonalInputTFView *tf = [[WritePersonalInputTFView alloc] init];
        [self addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45*i);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(-79);
            make.height.mas_equalTo(45);
        }];
        tf.isRedTitle = NO;
        if (i == 0) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_name = text;
            };
            tf.titleLb.text = @"姓名：";
            tf.textField.placeholder = @"请输入姓名";
            self.send_name_tf = tf;
        }else{
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_sex = text;
            };
            tf.titleLb.text = @"性别：";
            tf.textField.placeholder = @"请输入性别";
            self.send_sex_tf = tf;
            
            self.send_sex_tf.textField.enabled = NO;
            UIButton *bt = [[UIButton alloc]init];
            [bt addTarget:self action:@selector(sex_tfChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.send_sex_tf addSubview:bt];
            [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.top.mas_equalTo(0);
                make.width.mas_equalTo(kWindowW/2);
            }];
        }
    }
    
    UIView *line = ({
        UIView *vi = [[UIView alloc] init];
        [self addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(45*2-1);
            make.height.mas_equalTo(CGFloatFromPixel(1));
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
        vi;
    });
    
    for (int i = 0;i<5; i++) {
        WritePersonalInputTFView *tf = [[WritePersonalInputTFView alloc] init];
        [self addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45*i+45*2);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        tf.isRedTitle = NO;
        if (i == 0) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_nation = text;
            };
            tf.titleLb.text = @"民族：";
            self.send_nation_tf = tf;
        }else if (i == 1) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_birth = text;
            };
            tf.titleLb.text = @"出生日期：";
            self.send_birth_tf = tf;
            
            self.send_birth_tf.textField.enabled = NO;
            
            UIButton *bt = [[UIButton alloc]init];
            [bt addTarget:self action:@selector(birth_tfChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.send_birth_tf addSubview:bt];
            [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.top.mas_equalTo(0);
                make.width.mas_equalTo(kWindowW/2);
            }];
            
            
        }else if (i == 2) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_addr = text;
            };
            tf.titleLb.text = @"住址：";
            self.send_addr_tf = tf;
        }else if (i == 3) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_id_card = text;
            };
            tf.titleLb.text = @"身份证号：";
            tf.textField.maximumTextLength = 18;
            self.send_id_car_tf = tf;
        }else if (i == 4) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.send_mobile = text;
            };
            tf.titleLb.text = @"电话：";
            self.send_mobile_tf = tf;
            NumberKeyboard *m_keyBoard2;
            m_keyBoard2 = [[NumberKeyboard alloc]init];
            m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
            m_keyBoard2.maxLength = 11;
            m_keyBoard2.myDelegate = self;
            m_keyBoard2.currentField = self.send_mobile_tf.textField;
            self.send_mobile_tf.textField.inputView = m_keyBoard2;
        }
    }
    
    _saomiao_id_car_bt = ({
        UIButton *bt = [[UIButton alloc]init];
        bt.backgroundColor = [UIColor whiteColor];
        [self addSubview:bt];
        UIImageView *imageView = ({
            UIImageView *im = [[UIImageView alloc]init];
            [bt addSubview:im];
            im.image = [UIImage imageNamed:@"重新扫描"];
            im.contentMode = UIViewContentModeScaleAspectFit;
            [im mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(22.5);
                make.centerX.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(19, 19));
            }];
            im;
        });
        UILabel *title = ({
            UILabel *lb = [[UILabel alloc]init];
            [bt addSubview:lb];
            lb.font = [UIFont pf_PingFangSCRegularFontOfSize:11];
            lb.textColor = UIColorHex(#4C8CE2);
            lb.textAlignment = NSTextAlignmentLeft;
            lb.text = @"扫描身份证";
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.top.mas_equalTo(imageView.mas_bottom).mas_equalTo(12);
            }];
            lb;
        });
        
        UIView *lineView = ({
            UIView *v = [[UIView alloc]init];
            [bt addSubview:v];
            v.backgroundColor = UIColorHex(#F0F0F0);
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0.5);
                make.left.mas_equalTo(0);
                make.bottom.top.mas_equalTo(0);
            }];
            v;
        });
        
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(79, 89));
            make.top.mas_equalTo(0);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            NSLog(@"扫描客户身份证");
            @strongify(self)
            //            self.scanIDCard();
            !self.scanIDCard ? : self.scanIDCard();
        }];
        bt;
    });

}
-(void)sex_tfChick:(UIButton *)sender
{
    self.sex_tfChickBack();
    
}

-(void)birth_tfChick:(UITextField *)sender
{
    self.birth_tfChickBack();
}


- (void)setSend_name:(NSString *)send_name
{
    _send_name = send_name;
    _send_name_tf.textField.text = send_name;
}

- (void)setSend_mobile:(NSString *)send_mobile
{
    _send_mobile = send_mobile;
    _send_mobile_tf.textField.text = send_mobile;
}

- (void)setSend_id_card:(NSString *)send_id_card
{
    _send_id_card = send_id_card;
    _send_id_car_tf.textField.text = send_id_card;
    
}


- (void)setSend_sex:(NSString *)send_sex
{
    _send_sex = send_sex;
    _send_sex_tf.textField.text = send_sex;
}
- (void)setSend_addr:(NSString *)send_addr
{
    _send_addr = send_addr;
    _send_addr_tf.textField.text = send_addr;
}
- (void)setSend_birth:(NSString *)send_birth
{
    _send_birth = send_birth;
    _send_birth_tf.textField.text = send_birth;
}
- (void)setSend_nation:(NSString *)send_nation
{
    _send_nation = send_nation;
    _send_nation_tf.textField.text = send_nation;
}



@end
