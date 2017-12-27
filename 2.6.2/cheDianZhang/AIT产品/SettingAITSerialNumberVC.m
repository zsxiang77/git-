//
//  SettingAITSerialNumberVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "SettingAITSerialNumberVC.h"
#import "AITIntroduceViewController.h"
#import "UIImageView+WebCache.h"
#import "SettingAITSerialNumberView.h"
#import "NumberKeyboard.h"

@interface SettingAITSerialNumberVC ()<UITextFieldDelegate,NumKeyboardDelegate>
{
    UITextField *serialNumberTextField;
    UITextField *verificationCodeTextField;
}

@property(nonatomic,strong)SettingAITSerialNumberView *settingAITSerialNumberView;

@end

@implementation SettingAITSerialNumberVC

-(SettingAITSerialNumberView *)settingAITSerialNumberView
{
    if (!_settingAITSerialNumberView) {
        _settingAITSerialNumberView = [[SettingAITSerialNumberView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_settingAITSerialNumberView];
        [self.view bringSubviewToFront:_settingAITSerialNumberView];
        _settingAITSerialNumberView.hidden = YES;
        [_settingAITSerialNumberView.queDingBt addTarget:self action:@selector(aitqueDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _settingAITSerialNumberView;
}
-(void)aitqueDingBtChick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"设置AIT产品序列号" withBackButton:YES];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    UIView *shangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+10, kWindowW, 200)];
    shangBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shangBackView];
    for (int i = 0; i<2; i++) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, (i+1)*80, kWindowW, 1)];
        line.backgroundColor = kLineBgColor;
        [shangBackView addSubview:line];
        
        UILabel *la = [[UILabel alloc]init];
        la.font = [UIFont systemFontOfSize:14];
        la.textColor = [UIColor grayColor];
        [shangBackView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(i*80);
        }];
        
        UIImageView *zuoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50+(i*80), 20, 20)];
        
        [shangBackView addSubview:zuoImageView];
        
        if (i == 0) {
            la.text = @"请输入序列号";
            zuoImageView.image = DJImageNamed(@"bianma");
            serialNumberTextField = [[UITextField alloc]init];
            serialNumberTextField.delegate = self;
            serialNumberTextField.returnKeyType = UIReturnKeyDone;
            serialNumberTextField.placeholder = @"请输入序列号";
            serialNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            serialNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
            serialNumberTextField.font = [UIFont systemFontOfSize:14];
            NumberKeyboard *m_keyBoard2;
            m_keyBoard2 = [[NumberKeyboard alloc]init];
            m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
            m_keyBoard2.maxLength = 14;
            m_keyBoard2.myDelegate = self;
            m_keyBoard2.currentField = serialNumberTextField;
            serialNumberTextField.inputView = m_keyBoard2;
            [shangBackView addSubview:serialNumberTextField];
            [serialNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(5);
                make.height.mas_equalTo(40);
                make.centerY.mas_equalTo(zuoImageView);
                make.right.mas_equalTo(-10);
            }];
        }else{
            la.text = @"请输入验证码";
            zuoImageView.image = DJImageNamed(@"yan");
            verificationCodeTextField = [[UITextField alloc]init];
            verificationCodeTextField.delegate = self;
            verificationCodeTextField.returnKeyType = UIReturnKeyDone;
            verificationCodeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            verificationCodeTextField.placeholder = @"请输入验证码";
            verificationCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
            verificationCodeTextField.font = [UIFont systemFontOfSize:14];
            NumberKeyboard *m_keyBoard2;
            m_keyBoard2 = [[NumberKeyboard alloc]init];
            m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
            m_keyBoard2.maxLength = 8;
            m_keyBoard2.myDelegate = self;
            m_keyBoard2.currentField = verificationCodeTextField;
            verificationCodeTextField.inputView = m_keyBoard2;
            [shangBackView addSubview:verificationCodeTextField];
            [verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(5);
                make.height.mas_equalTo(40);
                make.centerY.mas_equalTo(zuoImageView);
                make.right.mas_equalTo(-10);
            }];
        }
    }
    
    UIView *xiaBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+20+200, kWindowW, 200)];
    xiaBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xiaBackView];
    UILabel *shuoMingLabel = [[UILabel alloc]init];
    shuoMingLabel.font = [UIFont systemFontOfSize:14];
    shuoMingLabel.text = @"序列号所在位置";
    [xiaBackView addSubview:shuoMingLabel];
    [shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(xiaBackView);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *xiaImageView = [[UIImageView alloc]init];
    [xiaBackView addSubview:xiaImageView];
    [xiaImageView  sd_setImageWithURL:[NSURL URLWithString:@"http://inflexion.icarzoo.com/res/backstage/images/ait_example.png"] placeholderImage:DJImageNamed(@"")];
    [xiaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-40);
    }];
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    [self.view addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    
}

-(void)queDingBtChick:(UIButton *)sender
{
    if (serialNumberTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请输入序列号" point:self.view.center delay:1];
        return;
    }
    if (verificationCodeTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请输入验证码" point:self.view.center delay:1];
        return;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:serialNumberTextField.text forKey:@"serial_number"];
    [mDict setObject:verificationCodeTextField.text forKey:@"verify_code"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store/ait/bind_ait" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
//            [weakSelf showMessageWindowWithTitle:@"绑定成功" point:weakSelf.view.center delay:1];
            weakSelf.settingAITSerialNumberView.hidden = NO;
//            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
    
}


@end
