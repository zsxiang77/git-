//
//  BOSSchangeUserMidelViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSchangeUserMidelViewController.h"
#import "NumberKeyboard.h"

@interface BOSSchangeUserMidelViewController ()<NumKeyboardDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITextField*mainTextFile;
@end

@implementation BOSSchangeUserMidelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:self.nameStr withBackButton:YES];
    self.mainTextFile=[[UITextField alloc]initWithFrame:CGRectMake(10, kBOSSNavBarHeight, kWindowW-21, 61)];
    self.mainTextFile.placeholder=@"请输入您的电话号码";
    [self.mainTextFile becomeFirstResponder];
    self.mainTextFile.text = self.chuanZhidict.mobile;
    self.mainTextFile.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:self.mainTextFile];
    
    self.mainTextFile.clearButtonMode = UITextFieldViewModeAlways;
    
    NumberKeyboard *m_keyBoard2;
    m_keyBoard2 = [[NumberKeyboard alloc]init];
    m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
    m_keyBoard2.maxLength = 11;
    m_keyBoard2.myDelegate = self;
    m_keyBoard2.currentField = self.mainTextFile;
    self.mainTextFile.inputView = m_keyBoard2;
    self.mainTextFile.delegate = self;
    
    
    UILabel*line=[[UILabel alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight+61, kWindowW, 1)];
    line.backgroundColor=kLineBgColor;
    [self.view addSubview:line];
    
    UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 20, 44, 44)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonRight:) forControlEvents:UIControlEventTouchUpInside];
    [m_baseTopView addSubview:btn];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonRight:(UIButton*)seader
{
    if(self.mainTextFile.text.length<=0){
        [self showMessageWindowWithTitle:@"请输入您的电话号码" point:self.view.center delay:1];
    }
    if(self.mainTextFile.text.length<10){
        [self showMessageWindowWithTitle:@"请填写正确的手机号" point:self.view.center delay:1];
    }
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.mainTextFile.text forKey:@"mobile"];
    [mDict setObject:self.chuanZhidict.user_id forKey:@"user_id"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/ucenter/change_user_mobile" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
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
@end
