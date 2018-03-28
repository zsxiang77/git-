//
//  WritePersonalPersonInfoView.m
//  cheDianZhang
//
//  Created by sykj on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "WritePersonalPersonInfoView.h"
#import "WritePersonalInputTFView.h"
#import "NumberKeyboard.h"
#import "SaoMiaoSFZViewController.h"

@interface WritePersonalPersonInfoView()<NumKeyboardDelegate>

@property (nonatomic, strong) UIButton *saomiao_id_car_bt;
@end
@implementation WritePersonalPersonInfoView

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
                self.store_alias = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"姓名：";
            tf.textField.placeholder = @"请输入姓名";
            self.store_alias_tf = tf;
        }else{
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.sex = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"性别：";
            tf.textField.placeholder = @"请输入性别";
            self.sex_tf = tf;
            self.sex_tf.textField.enabled = NO;
            UIButton *bt = [[UIButton alloc]init];
            [bt addTarget:self action:@selector(sex_tfChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.sex_tf addSubview:bt];
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
                self.nation = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"民族：";
            tf.textField.placeholder=@"请输入民族";
            self.nation_tf = tf;
        }else if (i == 1) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.birth = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"出生日期：";
            self.birth_tf = tf;
            self.birth_tf.textField.enabled = NO;
            
            UIButton *bt = [[UIButton alloc]init];
            [bt addTarget:self action:@selector(birth_tfChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.birth_tf addSubview:bt];
            [bt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.top.mas_equalTo(0);
                make.width.mas_equalTo(kWindowW/2);
            }];
            
        }else if (i == 2) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.addr = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"住址：";
            tf.textField.placeholder=@"请输入您的住址";
            self.addr_tf = tf;
        }else if (i == 3) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.id_car = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"身份证号：";
            tf.textField.maximumTextLength = 18;
            
            tf.textField.placeholder=@"请输入您的身份证号码";
            self.id_car_tf = tf;
        }else if (i == 4) {
            @weakify(self)
            tf.textFieldTextChangeBlock = ^(NSString *text) {
                @strongify(self)
                self.mobile = text;
                !self.userInfoChangeCallBack ?: self.userInfoChangeCallBack();
            };
            tf.titleLb.text = @"电话：";
            tf.textField.placeholder=@"请输入您的电话号码";
            self.mobile_tf = tf;
            NumberKeyboard *m_keyBoard2;
            m_keyBoard2 = [[NumberKeyboard alloc]init];
            m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
            m_keyBoard2.maxLength = 11;
            m_keyBoard2.myDelegate = self;
            m_keyBoard2.currentField = self.mobile_tf.textField;
            self.mobile_tf.textField.inputView = m_keyBoard2;
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
            !self.scanIDCard ? : self.scanIDCard();
        }];
        bt;
    });
    
    UILabel *songLabel = [[UILabel alloc]init];
    [self addSubview:songLabel];
    [songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mobile_tf.mas_bottom).mas_offset(0);
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
    _sendInfoView.backgroundColor = UIColorHex(#F0F0F0);
    [_sendInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45*7);
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(songLabel.mas_bottom).mas_offset(0);
    }];
    
    
    kWeakSelf(weakSelf)
    _sendInfoView.scanIDCard = ^{
        
        SaoMiaoSFZViewController *cameraVC = [[SaoMiaoSFZViewController alloc] init];
        cameraVC.recogType = 2;
        cameraVC.typeName = @"身份证";
        cameraVC.recogOrientation = 0;
        
        //    [self.navigationController pushViewController:cameraVC animated:YES];
        [weakSelf.viewController presentViewController:cameraVC animated:YES completion:nil];
    };
}

-(void)sex_tfChick:(UIButton *)sender
{
    self.sex_tfChickBack();
    
}

-(void)birth_tfChick:(UITextField *)sender
{
    self.birth_tfChickBack();
}


- (void)setMobile:(NSString *)mobile
{
    _mobile = mobile;
    _mobile_tf.textField.text = mobile;
}

- (void)setStore_alias:(NSString *)store_alias
{
    _store_alias = store_alias;
    _store_alias_tf.textField.text = store_alias;
}

- (void)setId_car:(NSString *)id_car
{
    _id_car = id_car;
    _id_car_tf.textField.text = id_car;
}

- (void)setSex:(NSString *)sex
{
    _sex = sex;
    _sex_tf.textField.text = sex;
}
-(void)setAddr:(NSString *)addr
{
    _addr = addr;
    _addr_tf.textField.text = addr;
}
-(void)setBirth:(NSString *)birth
{
    _birth = birth;
    _birth_tf.textField.text = birth;
}

-(void)setNation:(NSString *)nation
{
    _nation = nation;
    _nation_tf.textField.text = nation;
}

@end

