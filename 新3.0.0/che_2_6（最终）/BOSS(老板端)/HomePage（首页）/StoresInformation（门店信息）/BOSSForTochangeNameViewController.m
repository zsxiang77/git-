//
//  BOSSForTochangeNameViewController.m
//  cheDianZhang
//
//  Created by 周岁祥 on 2018/3/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSForTochangeNameViewController.h"

@interface BOSSForTochangeNameViewController ()
<UITextFieldDelegate>
@property(nonatomic,strong)UITextField*mainTextField;
@end

@implementation BOSSForTochangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"门店名称" withBackButton:YES];
self.mainTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, kBOSSNavBarHeight, kWindowW-20, 61)];
self.mainTextField.placeholder=@"请输入您的门店名称";
self.mainTextField.font=[UIFont systemFontOfSize:17];
self.mainTextField.delegate=self;
self.mainTextField.text = KISDictionaryHaveKey(self.chaunzhiMdisn,@"store_name");
[self.mainTextField becomeFirstResponder];
[self.view addSubview:self.mainTextField];

UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight+61, kWindowW, 1)];
line.backgroundColor=kLineBgColor;
[self.view addSubview:line];

UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 20, 44, 44)];
    [btn addTarget:self action:@selector(buttonRight:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [m_baseTopView addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonRight:(UIButton*)sender{
    if(self.mainTextField.text.length<=0){
        [self showMessageWithContent:@"请输入您的门店名称" point:self.view.center afterDelay:1];
        return;
    }
    kWeakSelf(weakSelf)
    NSMutableDictionary*mDict=[NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.mainTextField.text forKey:@"store_name"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"address"] forKey:@"address"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"contact"] forKey:@"contact"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"email"] forKey:@"email"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"phone"] forKey:@"phone"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"yytime"] forKey:@"yytime"];
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/ucenter/update_store_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code=[KISDictionaryHaveKey(responseObject, @"code") integerValue];
        if(code==200){
            [weakSelf showMessageWithContent:@"修改成功" point:self.view.center afterDelay:1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
        }
    } failure:^(id error) {
        
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.mainTextField resignFirstResponder];
        return NO;
    }
    if (textField == self.mainTextField) {
        if(string.length>0){
        if (self.mainTextField.text.length>16) {
            [self showMessageWithContent:@"最多16个字" point:self.view.center afterDelay:1];
            return NO;
         }
        }
    }
    return YES;
}

@end
