//
//  ProjectDetailsADDZDYVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDZDYVC.h"
#import "NumberKeyboard.h"
#import "ProjectDetailsChooseView.h"

@interface ProjectDetailsADDZDYVC ()<UITextFieldDelegate,NumKeyboardDelegate>
{
    UITextField       *nameTextField;
    UITextField       *gongShiTextField;
    UITextField       *gongShiFeiTextField;
    
    UILabel           *fenLeiLabel;
}

@property(nonatomic,strong)ProjectDetailsChooseView *projectDetailsChooseView;

@end

@implementation ProjectDetailsADDZDYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加项目" withBackButton:YES];
    
    for (int i = 0; i<4; i++) {
        UIView *bujView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+i*40, kWindowW, 40)];
        [self.view addSubview:bujView];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [bujView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *la  = [[UILabel alloc]init];
        la.font = [UIFont systemFontOfSize:14];
        [bujView addSubview:la];
        if (i == 0) {
            la.frame = CGRectMake(10, 0, 80, 40);
            la.text = @"项目名称：";
            nameTextField = [[UITextField alloc]init];
            nameTextField.font = [UIFont systemFontOfSize:14];
            nameTextField.placeholder = @"请输入项目名称...";
            nameTextField.returnKeyType = UIReturnKeyDone;
            nameTextField.delegate = self;
            [nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [bujView addSubview:nameTextField];
            [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(la.mas_right).mas_equalTo(5);
            }];
            
            
        }else if (i == 1) {
            la.frame = CGRectMake(10, 0, 50, 40);
            la.text = @"工时：";
            
            gongShiTextField = [[UITextField alloc]init];
            gongShiTextField.font = [UIFont systemFontOfSize:14];
            gongShiTextField.placeholder = @"请输入工时...";
            gongShiTextField.returnKeyType = UIReturnKeyDone;
            [gongShiTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            gongShiTextField.delegate = self;
            [bujView addSubview:gongShiTextField];
            [gongShiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(la.mas_right).mas_equalTo(5);
            }];
            
            gongShiTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }else if (i == 2) {
            la.frame = CGRectMake(10, 0, 130, 40);
            la.text = @"工时费(元／小时)：";
            
            gongShiFeiTextField = [[UITextField alloc]init];
            gongShiFeiTextField.font = [UIFont systemFontOfSize:14];
            gongShiFeiTextField.placeholder = @"请输入工时费...";
            gongShiFeiTextField.returnKeyType = UIReturnKeyDone;
            [gongShiFeiTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            gongShiFeiTextField.delegate = self;
            [bujView addSubview:gongShiFeiTextField];
            [gongShiFeiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(la.mas_right).mas_equalTo(5);
            }];
            
            gongShiFeiTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }else if (i == 3) {
            la.frame = CGRectMake(10, 0, 80, 40);
            la.text = @"项目分类：";
            
            UIImageView *dianJImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
            [bujView addSubview:dianJImageView];
            [dianJImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(20);
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(bujView);
            }];
            
            fenLeiLabel = [[UILabel alloc]init];
            fenLeiLabel.font = [UIFont systemFontOfSize:14];
            fenLeiLabel.textColor = [UIColor orangeColor];
            fenLeiLabel.text = @"请选择一个分类...";
            [bujView addSubview:fenLeiLabel];
            [fenLeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(dianJImageView.mas_left).mas_equalTo(-5);
                make.centerY.mas_equalTo(bujView);
            }];
            
            UIButton *xuanZeButton = [[UIButton alloc]init];
            [xuanZeButton addTarget:self action:@selector(xuanZeButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [bujView addSubview:xuanZeButton];
            [xuanZeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
        }
    }
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"提交" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(250+kNavBarHeight);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
}

-(void)queDingBtChick:(UIButton *)sender
{
    [nameTextField resignFirstResponder];
    [gongShiTextField resignFirstResponder];
    [gongShiFeiTextField resignFirstResponder];
    
    if (nameTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入项目名称" point:self.view.center afterDelay:2.0];
        return;
    }
    
    if (gongShiTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入工时" point:self.view.center afterDelay:2.0];
        return;
    }
    
    if (gongShiFeiTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入工时费" point:self.view.center afterDelay:2.0];
        return;
    }
    
    if ([fenLeiLabel.text isEqualToString:@"请选择一个分类..."]) {
        [self showMessageWithContent:@"请选择分类" point:self.view.center afterDelay:2.0];
        return;
    }
    
    
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:nameTextField.text forKey:@"name"];
    [mDict setObject:gongShiTextField.text forKey:@"hour"];
    [mDict setObject:gongShiFeiTextField.text forKey:@"fee"];
    [mDict setObject:fenLeiLabel.text forKey:@"category"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/add_coustom_subject" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        ProjectDetailsViewController *vc = (ProjectDetailsViewController *)self.suerViewController;
        
        OrignalModel *model2 = [[OrignalModel alloc]init];
        [model2 setDangQIanWIthData:dataDic];
        model2.subject = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"name")];
        model2.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"fee")];
        [vc.chuanRuArray addObject:model2];
        
        [vc.main_tableView  reloadData];
        
        [weakSelf.navigationController popToViewController:vc animated:YES];
        
        
    } failure:^(id error) {
        
    }];
}

-(void)xuanZeButtonChick:(UIButton *)sender
{
    self.projectDetailsChooseView.hidden = NO;
    [self.view bringSubviewToFront:self.projectDetailsChooseView];
}


-(ProjectDetailsChooseView *)projectDetailsChooseView
{
    if (!_projectDetailsChooseView) {
        _projectDetailsChooseView = [[ProjectDetailsChooseView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_projectDetailsChooseView];
        kWeakSelf(weakSelf)
        _projectDetailsChooseView.fenLeiBlcok = ^(NSString *str) {
            [weakSelf setfenLeiLabel:str];
        };
    }
    return _projectDetailsChooseView;
}
-(void)setfenLeiLabel:(NSString *)str
{
    fenLeiLabel.text = str;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == nameTextField) {
        if (nameTextField.text.length>30) {
            [self showMessageWindowWithTitle:@"最多30个字" point:self.view.center delay:1];
            nameTextField.text = [nameTextField.text substringToIndex:nameTextField.text.length-1];
            return;
        }
    }
    
    if (textField == gongShiTextField) {
        if ([gongShiTextField.text floatValue]>=999.9) {
            [self showMessageWindowWithTitle:@"工时最大是999.9" point:self.view.center delay:1];
            gongShiTextField.text = @"999.9";
            return;
        }
        
        NSArray *xiaoShuArray = [gongShiTextField.text componentsSeparatedByString:@"."];
        if (xiaoShuArray.count >= 2) {
            NSString *panduanstr = xiaoShuArray[1];
            if (panduanstr.length>1) {
                [self showMessageWindowWithTitle:@"小数只保留一位" point:self.view.center delay:1];
                gongShiTextField.text = [gongShiTextField.text substringToIndex:gongShiTextField.text.length-1];
                return;
            }
        }
        
    }
    
    if (textField == gongShiFeiTextField) {
        if ([gongShiFeiTextField.text floatValue]>=99999.9) {
            [self showMessageWindowWithTitle:@"工时费最大是99999.9" point:self.view.center delay:1];
            gongShiFeiTextField.text = @"99999.9";
            return;
        }
        
        NSArray *xiaoShuArray = [gongShiFeiTextField.text componentsSeparatedByString:@"."];
        if (xiaoShuArray.count >= 2) {
            NSString *panduanstr = xiaoShuArray[1];
            if (panduanstr.length>1) {
                [self showMessageWindowWithTitle:@"小数只保留一位" point:self.view.center delay:1];
                gongShiFeiTextField.text = [gongShiFeiTextField.text substringToIndex:gongShiFeiTextField.text.length-1];
                return;
            }
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    
    
    
    
    return YES;
}

@end
