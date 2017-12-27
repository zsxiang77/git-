//
//  NewVehicleVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "NewVehicleVC.h"
#import "ModelCarViewController.h"

@interface NewVehicleVC ()<UITextFieldDelegate>
{
    UIView * _accessView;
    UIView * _accessView1;
    
}
@property(nonatomic,strong)UITextField *mainTextField;

@end

@implementation NewVehicleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增车辆" withBackButton:YES];
    
    UILabel *biaoLabel = [[UILabel alloc]init];
    biaoLabel.text = @"请输入车牌号码..";
    biaoLabel.font = [UIFont systemFontOfSize:14];
    biaoLabel.textColor = kZhuTiColor;
    [self.view addSubview:biaoLabel];
    [biaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10+kNavBarHeight);
    }];
    
    self.mainTextField = [[UITextField alloc]init];
    self.mainTextField.text = self.chePaiStr;
    self.mainTextField.delegate  = self;
    [self.view addSubview:self.mainTextField];
    [self.mainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(biaoLabel.mas_bottom).mas_equalTo(5);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.mainTextField.mas_bottom);
    }];
    
    UIButton *xiaYiBuBt = [[UIButton alloc]init];
    [xiaYiBuBt setTitle:@"下一步" forState:(UIControlStateNormal)];
    [xiaYiBuBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    [xiaYiBuBt addTarget:self action:@selector(xiaYiBuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [m_baseTopView addSubview:xiaYiBuBt];
    [xiaYiBuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    
    CGFloat ww = (kWindowW -10)/9;
    
    //1.自定义二级键盘
    if (kWindowH == 480) {
        _accessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, kWindowH/2+ww+5)];
        
    }else{
        _accessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, kWindowH/2-5)];
        
    }
    
    _accessView.backgroundColor = kRGBColor(241, 241, 241);
    _accessView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, ww+4)];
    _accessView1.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    
    self.mainTextField.inputView = _accessView;
    self.mainTextField.inputAccessoryView = _accessView1;
    
    NSArray * tit = @[@"删除",@"提交"];
    CGFloat www = (kWindowW-10)/9;
    CGFloat wwww = (kWindowW-5-www*3-15)/2;
    
    for (int i = 0; i<tit.count; i++) {
        UIButton * b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        b.frame  = CGRectMake(5+www*3+5+wwww*i+5*i, _accessView.frame.size.height-5-www, wwww, www);
        [b setTitle:tit[i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        b.layer.cornerRadius = 10;
        [b.layer setBorderWidth:0.5];
        [b.layer setBorderColor:kLineBgColor.CGColor];
        b.layer.masksToBounds = YES;
        b.backgroundColor = [UIColor whiteColor];
        [b addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        b.tag = 300+i;
        [_accessView addSubview:b];
        
    }
    
    [self.mainTextField becomeFirstResponder];
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self hanzi];
    
    return YES;//表示允许编辑，返回NO，不允许编辑
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        [self.mainTextField resignFirstResponder];
        return YES;
    }
    
    if (self.mainTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([self.mainTextField.text length] > 8) { //如果输入框内容大于14则弹出警告
            textField.text = [self.mainTextField.text substringToIndex:8];
            return NO;
        }
        if ([self checkCarID:self.mainTextField.text]==NO) {
            [self showMessageWithContent:@"车牌号有误" point:self.view.center afterDelay:2.0];
            return NO;
        }
        //只能输入纯大写字母和数字
//        NSCharacterSet *cs;
//        cs = [[NSCharacterSet characterSetWithCharactersInString:self.mainTextField.text] invertedSet];
//        NSArray *array=[string componentsSeparatedByCharactersInSet:cs];
//        NSString *filtered = [array componentsJoinedByString:@""];
//        BOOL basic= [string isEqualToString:filtered];
//        if (textField.text.length >= 6) {
//            [LeafNotification showInController:self withText:@"车牌号码不能超过6个字符哦"];
//            return NO;
//        }
//        return basic;
    }
    return YES;
}

-(void)hanzi{
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 1.5)];
    lin.backgroundColor = kLineBgColor;
    [_accessView1 addSubview:lin];
    
    NSArray * titArr = @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H"/*,@"I"*/,@"J",@"K",@"L",@"M",@"N"/*,@"O"*/,@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    CGFloat ww = (kWindowW -10)/9;
    for (int i = 0; i<titArr.count; i++) {
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt.frame  = CGRectMake(5+(ww)*(i%9),  5+(ww+5)*(i/9), ww-2, ww);
        [bt setTitle:titArr[i] forState:UIControlStateNormal];
        bt.layer.cornerRadius = 10;
        bt.layer.masksToBounds = YES;
        [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [bt.layer setBorderColor:kLineBgColor.CGColor];
        [bt.layer setBorderWidth:0.5];
        bt.backgroundColor = [UIColor whiteColor];
        bt.tag = 200;
        [bt addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_accessView addSubview:bt];
        if (i==10) {
            bt.tintColor = [UIColor redColor] ;
        }
    }
    
    
    NSArray * numberArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    for (int i = 0; i<numberArr.count; i++) {
        CGFloat wwww = (kWindowW-11)/10;
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt.frame  = CGRectMake(5+(wwww)*(i%10), 5, wwww-2, wwww);
        [bt setTitle:numberArr[i] forState:UIControlStateNormal];
        bt.layer.cornerRadius = 10;
        bt.layer.masksToBounds = YES;
        [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [bt.layer setBorderColor:kLineBgColor.CGColor];
        [bt.layer setBorderWidth:0.5];
        bt.backgroundColor = [UIColor whiteColor];
        bt.tag = 200;
        [bt addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_accessView1 addSubview:bt];
        
    }
}

//判断车牌号
BOOL validateCarNo(NSString * carNo)
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

-(void)btnClick:(UIButton *)btn{
    if (btn.tag == 301) {
        [self.mainTextField resignFirstResponder];
        if ([self checkCarID:self.mainTextField.text]==NO) {
            [self showMessageWithContent:@"车牌号有误" point:self.view.center afterDelay:2.0];
            return;
        }
        self.xinZengModel.car_number = self.mainTextField.text;
        ModelCarViewController *vc = [[ModelCarViewController alloc]init];
        vc.superViewController = self.superViewController;
        vc.xinZengModel = self.xinZengModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (self.mainTextField.text.length>7) {
            [self.mainTextField deleteBackward];
            return;
        }
        switch (btn.tag) {
            case 200:
            {
                self.mainTextField.text = [self.mainTextField.text stringByAppendingFormat:@"%@",btn.currentTitle];
            }
                break;
            case 300:
            {
                [self.mainTextField deleteBackward];
            }
                break;

            default:
                break;
        }
    }
    
}


-(BOOL)checkCarID:(NSString *)carID;
{
    if (carID.length>8&&carID.length<7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{5}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
    NSString *carRegex2 = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{4}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex2];
    if ([carTest evaluateWithObject:carID] == NO && [carTest2 evaluateWithObject:carID] == NO) {
        return NO;
    }else
    {
        return YES;
    }
    
    return YES;
}


-(void)xiaYiBuBtChick:(UIButton *)sender
{
    [self.mainTextField resignFirstResponder];
    if ([self checkCarID:self.mainTextField.text]==NO) {
        [self showMessageWithContent:@"车牌号有误" point:self.view.center afterDelay:2.0];
        return;
    }
    self.xinZengModel.car_number = self.mainTextField.text;
    ModelCarViewController *vc = [[ModelCarViewController alloc]init];
    vc.superViewController = self.superViewController;
    vc.xinZengModel = self.xinZengModel;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
