//
//  PartsSubsidiaryADDZDYVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "PartsSubsidiaryADDZDYVC.h"
#import "NumberKeyboard.h"
#import "AccessoriesViewController.h"

@interface PartsSubsidiaryADDZDYVC ()<UITextFieldDelegate,NumKeyboardDelegate>
{
    UITextField     *nameTextField;
    UITextField     *bianMaTextField;
    UITextField     *pingPaiTextField;
    UITextField     *danJiaTextField;
}

@end

@implementation PartsSubsidiaryADDZDYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加自定义配件" withBackButton:YES];
    
    for (int i = 0; i<4; i++) {
        UIView *whiView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+10+47*i, kWindowW, 47-1)];
        whiView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:whiView];
        
        UILabel *zuoLabel = [[UILabel alloc]init];
        zuoLabel.textColor = kRGBColor(74, 74, 74);
        zuoLabel.font = [UIFont systemFontOfSize:14];
        [whiView addSubview:zuoLabel];
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(whiView);
        }];
        
        UITextField *youTextField = [[UITextField alloc]init];
        youTextField.textAlignment = NSTextAlignmentRight;
        youTextField.returnKeyType = UIReturnKeyDone;
        youTextField.font = [UIFont systemFontOfSize:14];
        youTextField.delegate = self;
        [whiView addSubview:youTextField];
        [youTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(100);
        }];
        if (i == 0) {
            zuoLabel.text = @"配件名称";
            youTextField.placeholder = @"请填写配件名称";
            nameTextField = youTextField;
        }else if (i == 1) {
            zuoLabel.text = @"配件编码";
            youTextField.placeholder = @"请填写配件编码";
            bianMaTextField = youTextField;
        }else if (i == 2) {
            zuoLabel.text = @"配件品牌";
            youTextField.placeholder = @"请填写配件品牌";
            pingPaiTextField = youTextField;
        }else{
            zuoLabel.text = @"配件单价";
            youTextField.placeholder = @"请填写配件单价";
            danJiaTextField = youTextField;
        }
    }
    
    UIButton *okButton = [[UIButton alloc]init];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [okButton.layer setCornerRadius:3];
    [okButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [okButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-13);
        make.height.mas_equalTo(35);
    }];
}

-(void)okButtonChick:(UIButton *)sender
{
    if (nameTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请填写配件名称" point:self.view.center delay:1];
        return;
    }
    
    if (bianMaTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请填写配件编码" point:self.view.center delay:1];
        return;
    }
    
    if (pingPaiTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请填写配件品牌" point:self.view.center delay:1];
        return;
    }
    
    if (danJiaTextField.text.length<=0) {
        [self showMessageWindowWithTitle:@"请填写配件单价" point:self.view.center delay:1];
        return;
    }
    
    NSMutableDictionary *jsDict = [[NSMutableDictionary alloc]init];
    [jsDict setObject:bianMaTextField.text forKey:@"parts_code"];
    [jsDict setObject:nameTextField.text forKey:@"parts_name"];
    [jsDict setObject:danJiaTextField.text forKey:@"parts_fee"];
    [jsDict setObject:pingPaiTextField.text forKey:@"parts_brand"];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:jsDict withUrl:@"order/repair_order/add_parts" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] != 200) {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }else
        {
            NSDictionary* dataDic = kParseData(responseObject);
            AccessoriesViewController *vc = (AccessoriesViewController *)weakSelf.superViewController;
            OrderDetailPartsModel *model = [[OrderDetailPartsModel alloc]init];
            [model setdataWithDict:dataDic];
            model.parts_num = @"1";
            [vc.tianJiaArray addObject:model];
            [vc.main_tabelView  reloadData];
            
            [weakSelf.navigationController popToViewController:vc animated:YES];
        }
    } failure:^(id error) {
        
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [nameTextField resignFirstResponder];
        [bianMaTextField resignFirstResponder];
        [pingPaiTextField resignFirstResponder];
        [danJiaTextField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
