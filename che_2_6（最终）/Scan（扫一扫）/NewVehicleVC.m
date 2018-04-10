//
//  NewVehicleVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "NewVehicleVC.h"
#import "ModelCarViewController.h"
#import "WorkOrderTypeVC.h"
#import "UIImage+ImageWithColor.h"
#import "NewInputView.h"

@interface NewVehicleVC ()<UITextFieldDelegate,NewInputViewDelegate>
{
    NewInputView  *_accessView;
     UIView *  _accessView1;
    UIView * uiview;
}
@property(nonatomic,strong)UITextField *mainTextField;

@end

@implementation NewVehicleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增车辆" withBackButton:YES];
    

    UILabel *biaoLabel = [[UILabel alloc]init];
    biaoLabel.text = @"请输入您的车牌号码:";
    biaoLabel.font = [UIFont boldSystemFontOfSize:15];
    biaoLabel.textColor = kRGBColor(74, 74, 74);
    [self.view addSubview:biaoLabel];
    [biaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(132/2+kNavBarHeight);
    }];
    
     uiview = [[UIView alloc]init];
    [uiview.layer setBorderWidth:0.5];
    [uiview.layer setCornerRadius:8/2];
    uiview.backgroundColor=kChePaiColor;
    [uiview.layer setBorderColor:kRGBColor(255, 255, 255).CGColor];
    [self.view addSubview:uiview];
    [uiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(biaoLabel.mas_bottom).mas_equalTo(27/2);
        make.height.mas_equalTo(170/2);
    }];
    
    
    self.mainTextField = [[UITextField alloc]init];
    self.mainTextField.delegate  = self;
    self.mainTextField.textAlignment = NSTextAlignmentCenter;
    self.mainTextField.clearButtonMode =UITextFieldViewModeWhileEditing;
    UIButton *clean = [self.mainTextField valueForKey:@"_clearButton"]; //key是固定的
    clean.backgroundColor = [UIColor clearColor];
    clean.hidden = YES;
    [self.mainTextField.layer setMasksToBounds:YES];
    self.mainTextField.font=[UIFont boldSystemFontOfSize:35];
    self.mainTextField.backgroundColor=kChePaiColor;
    [self.mainTextField setTextColor:kRGBColor(255, 255, 255)];
    [self.mainTextField.layer setBorderWidth:1];
    [self.mainTextField.layer setCornerRadius:8/2];
    [self.mainTextField.layer setBorderColor:kRGBColor(255, 255, 255).CGColor];
    [uiview addSubview:self.mainTextField];
    [self.mainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.text = @"请选择您的车牌号颜色:";
    titleLable.font = [UIFont boldSystemFontOfSize:15];
    titleLable.textColor = kRGBColor(74, 74, 74);
    [self.view addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mainTextField.mas_bottom).mas_equalTo(63/2);
    }];
     NSArray * titArr = @[@"蓝色",@"白色",@"黄色",@"黑色",@"绿色"];
    for (int i=0; i<5; i++) {
        UIButton *carNumberBtn = [[UIButton alloc]init];
        [carNumberBtn setTitle:titArr[i] forState:UIControlStateNormal];
        carNumberBtn.tag = i+2000;
        [carNumberBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [carNumberBtn setBackgroundImage:[UIImage imageWithColor:kZhuTiColor] forState:(UIControlStateSelected)];
        carNumberBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [carNumberBtn setTitleColor:kRGBColor(51, 51, 51) forState:UIControlStateNormal];
        [carNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        carNumberBtn.layer.masksToBounds=YES;
        carNumberBtn.layer.borderColor=kRGBColor(151, 151, 151).CGColor;
        carNumberBtn.layer.borderWidth=0.5;
        carNumberBtn.layer.cornerRadius=4;
        [carNumberBtn addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        carNumberBtn.frame = CGRectMake(8+(kWindowW-10)/5*(i%5), 634/2, ((kWindowW-10)/5)-5, 75/2);
        [self.view addSubview:carNumberBtn];
        if(i==0){
            carNumberBtn.selected = YES;
        }
    }
    
    //确定
    UIButton * sureBut = [[UIButton alloc]init];
    [sureBut.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [sureBut.layer setCornerRadius:3];
    sureBut.backgroundColor = kZhuTiColor;
    [sureBut setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBut addTarget:self action:@selector(xiaYiBuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [sureBut setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:sureBut];
    [sureBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-139/2);
        make.height.mas_equalTo(94/2);
    }];
    //1.自定义二级键盘
     _accessView = [[NewInputView alloc] initWithFrame:CGRectMake(0, 0, 1, kWindowH/2-66)];
    _accessView.myDelegate = self;
    _accessView.backgroundColor = kRGBColor(241, 241, 241);

    self.mainTextField.inputView = _accessView;

    _accessView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 35)];
    _accessView1.backgroundColor = kRGBColor(245, 245, 245);
    _accessView1.layer.shadowOpacity = 0.5;// 阴影透明度
    _accessView1.layer.shadowColor = kRGBColor(209, 209, 209).CGColor;// 阴影的颜色
    _accessView1.layer.shadowRadius = 2;// 阴影扩散的范围控制
    _accessView1.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
    self.mainTextField.inputAccessoryView = _accessView1;
    
    for (int i=0; i<3; i++) {
        UIButton * btn01 =[[UIButton alloc]init];
        [btn01 setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
        [btn01 setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateSelected];
        btn01.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn01.tag = 8000+i;
        [btn01 addTarget:self action:@selector(topViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_accessView1 addSubview:btn01];
        if(i==0){
            [btn01 setTitle:@"省份简称" forState:UIControlStateNormal];
            btn01.selected = YES;
            [btn01 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(7);
                make.bottom.mas_equalTo(-7);
                make.width.mas_equalTo(125/2);
            }];
        }else if(i==1){
            [btn01 setTitle:@"数字字母" forState:UIControlStateNormal];
            [btn01 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_accessView1);
                make.centerY.mas_equalTo(_accessView1);
                make.width.mas_equalTo(125/2);
            }];
        }else if(i==2){
            [btn01 setTitle:@"其他字符" forState:UIControlStateNormal];
            [btn01 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_accessView1);
                make.right.mas_equalTo(-10);
                make.width.mas_equalTo(125/2);
            }];
        }
    }
    kWeakSelf(weakSelf)
    _accessView.shoWqieHuan = ^(BOOL stre) {
        [weakSelf qiehuanBtn:stre];
    };
    _accessView.quedingBlock = ^{
        [weakSelf querenTiJiao];
    };
    _accessView.quxiaoBlock = ^{
        [weakSelf quxiaoAnNiu];
    };
    [self.mainTextField becomeFirstResponder];
}

-(void)qiehuanBtn:(BOOL)stre
{
    if(stre){
        _accessView1.hidden=YES;
    }else{
        _accessView1.hidden=NO;
    }
}
-(void)querenTiJiao
{
    [self.mainTextField resignFirstResponder];
    if ([self checkCarID:self.mainTextField.text]==NO) {
        [self showMessageWindowWithTitle:@"车牌号不合法" point:self.view.center delay:2];
        return;
    }
    [self carDaoUserInforMeTion:self.mainTextField.text];
}
-(void)quxiaoAnNiu{
   [self.mainTextField resignFirstResponder];
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    //[self hanzi];
    
    return YES;//表示允许编辑，返回NO，不允许编辑
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSLog(@"%@",string);
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
            [self showMessageWindowWithTitle:@"车牌号不合法" point:self.view.center delay:2];
            return;
        }
        [self carDaoUserInforMeTion:self.mainTextField.text];
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
        [self showMessageWindowWithTitle:@"车牌号不合法" point:self.view.center delay:2];
        return;
    }
    [self carDaoUserInforMeTion:self.mainTextField.text];
}


-(void)carDaoUserInforMeTion:(NSString *)car_number
{
//    car_number = @"宁JJNNNN";
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:car_number forKey:@"car_number"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_query/query" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *adData = kParseData(responseObject);
        WorkOrderTypeVC *vc = [[WorkOrderTypeVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.chePaiStr = car_number;
        vc.chuanZhiArray = weakSelf.chuanZhiArray;
        vc.userInformetionDict = nil;
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            if (adData.count>0) {
                vc.userInformetionDict = adData;
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else
            if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 202) {
                if (adData.count>0) {
                    vc.userInformetionDict = adData;
                }
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
    } failure:^(id error) {
        
    }];
}

#pragma mark---dianjichepan
-(void)NumberClick:(UIButton*)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i=0; i<5; i++) {
        UIButton * btn = [self.view viewWithTag:i+2000];
        btn.selected = NO;
    }
    sender.selected = !sender.selected;
    if(sender.tag==2000){
        self.mainTextField.backgroundColor = kChePaiColor;
        [self.mainTextField setTextColor:kRGBColor(255, 255, 255)];
        uiview.backgroundColor = kChePaiColor;
        [uiview.layer setBorderColor:kChePaiColor.CGColor];
        [self.mainTextField.layer setBorderColor:kRGBColor(255, 255, 255).CGColor];
    }else if(sender.tag==2001){
        self.mainTextField.backgroundColor = kRGBColor(255, 255, 255);
        uiview.backgroundColor = kRGBColor(255, 255, 255);
        [uiview.layer setBorderColor:kRGBColor(74, 74, 74).CGColor];
        [self.mainTextField setTextColor:kRGBColor(74, 74, 74)];
        [self.mainTextField.layer setBorderColor:kRGBColor(74, 74, 74).CGColor];
    }else if(sender.tag==2002){
        self.mainTextField.backgroundColor = [UIColor orangeColor];
        uiview.backgroundColor = [UIColor orangeColor];
        [uiview.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self.mainTextField setTextColor:kRGBColor(74, 74, 74)];
        [self.mainTextField.layer setBorderColor:kRGBColor(74, 74, 74).CGColor];
    }else if(sender.tag==2003){
        self.mainTextField.backgroundColor = kRGBColor(74, 74, 74);
        uiview.backgroundColor =  kRGBColor(74, 74, 74);
        [uiview.layer setBorderColor:kRGBColor(74, 74, 74).CGColor];
        [self.mainTextField setTextColor:kRGBColor(255, 255, 255)];
        [self.mainTextField.layer setBorderColor:kRGBColor(255, 255, 255).CGColor];
    }else if(sender.tag==2004){
        self.mainTextField.backgroundColor = [UIColor greenColor];
        uiview.backgroundColor = [UIColor greenColor];
        [uiview.layer setBorderColor:[UIColor greenColor].CGColor];
        [self.mainTextField setTextColor:kRGBColor(74, 74, 74)];
        [self.mainTextField.layer setBorderColor:kRGBColor(255, 255, 255).CGColor];
    }
#warning 车颜色赋值
}

#pragma mark---NewInputViewDelegate
- (void)shouldChangeCharactersInRangreplacementString:(NSString *)string
{
    if (_accessView.hanziView.hidden == NO) {
        if (![string isEqualToString:@""]) {
            _accessView.hanziView.hidden = YES;
            _accessView.shuziView.hidden = NO;
            for (int i=0; i<3; i++) {
                UIButton * btn = [_accessView1 viewWithTag:i+8000];
                btn.selected = NO;
                if(i==1){
                    btn.selected = YES;
                }
            }
        }
    }
    if([string isEqualToString:@"清空"]){
        self.mainTextField.text = @"";
        return;
    }
    if (string.length>0) {
        if ([self.mainTextField.text length] >=7) { //如果输入框内容大于14则弹出警告
            self.mainTextField.text = [self.mainTextField.text substringToIndex:6];
        }
        self.mainTextField.text = [NSString stringWithFormat:@"%@%@",self.mainTextField.text,string];
        if ([self checkCarID:self.mainTextField.text]==NO) {
           // [self showMessageWithContent:@"车牌号有误" point:self.view.center afterDelay:2.0];
            return;
        }
    }else{
        if (self.mainTextField.text.length<=0) {
            return;
        }else{
            self.mainTextField.text = [self.mainTextField.text substringToIndex:self.mainTextField.text.length-1];
        }
    }
    
}
- (void)fieldChangeing:(NewInputView*) vINinPutView
{
    
}
-(void)topViewBtn:(UIButton*)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i=0; i<3; i++) {
        UIButton * btn = [_accessView1 viewWithTag:i+8000];
        btn.selected = NO;
    }
    sender.selected = !sender.selected;
    if(!_accessView){
        _accessView = [[NewInputView alloc]init];
    };
    if(sender.tag == 8000){
        _accessView.qitaView.hidden=YES;
        _accessView.shuziView.hidden=YES;
        _accessView.hanziView.hidden = NO;
    }else if(sender.tag == 8001){
        _accessView.qitaView.hidden=YES;
        _accessView.shuziView.hidden=NO;
        _accessView.hanziView.hidden = YES;
    }else if(sender.tag == 8002){
        _accessView.qitaView.hidden=NO;
        _accessView.shuziView.hidden=YES;
        _accessView.hanziView.hidden = YES;
    }
}



@end
