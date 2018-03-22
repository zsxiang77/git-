//
//  LonInViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/29.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "LonInViewController.h"
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import <AdSupport/AdSupport.h>
#import "sys/utsname.h"
#import "NetWorkManagerGet.h"
#import "LogInBaseBt.h"
#import "NumberKeyboard.h"

@interface LonInViewController ()<UITextFieldDelegate,NumKeyboardDelegate>
{
    UITextField      *userNameTextField;
    UITextField      *passWordTextField;
    
//
//    UITextField      *shoujiTextField;
//    UITextField      *yanzhengmaTextField;
    
    UIView           *shoujiLogin;
    UIView           *zhanghuLogin;
    
    UIButton  *shoujiBtn;
    UIButton  *zhanghuBtn;
    
    
    UILabel *btnLine1;
    
}
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *yanZhengMaTextField;
@property(nonatomic,strong)UIButton *yanZhengMaBt;

@property(nonatomic,strong)UIButton  *logInBt;
@property(nonatomic,strong)UIButton  *shoujilogInBt;
@property(nonatomic,strong)UIView *mainview;


@end

@implementation LonInViewController

- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

    [super viewWillDisappear:animated];
}
#pragma 键盘的通知
- (void) keyboardWillShow:(NSNotification*)noti
{
    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        if (CGRectGetHeight(keyboardFrameBeginRect)>0) {
            weakSelf.mainview.frame = CGRectMake(0, -keyboardFrameBeginRect.size.height/2.0, kWindowW, kWindowH);
        }else
        {
            weakSelf.mainview.frame = CGRectMake(0, -150, kWindowW, kWindowH);
        }


        [weakSelf setNavBarToBring];
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{

    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainview.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    m_mainTopTitle = @"登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    [self.view addSubview:self.mainview];
    
    
    UIImageView *touImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*1314/2259)];
    touImageView.image = DJImageNamed(@"longIn_16 copy 10");
    [self.mainview addSubview:touImageView];
    
    

    
    
    //新版
    UILabel *labelText=[[UILabel alloc]init];
    labelText.text=@"车店长";
    labelText.font=[UIFont boldSystemFontOfSize:17];
    labelText.textColor=kRGBColor(74, 144, 266);
    [self.mainview addSubview:labelText];
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(touImageView);
        make.top.mas_equalTo(touImageView.mas_bottom).mas_equalTo(2);
    }];
    
   
    
    
    //两按钮
    shoujiBtn=[[UIButton alloc]init];
    [shoujiBtn setTitle:@"手机登陆" forState:UIControlStateNormal];
    shoujiBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [shoujiBtn setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
    [shoujiBtn addTarget:self action:@selector(shoujidenglu:) forControlEvents:UIControlEventTouchUpInside];
    shoujiBtn.tag=101;
    [self.mainview addSubview:shoujiBtn];
    [shoujiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(touImageView.mas_bottom).mas_equalTo(22);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(kWindowW/2);
    }];
    //按钮线
    btnLine1=[[UILabel alloc]initWithFrame:CGRectMake(0, 57+22+kWindowW*1314/2259-1, kWindowW/2, 1.5)];
    [self.mainview addSubview:btnLine1];
    btnLine1.backgroundColor = kRGBColor(74, 144, 266);
    btnLine1.hidden=NO;
    
    zhanghuBtn=[[UIButton alloc]init];
    [zhanghuBtn setTitle:@"账户登录" forState:UIControlStateNormal];
    zhanghuBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [zhanghuBtn addTarget:self action:@selector(shoujidenglu:) forControlEvents:UIControlEventTouchUpInside];
    zhanghuBtn.tag=102;
    [zhanghuBtn setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
    [self.mainview addSubview:zhanghuBtn];
    [zhanghuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(shoujiBtn);
        make.left.mas_equalTo(kWindowW/2);
        make.height.mas_equalTo(57);
        make.width.mas_equalTo(kWindowW/2);
    }];


    //按钮下长线
    UILabel *btnLine3=[[UILabel alloc]init];
    [self.mainview addSubview:btnLine3];
    btnLine3.backgroundColor = kLineBgColor;
    [btnLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(zhanghuBtn.mas_bottom).mas_equalTo(0.5);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kWindowW);
    }];
   //账户登陆view
       zhanghuLogin=[[UIView alloc]init];
    [self.mainview addSubview:zhanghuLogin];
    zhanghuLogin.hidden=YES;
    [zhanghuLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnLine3.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    UIImageView *userNameim = [[UIImageView alloc]initWithImage:DJImageNamed(@"longIn_账号管理(1)")];
    userNameim.contentMode=UIViewContentModeScaleAspectFit;
    [zhanghuLogin addSubview:userNameim];
    [userNameim mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(18);
        make.width.height.mas_equalTo(22);
    }];
    
    userNameTextField = [[UITextField alloc]init];
    userNameTextField.delegate = self;
    userNameTextField.returnKeyType = UIReturnKeyDone;
    userNameTextField.placeholder = @"请输入用户名";
    userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    userNameTextField.font = [UIFont systemFontOfSize:14];
    [zhanghuLogin addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userNameim);
        make.width.mas_equalTo(kWindowW - 120);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(userNameim.mas_right).mas_equalTo(20);
    }];

    UILabel *line1 = [[UILabel alloc]init];
    [zhanghuLogin addSubview:line1];
    line1.backgroundColor = kLineBgColor;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(userNameim);
        make.top.mas_equalTo(userNameTextField.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *passwordim = [[UIImageView alloc]initWithImage:DJImageNamed(@"longIn_密码")];
    passwordim.contentMode=UIViewContentModeScaleAspectFit;
    [zhanghuLogin addSubview:passwordim];
    [passwordim mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(line1.mas_bottom).mas_equalTo(15);
        make.width.height.mas_equalTo(25);
    }];
    
    
    passWordTextField = [[UITextField alloc]init];
    passWordTextField.delegate = self;
    passWordTextField.placeholder = @"车店长密码";
    passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passWordTextField.returnKeyType = UIReturnKeyDone;
    [passWordTextField setSecureTextEntry:YES];
    passWordTextField.font = [UIFont systemFontOfSize:14];
    [zhanghuLogin addSubview:passWordTextField];
    [passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(passwordim);
        make.width.mas_equalTo(kWindowW - 100);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(passwordim.mas_right).mas_equalTo(20);
        
    }];
    
    UIButton *yanJingBt = [[UIButton alloc]init];
    yanJingBt.imageView.contentMode = UIViewContentModeScaleAspectFit;
    yanJingBt.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [yanJingBt setImage:DJImageNamed(@"longIn_23424") forState:(UIControlStateNormal)];
    [yanJingBt setImage:DJImageNamed(@"longIn_453454") forState:(UIControlStateSelected)];
    [yanJingBt addTarget:self action:@selector(yanJingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [zhanghuLogin addSubview:yanJingBt];
    [yanJingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(passwordim);
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(30);
    }];
    
    UILabel *line2 = [[UILabel alloc]init];
    [zhanghuLogin addSubview:line2];
    line2.backgroundColor = kLineBgColor;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(passwordim);
        make.top.mas_equalTo(passWordTextField.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    [zhanghuLogin addSubview:self.logInBt];
    [self.logInBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(line2.mas_bottom).mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *lianxiText=[[UILabel alloc]init];
    lianxiText.text=@"如有疑问，请拨打";
    lianxiText.textColor=kRGBColor(74, 74, 74);
    lianxiText.font=[UIFont systemFontOfSize:12];
    [zhanghuLogin addSubview:lianxiText];
    [lianxiText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.logInBt);
        make.bottom.mas_equalTo(-39);
    }];
    UILabel *tetelLable=[[UILabel alloc]init];
    tetelLable.text=kDianHuaChanded;
    tetelLable.textColor=kRGBColor(245, 166, 35);
    tetelLable.font=[UIFont systemFontOfSize:18];
    [zhanghuLogin addSubview:tetelLable];
    [tetelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.logInBt);
        make.bottom.mas_equalTo(-11);
    }];
    UIButton * dianhua=[[UIButton alloc]init];
    [zhanghuLogin addSubview:dianhua];
    [dianhua addTarget:self action:@selector(dianhuaClick:) forControlEvents:UIControlEventTouchUpInside];
    [dianhua mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.logInBt);
        make.bottom.mas_equalTo(-11);
        make.width.mas_equalTo(121);
        make.height.mas_equalTo(25);
    }];
   //手机登陆view
    shoujiLogin=[[UIView alloc]init];
    [self.mainview addSubview:shoujiLogin];
    shoujiLogin.hidden=NO;
    [shoujiLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnLine3.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *shoujihao = [[UIImageView alloc]initWithImage:DJImageNamed(@"手机")];
    shoujihao.contentMode = UIViewContentModeScaleAspectFit;
    [shoujiLogin addSubview:shoujihao];
    [shoujihao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(18);
        make.width.height.mas_equalTo(25);
    }];
  
    [shoujiLogin addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userNameim);
        make.width.mas_equalTo(kWindowW - 120);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(shoujihao.mas_right).mas_equalTo(20);
    }];
    UILabel *zline1 = [[UILabel alloc]init];
    [shoujiLogin addSubview:zline1];
    zline1.backgroundColor = kLineBgColor;
    [zline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(shoujihao);
        make.top.mas_equalTo(userNameTextField.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *yanzhengma = [[UIImageView alloc]initWithImage:DJImageNamed(@"YDUI-验证码")];
    yanzhengma.contentMode = UIViewContentModeScaleAspectFit;
    [shoujiLogin addSubview:yanzhengma];
    [yanzhengma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(zline1.mas_bottom).mas_equalTo(15);
        make.width.height.mas_equalTo(22);
    }];
    [shoujiLogin addSubview:self.yanZhengMaBt];
    [self.yanZhengMaBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(passwordim);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(38);
    }];

    [shoujiLogin addSubview:self.yanZhengMaTextField];
    [self.yanZhengMaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(yanzhengma);
        make.right.mas_equalTo(self.yanZhengMaBt.mas_left).mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(yanzhengma.mas_right).mas_equalTo(20);
    }];
    
    UILabel *zline2 = [[UILabel alloc]init];
    [shoujiLogin addSubview:zline2];
    zline2.backgroundColor = kLineBgColor;
    [zline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(yanzhengma);
        make.top.mas_equalTo(passWordTextField.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    [shoujiLogin addSubview:self.shoujilogInBt];
    [self.shoujilogInBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(zline2.mas_bottom).mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *lianxiText2=[[UILabel alloc]init];
    lianxiText2.text=@"如有疑问，请拨打";
    lianxiText2.textColor=kRGBColor(74, 74, 74);
    lianxiText2.font=[UIFont systemFontOfSize:12];
    [shoujiLogin addSubview:lianxiText2];
    [lianxiText2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shoujilogInBt);
        make.bottom.mas_equalTo(-39);
    }];
    UILabel *tetelLable2=[[UILabel alloc]init];
    tetelLable2.text=kDianHuaChanded;
    tetelLable2.textColor=kRGBColor(245, 166, 35);
    tetelLable2.font=[UIFont systemFontOfSize:18];
    [shoujiLogin addSubview:tetelLable2];
    [tetelLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shoujilogInBt);
        make.bottom.mas_equalTo(-11);
    }];
    UIButton * dianhua2=[[UIButton alloc]init];
    [shoujiLogin addSubview:dianhua2];
    [dianhua2 addTarget:self action:@selector(dianhuaClick:) forControlEvents:UIControlEventTouchUpInside];
    [dianhua2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shoujilogInBt);
        make.bottom.mas_equalTo(-11);
        make.width.mas_equalTo(121);
        make.height.mas_equalTo(25);
    }];
}
-(void)dianhuaClick:(UIButton*)sender
{
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",kDianHuaChanded]]];
}
//切换按钮
-(void)shoujidenglu:(UIButton*) sender
{
    [shoujiBtn setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
    [zhanghuBtn setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
    shoujiLogin.hidden=YES;
    zhanghuLogin.hidden=YES;
    if(sender.tag==101){
        [shoujiBtn setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
        shoujiLogin.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            btnLine1.frame=CGRectMake(0, 57+22+kWindowW*1314/2259-1, kWindowW/2, 1.5);
        }];
    }
    if(sender.tag==102){
        
        [zhanghuBtn setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateNormal];
        zhanghuLogin.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            btnLine1.frame=CGRectMake(kWindowW/2, 57+22+kWindowW*1314/2259-1, kWindowW/2, 1.5);
        }];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [passWordTextField resignFirstResponder];
        [userNameTextField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(UIButton *)shoujilogInBt
{
    if (!_shoujilogInBt) {
        _shoujilogInBt = [[UIButton alloc]init];
        [_shoujilogInBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_shoujilogInBt.layer setCornerRadius:3];
        [_shoujilogInBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _shoujilogInBt.backgroundColor = kZhuTiColor;
        _shoujilogInBt.titleLabel.font = [UIFont systemFontOfSize:18];
        [_shoujilogInBt setTitle:@"登录" forState:(UIControlStateNormal)];
        [_shoujilogInBt addTarget:self action:@selector(shoujilogInBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shoujilogInBt;
}

//验证吗按钮
-(UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.delegate = self;
        [_phoneTextField addTarget:self action:@selector(phoneTextFieldChange:) forControlEvents:(UIControlEventEditingChanged)];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.font = [UIFont systemFontOfSize:14];
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
        _yanZhengMaTextField.font = [UIFont systemFontOfSize:14];
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
        _yanZhengMaBt.titleLabel.font = [UIFont systemFontOfSize:16];
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
        
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:@"store_staff/send_code/send_mobile" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            
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
#pragma mark -手机登陆
-(void)shoujilogInBtChick:(UIButton*)sender
{
    if (_phoneTextField.text.length<10) {
        [self showMessageWindowWithTitle:@"请输入正确的手机号" point:self.view.center delay:1];
        return;
    }
    if (self.yanZhengMaTextField.text.length<4) {
        [self showMessageWindowWithTitle:@"验证码不正确" point:self.view.center delay:1];
        return;
    }
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc]init];
    [mDict setObject:_phoneTextField.text forKey:@"mobile"];
    [mDict setObject:self.yanZhengMaTextField.text forKey:@"code"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store_staff/staff_user/staff" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 202) {
            NSDictionary *staff_info = KISDictionaryHaveKey(dataDic, @"staff_info");
            if (![staff_info isKindOfClass:[NSDictionary class]]) {
                return;
            }
            NPrintLog(@"staff_infosbaijc%@",KISDictionaryHaveKey(staff_info, @"tag"));
            NSDictionary *tagDict = KISDictionaryHaveKey(staff_info, @"tag");
            //            NSSet *tagSet = @[[NSString stringWithFormat:@""],];
            //            NSArray *tagArray = [NSArray arrayWithObjects:KISDictionaryHaveKey(tagDict, @"group_tags"),KISDictionaryHaveKey(tagDict, @"position_tags"),KISDictionaryHaveKey(tagDict, @"role_tags"),KISDictionaryHaveKey(tagDict, @"store_tags"), nil];
            NSArray *group_tagsArray = KISDictionaryHaveKey(tagDict, @"group_tags");
            NSArray *position_tagsArray = KISDictionaryHaveKey(tagDict, @"position_tags");
            NSArray *role_tagsArray = KISDictionaryHaveKey(tagDict, @"role_tags");
            NSString *store_tags = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(tagDict, @"store_tags")];
            
            
            
            NSMutableSet *newtagSet = [[NSMutableSet alloc]init];
            if (position_tagsArray.count>0) {
                if ([NSString stringWithFormat:@"%@",position_tagsArray[0]].length>0) {
                    [newtagSet addObject:[NSString stringWithFormat:@"%@",position_tagsArray[0]]];
                }
            }
            
            if (role_tagsArray.count>0) {
                if ([NSString stringWithFormat:@"%@",role_tagsArray[0]].length>0) {
                    [newtagSet addObject:[NSString stringWithFormat:@"%@",role_tagsArray[0]]];
                }
            }
            
            if (store_tags.length>0) {
                [newtagSet addObject:store_tags];
            }
            
            if (group_tagsArray.count>0) {
                if ([NSString stringWithFormat:@"%@",group_tagsArray[0]].length>0) {
                    [newtagSet addObject:[NSString stringWithFormat:@"%@",group_tagsArray[0]]];
                }
            }
            
            
            
            
            NPrintLog(@"%@",KISDictionaryHaveKey(tagDict, @"store_tags"));
            [JPUSHService addTags:newtagSet completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                NPrintLog(@"添加的iResCode是%ld",(long)iResCode);
                
            } seq:1];
            
            
            [JPUSHService setAlias:KISDictionaryHaveKey(staff_info, @"alias") completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NPrintLog(@"添加的Alias是%@",iAlias);
            } seq:1];
            
            [UserInfo shareInstance].userReal_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"real_name")];
            [UserInfo shareInstance].userAvatar = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"avatar")];
            [UserInfo shareInstance].userRole = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"role")];
            [UserInfo shareInstance].userPositions = KISDictionaryHaveKey(staff_info, @"positions");
            
            [UserInfo shareInstance].isLogined = YES;
            [UserInfo shareInstance].userZhangHao = userNameTextField.text;
            [UserInfo saveUserName];
            
            [weakSelf showMessageWindowWithTitle:@"登录成功" point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
            
            BOOL is_active = [KISDictionaryHaveKey(dataDic, @"is_active")boolValue];
            if (is_active == YES) {
                //发送登录成功的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:@"YES"];
                AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate startFirstPage];
            }else{
                ChangeModileViewController *vc = [[ChangeModileViewController alloc]init];
                vc.staff_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"staff_id")];
                vc.chuanZhiModile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"mobile")];
                vc.shiFouBiGai = [KISDictionaryHaveKey(dataDic, @"is_change")integerValue];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
    } failure:^(id error) {
        
    }];
}
-(UIButton *)logInBt
{
    if (!_logInBt) {
        _logInBt = [[UIButton alloc]init];
        [_logInBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_logInBt.layer setCornerRadius:3];
        [_logInBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _logInBt.backgroundColor = kZhuTiColor;
        _logInBt.titleLabel.font = [UIFont systemFontOfSize:18];
        [_logInBt setTitle:@"登录" forState:(UIControlStateNormal)];
        [_logInBt addTarget:self action:@selector(logInBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _logInBt;
}

-(void)logInBtChick:(UIButton *)sender
{
    [userNameTextField resignFirstResponder];
    [passWordTextField resignFirstResponder];
    
    if (userNameTextField.text.length<=0) {
        [self showMessageWithContent:@"账户不能为空" point:self.view.center afterDelay:2.0];
        return;
    }
    if (passWordTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入密码" point:self.view.center afterDelay:2.0];
        return;
    }
    [self longInNetwork:userNameTextField.text WithpassWord:passWordTextField.text];
}

- (NSString*)deviceVersion
{
    // 需要#import
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    return deviceString;
}


- (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", (long)number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}

-(void)yanJingBtChick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [passWordTextField setSecureTextEntry:NO];
    }else{
        [passWordTextField setSecureTextEntry:YES];
    }
}


- (NSMutableDictionary*)getCommonCookieDictionary
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSData *data = [passWordTextField.text dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    NPrintLog(@"loginsshi%@",data);
    NSString *str = [data md5String];
    NSString *jiaMiStr2 = [str uppercaseString];
    
    
    NSString *zhuanZongStr = @"";
    for (int i = 0; i<jiaMiStr2.length/2; i++) {
        if (i==0) {
            zhuanZongStr = [jiaMiStr2 substringWithRange:NSMakeRange(0, 2)];
        }else{
            zhuanZongStr = [NSString stringWithFormat:@"%@-%@",zhuanZongStr,[jiaMiStr2 substringWithRange:NSMakeRange(i*2, 2)]];
        }
    }
    
    NSString *strUrl = [userNameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *logins = [NSString stringWithFormat:@"%@%@",strUrl,zhuanZongStr];
//    logins = [NSString stringWithFormat:@"%@88-87-17-A4-5B-EF-CC-01-E5-94-FD-19-0E-61-6D-7F",userNameTextField.text];
    
    logins = [logins  MD5];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    [mDict setObject:logins forKey:@"logins"];
    NSString *unique_id = @"";
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
        unique_id = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    
    if (unique_id.length<=0) {
        unique_id = [self gen_uuid];
    }
    
    NSString *app_device = [NSString stringWithFormat:@"%@;iOS;%@;%@;%@",kCurrentVersion,phoneVersion,[self deviceVersion],unique_id];
    NPrintLog(@"%@",app_device);
    [mDict setObject:app_device forKey:@"app_device"];
    return mDict;
}
- (NSString *) gen_uuid
{
    CFUUIDRef uuid_ref=CFUUIDCreate(nil);
    CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid=[NSString stringWithString:(__bridge NSString *)(uuid_string_ref)];
    CFRelease(uuid_string_ref);
    return uuid;
}

-(void)longInNetwork:(NSString *)name WithpassWord:(NSString *)passWord
{
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:[self getCommonCookieDictionary] withUrl:@"store_staff/staff_user/staff" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }

        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 202) {
            NSDictionary *staff_info = KISDictionaryHaveKey(dataDic, @"staff_info");
            if (![staff_info isKindOfClass:[NSDictionary class]]) {
                return;
            }
            NPrintLog(@"staff_infosbaijc%@",KISDictionaryHaveKey(staff_info, @"tag"));
            NSDictionary *tagDict = KISDictionaryHaveKey(staff_info, @"tag");
//            NSSet *tagSet = @[[NSString stringWithFormat:@""],];
//            NSArray *tagArray = [NSArray arrayWithObjects:KISDictionaryHaveKey(tagDict, @"group_tags"),KISDictionaryHaveKey(tagDict, @"position_tags"),KISDictionaryHaveKey(tagDict, @"role_tags"),KISDictionaryHaveKey(tagDict, @"store_tags"), nil];
            NSArray *group_tagsArray = KISDictionaryHaveKey(tagDict, @"group_tags");
            NSArray *position_tagsArray = KISDictionaryHaveKey(tagDict, @"position_tags");
            NSArray *role_tagsArray = KISDictionaryHaveKey(tagDict, @"role_tags");
            NSString *store_tags = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(tagDict, @"store_tags")];


            NSMutableSet *newtagSet = [[NSMutableSet alloc]init];
            if (position_tagsArray.count>0) {
                if ([NSString stringWithFormat:@"%@",position_tagsArray[0]].length>0) {
                    [newtagSet addObject:[NSString stringWithFormat:@"%@",position_tagsArray[0]]];
                }
            }

            if (role_tagsArray.count>0) {
                if ([NSString stringWithFormat:@"%@",role_tagsArray[0]].length>0) {
                    [newtagSet addObject:[NSString stringWithFormat:@"%@",role_tagsArray[0]]];
                }
            }

            if (store_tags.length>0) {
                [newtagSet addObject:store_tags];
            }

            if (group_tagsArray.count>0) {
                if ([NSString stringWithFormat:@"%@",group_tagsArray[0]].length>0) {
                    [newtagSet addObject:[NSString stringWithFormat:@"%@",group_tagsArray[0]]];
                }
            }




            NPrintLog(@"%@",KISDictionaryHaveKey(tagDict, @"store_tags"));
            [JPUSHService addTags:newtagSet completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                NPrintLog(@"添加的iResCode是%ld",(long)iResCode);

            } seq:1];


            [JPUSHService setAlias:KISDictionaryHaveKey(staff_info, @"alias") completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NPrintLog(@"添加的Alias是%@",iAlias);
            } seq:1];

            [UserInfo shareInstance].userReal_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"real_name")];
            [UserInfo shareInstance].userAvatar = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"avatar")];
            [UserInfo shareInstance].userRole = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"role")];
            [UserInfo shareInstance].userPositions = KISDictionaryHaveKey(staff_info, @"positions");

            [UserInfo shareInstance].isLogined = YES;
            [UserInfo shareInstance].userZhangHao = userNameTextField.text;
            [UserInfo saveUserName];

            [weakSelf showMessageWindowWithTitle:@"登录成功" point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
            BOOL is_active = [KISDictionaryHaveKey(dataDic, @"is_active")boolValue];
            if (is_active == YES) {
                //发送登录成功的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:@"YES"];
                AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate startFirstPage];
            }else{
                ChangeModileViewController *vc = [[ChangeModileViewController alloc]init];
                vc.staff_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"staff_id")];
                vc.chuanZhiModile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"mobile")];
                vc.shiFouBiGai = [KISDictionaryHaveKey(dataDic, @"is_change")integerValue];
                [weakSelf presentViewController:vc animated:YES completion:nil];
            }
        }else
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
    } failure:^(id error) {

    }];

}


//-(void)getrequest_method
//{
//    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
//    [self showOrHideLoadView:YES];
//
//    kWeakSelf(weakSelf)
//    NSString *path = [NSString stringWithFormat:@"%@store_staff/store_set/settings",HOST_URL];
//    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        nil;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [weakSelf showOrHideLoadView:NO];
//        NSData *filData = responseObject;
//        NSDictionary* parserDict = (NSDictionary *)filData;
//        NPrintLog(@"\n返回：%@",parserDict);
//
//        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
//
//        NSDictionary *adData = kParseData(responseObject);
//        if (![adData isKindOfClass:[NSDictionary class]]) {
//
//            return ;
//        }
//
//        NSDictionary *settings = KISDictionaryHaveKey(adData, @"settings");
//
//        if (code == 200) {
//            [UserInfo shareInstance].isLogined = YES;
//            [UserInfo shareInstance].isExplod = KISDictionaryHaveKey(settings, @"is_explod");
//            [UserInfo savekIsExplod];
//            [UserInfo shareInstance].userZhangHao = userNameTextField.text;
//            [UserInfo saveUserName];
//
//            [weakSelf showMessageWindowWithTitle:@"登录成功" point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
//            //发送登录成功的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:@"YES"];
//            AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            [delegate startFirstPage];
//        }else
//        {
//            [[UserInfo shareInstance] cleanUserInfor];
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
//            [weakSelf showMessageWindowWithTitle:KISDictionaryHaveKey(responseObject, @"msg") point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [weakSelf showOrHideLoadView:NO];
//    }];
//
//}

@end
