//
//  BOSSChangeAllNameViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/21.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSChangeAllNameViewController.h"

@interface BOSSChangeAllNameViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField*mainTextfild;
@end

@implementation BOSSChangeAllNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"修改企业名" withBackButton:YES];
    self.mainTextfild=[[UITextField alloc]initWithFrame:CGRectMake(10,kBOSSNavBarHeight , kWindowW-20, 61)];
    self.mainTextfild.placeholder=@"请输入修改的企业名称";
    self.mainTextfild.delegate=self;
    self.mainTextfild.font=[UIFont systemFontOfSize:14];
    [self.mainTextfild becomeFirstResponder];
    [self.view addSubview:self.mainTextfild];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight+61, kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [self.view addSubview:line];
    UIButton *bianJiButton = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 20, 44, 44)];
    [bianJiButton addTarget:self action:@selector(bianJiButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bianJiButton setTitle:@"保存" forState:(UIControlStateNormal)];
    
    [bianJiButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [m_baseTopView addSubview:bianJiButton];
    
    [self.mainTextfild becomeFirstResponder];
}
-(void)bianJiButtonChick:(UIButton *)sender
{
    if (self.mainTextfild.text.length<=0) {
        [self showMessageWithContent:@"请输入姓名" point:self.view.center afterDelay:1];
        return ;
    }
    
    kWeakSelf(weakSelf)
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.mainTextfild.text forKey:@"unit_full_name"];
    [mDict setObject:self.chuanZhidict.user_id forKey:@"user_id"];
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/ucenter/change_comp_name" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
        if (code == 200)
        {
            [weakSelf showMessageWithContent:@"修改成功" point:self.view.center afterDelay:1];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }
    } failure:^(id error) {
        
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.mainTextfild resignFirstResponder];
        return NO;
    }
    if (textField == self.mainTextfild) {
        if (self.mainTextfild.text.length>16) {
            [self showMessageWithContent:@"最多16个字" point:self.view.center afterDelay:1];
            return NO;
        }
    }
    return YES;
}

@end
