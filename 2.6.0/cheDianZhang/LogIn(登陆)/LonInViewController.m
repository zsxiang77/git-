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

@interface LonInViewController ()<UITextFieldDelegate>
{
    UITextField      *userNameTextField;
    UITextField      *passWordTextField;
}

@property(nonatomic,strong)UIButton  *logInBt;
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
            weakSelf.mainview.frame = CGRectMake(0, kNavBarHeight-CGRectGetHeight(keyboardFrameBeginRect)+100, kWindowW, kWindowH-kNavBarHeight);
        }else
        {
            weakSelf.mainview.frame = CGRectMake(0, kNavBarHeight-150, kWindowW, kWindowH-kNavBarHeight);
        }
        
        
        [weakSelf setNavBarToBring];
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainview.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"登录" withBackButton:NO];
    
    self.mainview = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    [self.view addSubview:self.mainview];
    
    UIImageView *titilimagView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Login_01-logo")];
    [self.mainview addSubview:titilimagView];
    [titilimagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.centerX.mas_equalTo(self.view);
        make.width.height.mas_equalTo(65);
    }];
    
    UILabel *titielLabel = [[UILabel alloc]init];
    titielLabel.text = @"让门店经营更简单";
    titielLabel.font = [UIFont systemFontOfSize:20];
    [self.mainview addSubview:titielLabel];
    [titielLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titilimagView.mas_bottom).mas_equalTo(20);
    }];
    
    UIImageView *userNameim = [[UIImageView alloc]initWithImage:DJImageNamed(@"Login_01-user")];
    [self.mainview addSubview:userNameim];
    [userNameim mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(titielLabel.mas_bottom).mas_equalTo(50);
        make.width.height.mas_equalTo(20);
    }];
    
    
    userNameTextField = [[UITextField alloc]init];
    userNameTextField.delegate = self;
    userNameTextField.returnKeyType = UIReturnKeyDone;
    userNameTextField.placeholder = @"请输入用户名";
    userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    userNameTextField.font = [UIFont systemFontOfSize:14];
    [self.mainview addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userNameim);
        make.width.mas_equalTo(kWindowW - 120);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(userNameim.mas_right).mas_equalTo(20);
    }];
    
    UILabel *line1 = [[UILabel alloc]init];
    [self.mainview addSubview:line1];
    line1.backgroundColor = kLineBgColor;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.left.mas_equalTo(userNameim);
        make.top.mas_equalTo(userNameTextField.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *passwordim = [[UIImageView alloc]initWithImage:DJImageNamed(@"Login_01-user")];
    [self.mainview addSubview:passwordim];
    [passwordim mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(line1.mas_bottom).mas_equalTo(15);
        make.width.height.mas_equalTo(20);
    }];
    
    
    passWordTextField = [[UITextField alloc]init];
    passWordTextField.delegate = self;
    passWordTextField.placeholder = @"车店长密码";
    passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passWordTextField.returnKeyType = UIReturnKeyDone;
    [passWordTextField setSecureTextEntry:YES];
    passWordTextField.font = [UIFont systemFontOfSize:14];
    [self.mainview addSubview:passWordTextField];
    [passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(passwordim);
        make.width.mas_equalTo(kWindowW - 120);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(passwordim.mas_right).mas_equalTo(20);
        
    }];
    
    UILabel *line2 = [[UILabel alloc]init];
    [self.mainview addSubview:line2];
    line2.backgroundColor = kLineBgColor;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.left.mas_equalTo(passwordim);
        make.top.mas_equalTo(passWordTextField.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.mainview addSubview:self.logInBt];
    [self.logInBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(line2.mas_bottom).mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
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

-(UIButton *)logInBt
{
    if (!_logInBt) {
        _logInBt = [[UIButton alloc]init];
        [_logInBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_logInBt.layer setCornerRadius:3];
        [_logInBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _logInBt.backgroundColor = kNavBarColor;
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
            [JPUSHService addTags:KISDictionaryHaveKey(staff_info, @"tag") completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                NPrintLog(@"添加的tags是%@",iTags);
                NSData *cookieData = [NSJSONSerialization dataWithJSONObject:iTags
                                                                     options:NSJSONWritingPrettyPrinted
                                                                       error:nil];
                NPrintLog(@"添加的tags是%@",[[NSString alloc] initWithData:cookieData encoding:NSUTF8StringEncoding]);
            } seq:1];
            [JPUSHService setAlias:KISDictionaryHaveKey(staff_info, @"alias") completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NPrintLog(@"添加的Alias是%@",iAlias);
            } seq:1];
            
            [UserInfo shareInstance].userReal_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"real_name")];
            [UserInfo shareInstance].userAvatar = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"avatar")];
            [UserInfo shareInstance].userRole = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(staff_info, @"role")];
            
            
            [weakSelf getrequest_method];
        }else
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
            [weakSelf showMessageWindowWithTitle:KISDictionaryHaveKey(responseObject, @"msg") point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
        }
    } failure:^(id error) {
        
    }];

}


-(void)getrequest_method
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@store_staff/store_set/settings",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@",parserDict);
        
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            
            return ;
        }
        
        NSDictionary *settings = KISDictionaryHaveKey(adData, @"settings");
        
        if (code == 200) {
            [UserInfo shareInstance].isLogined = YES;
            [UserInfo shareInstance].isExplod = KISDictionaryHaveKey(settings, @"is_explod");
            [UserInfo savekIsExplod];
            [UserInfo shareInstance].userZhangHao = userNameTextField.text;
            [UserInfo saveUserName];
            
            [weakSelf showMessageWindowWithTitle:@"登录成功" point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
            //发送登录成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:@"YES"];
            AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate startFirstPage];
        }else
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
            [weakSelf showMessageWindowWithTitle:KISDictionaryHaveKey(responseObject, @"msg") point:CGPointMake(kWindowW/2.0,kWindowH - 100) delay:2.0];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
