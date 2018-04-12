//
//  BOSSForTochangeMailViewController.m
//  cheDianZhang
//
//  Created by 周岁祥 on 2018/3/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSForTochangeMailViewController.h"

@interface BOSSForTochangeMailViewController ()
<UITextFieldDelegate>
@property(nonatomic,strong)UITextField*mainTextFile;
@end

@implementation BOSSForTochangeMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"邮箱" withBackButton:YES];
    self.mainTextFile=[[UITextField alloc]initWithFrame:CGRectMake(10,kBOSSNavBarHeight , kWindowW-20, 61)];
    self.mainTextFile.placeholder=@"请输入邮箱";
    self.mainTextFile.delegate=self;
    [self.mainTextFile becomeFirstResponder];
    self.mainTextFile.text = KISDictionaryHaveKey(self.chaunzhiMdisn,@"email");
    self.mainTextFile.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:self.mainTextFile];
    
    UILabel*line=[[UILabel alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight+61, kWindowW, 1)];
    line.backgroundColor=kLineBgColor;
    [self.view addSubview:line];
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 20, 44, 44)];
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
        [self showMessageWithContent:@"请输入邮箱" point:self.view.center afterDelay:1];
        return;
    }
    kWeakSelf(weakSelf)
    NSMutableDictionary*mDict=[NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.mainTextFile.text forKey:@"email"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"address"] forKey:@"address"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"contact"] forKey:@"contact"];
    [mDict setObject:[self.chaunzhiMdisn objectForKey:@"store_name"] forKey:@"store_name"];
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string isEqualToString:@"/n"]){
        [self.mainTextFile resignFirstResponder];
        return NO;
    }
    if(textField==self.mainTextFile){
        if(self.mainTextFile.text.length>16){
            [self showMessageWithContent:@"最多16个字" point:self.view.center afterDelay:1];
            return NO;
        }
    }
    return YES;
}
@end
