//
//  ChangeModileViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ChangeModileViewController.h"
#import "NumberKeyboard.h"

@interface ChangeModileViewController ()<UITextFieldDelegate,NumKeyboardDelegate>
{
    
}
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *yanZhengMaTextField;
@property(nonatomic,strong)UIButton *yanZhengMaBt;

@end

@implementation ChangeModileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.chuanZhiModile.length>0) {
        [self setTopViewWithTitle:@"激活手机号" withBackButton:YES];
    }else{
        if ([UserInfo shareInstance].userMobile.length>0) {
            [self setTopViewWithTitle:@"修改手机号" withBackButton:YES];
        }else
        {
            [self setTopViewWithTitle:@"绑定手机号" withBackButton:YES];
        }
    }
    
    
    for (int i = 0; i<3; i++) {
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        if (i == 1) {
            line.frame = CGRectMake(0, kNavBarHeight+97/2, kWindowW-10, 0.5);
        }else{
            line.frame = CGRectMake(0, kNavBarHeight+i*(97/2), kWindowW, 0.5);
        }
        [self.view addSubview:line];
    }
    
    self.phoneTextField.frame = CGRectMake(10, kNavBarHeight, kWindowW-20, 97/2);
    [self.view addSubview:self.phoneTextField];
    
    UIView *erView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+97/2, kWindowW, 97/2)];
    [self.view addSubview:erView];
    
    [erView addSubview:self.yanZhengMaBt];
    [self.yanZhengMaBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(erView);
        make.height.mas_equalTo(75/2);
        make.width.mas_equalTo(215/2);
    }];
    
    [erView addSubview:self.yanZhengMaTextField];
    [self.yanZhengMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.yanZhengMaBt.mas_left).mas_equalTo(-10);
        make.centerY.mas_equalTo(erView);
        make.height.mas_equalTo(75/2);
    }];
    
    
    UIButton *tijiaoBt = [[UIButton alloc]initWithFrame:CGRectMake(15, 395/2+kNavBarHeight, kWindowW-30, 94/2)];
    [tijiaoBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [tijiaoBt addTarget:self action:@selector(tijiaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [LogInBaseBt zhuTiButton:tijiaoBt];
    [self.view addSubview:tijiaoBt];
    
    if (self.chuanZhiModile.length>0) {
        _phoneTextField.text = self.chuanZhiModile;
    }
    _phoneTextField.userInteractionEnabled = YES;
    if (self.shiFouBiGai == 2) {
        _phoneTextField.userInteractionEnabled = NO;
        _phoneTextField.clearButtonMode = UITextFieldViewModeNever;
    }
    
    
    
    if (self.phoneTextField.text.length>=11) {
        [self.yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.yanZhengMaBt.backgroundColor = kZhuTiColor;
        self.yanZhengMaBt.userInteractionEnabled = YES;
    }else{
        [self.yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.yanZhengMaBt.backgroundColor = kRGBColor(208, 208, 208);
        self.yanZhengMaBt.userInteractionEnabled = NO;
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.yanZhengMaTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)backButtonClick:(id)sender
{
    if (self.shiFouXiuGai == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(void)tijiaoBtChick:(UIButton *)sender
{
    if (self.phoneTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请输入手机号" point:self.view.center delay:1];
    }
    if (self.phoneTextField.text.length<10) {
        [self showMessageWindowWithTitle:@"请填写正确的手机号" point:self.view.center delay:1];
    }
    if (self.yanZhengMaTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请填写验证吗" point:self.view.center delay:1];
    }
    if (self.yanZhengMaTextField.text.length<5) {
        [self showMessageWindowWithTitle:@"请填写正确的验证码" point:self.view.center delay:1];
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.phoneTextField.text forKey:@"mobile"];
    [mDict setObject:self.yanZhengMaTextField.text forKey:@"code"];
    if (self.shiFouXiuGai == YES) {
        [mDict setObject:self.staff_id forKey:@"staff_id"];
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:@"store_staff/staff_user/active_user" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            
            NSDictionary *adData = kParseData(responseObject);
            if (![adData isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSInteger code = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
            
            if (code == 200) {
                [weakSelf showMessageWindowWithTitle:@"激活成功" point:weakSelf.view.center delay:1];
                [UserInfo shareInstance].isLogined = YES;
                [UserInfo saveUserName];
                //发送登录成功的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:@"YES"];
                AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate startFirstPage];
            }else{
                [weakSelf showMessageWindowWithTitle:KISDictionaryHaveKey(responseObject, @"msg") point:weakSelf.view.center delay:1];
            }
        } failure:^(id error) {
            
        }];
    }else{
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:@"store_staff/staff_user/mobile_update" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            
            NSDictionary *adData = kParseData(responseObject);
            if (![adData isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSInteger code = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
            
            if (code == 200) {
                [weakSelf showMessageWindowWithTitle:@"修改成功" point:weakSelf.view.center delay:1];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf showMessageWindowWithTitle:KISDictionaryHaveKey(responseObject, @"msg") point:weakSelf.view.center delay:1];
            }
        } failure:^(id error) {
            
        }];
    }
    
}

-(UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.delegate = self;
        [_phoneTextField addTarget:self action:@selector(phoneTextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.font = [UIFont systemFontOfSize:17];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        
        NumberKeyboard *m_keyBoard2;
        m_keyBoard2 = [[NumberKeyboard alloc]init];
        m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
        m_keyBoard2.maxLength = 11;
        m_keyBoard2.myDelegate = self;
        m_keyBoard2.currentField = _phoneTextField;
        _phoneTextField.inputView = m_keyBoard2;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}
-(void)phoneTextFieldChange:(UITextField *)sender
{
    if (self.phoneTextField.text.length>=11) {
        [self.yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.yanZhengMaBt.backgroundColor = kZhuTiColor;
        self.yanZhengMaBt.userInteractionEnabled = YES;
    }else{
        [self.yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.yanZhengMaBt.backgroundColor = kRGBColor(208, 208, 208);
        self.yanZhengMaBt.userInteractionEnabled = NO;
    }
}
-(UITextField *)yanZhengMaTextField
{
    if (!_yanZhengMaTextField) {
        _yanZhengMaTextField = [[UITextField alloc]init];
        _yanZhengMaTextField.delegate = self;
        _yanZhengMaTextField.placeholder = @"请输入验证码";
        _yanZhengMaTextField.font = [UIFont systemFontOfSize:17];
        _yanZhengMaTextField.clearButtonMode = UITextFieldViewModeAlways;
        NumberKeyboard *m_keyBoard2;
        m_keyBoard2 = [[NumberKeyboard alloc]init];
        m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
        m_keyBoard2.maxLength = 5;
        m_keyBoard2.myDelegate = self;
        m_keyBoard2.currentField = _yanZhengMaTextField;
        _yanZhengMaTextField.inputView = m_keyBoard2;
        _yanZhengMaTextField.delegate = self;
    }
    return _yanZhengMaTextField;
}
-(UIButton *)yanZhengMaBt
{
    if (!_yanZhengMaBt) {
        _yanZhengMaBt = [[UIButton alloc]init];
        _yanZhengMaBt.titleLabel.font = [UIFont systemFontOfSize:17];
        [_yanZhengMaBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_yanZhengMaBt.layer setCornerRadius:2];
        [_yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _yanZhengMaBt.backgroundColor = kRGBColor(208, 208, 208);
        [_yanZhengMaBt setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [_yanZhengMaBt addTarget:self action:@selector(toResend:) forControlEvents:(UIControlEventTouchUpInside)];
        _yanZhengMaBt.userInteractionEnabled = NO;
    }
    return _yanZhengMaBt;
}

- (void)fieldChangeing:(NumberKeyboard*) numKeyboard
{
    if (numKeyboard.currentField == self.phoneTextField) {
        if (self.phoneTextField.text.length>=11) {
            [self.yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            self.yanZhengMaBt.backgroundColor = kZhuTiColor;
            self.yanZhengMaBt.userInteractionEnabled = YES;
        }else{
            [self.yanZhengMaBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            self.yanZhengMaBt.backgroundColor = kRGBColor(208, 208, 208);
            self.yanZhengMaBt.userInteractionEnabled = NO;
        }
    }
}
- (void)hideKeyBoard
{
    [self.phoneTextField resignFirstResponder];
    [self.yanZhengMaTextField resignFirstResponder];
}

-(void)toResend:(UIButton *)sender
{
    [self hideKeyBoard];
    
    if(self.phoneTextField.text.length == 11){
        NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
        [mDict setObject:self.phoneTextField.text forKey:@"mobile"];
        NSString *uelr = @"store_staff/staff_user/send_msg";
        if (self.chuanZhiModile.length>0) {
            uelr = @"store_staff/send_code/send_mobile";
        }
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:uelr viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            
            NSDictionary *adData = kParseData(responseObject);
            if (![adData isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSInteger code = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
            
            if (code == 200) {
                [weakSelf showMessageWindowWithTitle:@"获取成功，请保持电话畅通" point:weakSelf.view.center delay:1];
                [LogInBaseBt startWithTime:60 title:@"获取验证码" countDownTitle:@"s后重发" mainColor:kZhuTiColor countColor:kRGBColor(208, 208, 208) withButton:self.yanZhengMaBt mainTextColor:[UIColor whiteColor] countTextColor:[UIColor whiteColor]];
            }else{
                [weakSelf showMessageWindowWithTitle:KISDictionaryHaveKey(responseObject, @"msg") point:weakSelf.view.center delay:1];
            }
        } failure:^(id error) {
            
        }];
        
    }
}


@end
