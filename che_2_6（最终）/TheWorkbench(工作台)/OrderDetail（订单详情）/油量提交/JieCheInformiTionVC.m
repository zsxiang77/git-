//
//  JieCheInformiTionVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "JieCheInformiTionVC.h"
#import "STLoopProgressView.h"
#import "HuanBackView.h"
#import "NumberKeyboard.h"
#import "JXCircleSlider.h"
@interface JieCheInformiTionVC ()<UITextFieldDelegate,NumKeyboardDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)STLoopProgressView *sTLoopProgressView;
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;
@property(nonatomic,strong)UISlider *jinduSlider;
@property(nonatomic,strong)UILabel *zhanShiLabel;
@property(nonatomic,strong)UIView *tiShiView;
@property(nonatomic,assign)NSInteger gas;

@property(nonatomic,strong)UITextField *liChengTextField;

@end

@implementation JieCheInformiTionVC
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
//    NSDictionary *userInfo = noti.userInfo;
//    NSValue *value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGRect keyBoardRect = [value CGRectValue];
    
    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.frame = CGRectMake(0,-keyboardFrameBeginRect.size.height+70, kWindowW, kWindowH);
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.frame = CGRectMake(0,0, kWindowW, kWindowH);
    }];
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [self.liChengTextField resignFirstResponder];
        return NO;
    }

    if (textField == self.liChengTextField && self.liChengTextField.text.length>0) {
        NSArray *xiaoShuArray = [self.liChengTextField.text componentsSeparatedByString:@"."];
        if (xiaoShuArray.count>=2) {
            NSString *xiaoShuStr = xiaoShuArray[1];
            if (xiaoShuStr.length>=3) {
                return NO;
            }
        }

    }

    if (self.liChengTextField.text.length>20) {
        return NO;
    }else
    {
        return YES;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"油量选择" withBackButton:YES];

    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.gas = 0;


    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 230)];
    shangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shangView];

//    HuanBackView *backView = [[HuanBackView alloc]initWithFrame:CGRectMake((kWindowW-190)/2, 10, 190, 190)];
    
    JXCircleSlider *slider = [[JXCircleSlider alloc] initWithFrame:CGRectMake((kWindowW-270)/2,50, 270, 270)];
    [slider addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
    [slider changeAngle:180];
    [shangView addSubview:slider];

    
    
    self.zhanShiLabel = [[UILabel alloc]init];
    self.zhanShiLabel.text = [NSString stringWithFormat:@"0%%"];
    self.zhanShiLabel.font = [UIFont boldSystemFontOfSize:63/2];
    self.zhanShiLabel.textColor = [UIColor greenColor];
    [slider addSubview:self.zhanShiLabel];
    [self.zhanShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(slider);
    }];
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.text = @"油量";
    titleLable.textColor = kRGBColor(74, 74, 74);
    titleLable.font = [UIFont systemFontOfSize:14];
    [slider addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(slider);
        make.bottom.mas_equalTo(self.zhanShiLabel.mas_top).mas_equalTo(-12);
    }];
    
   
    
    
    UIView *xiaBaiView = [[UIView alloc]init];
    [self.view addSubview:xiaBaiView];
    [xiaBaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(shangView.mas_bottom).mas_equalTo(0);
    }];
    
    UILabel * lineSender = [[UILabel alloc]init];
    lineSender.backgroundColor = kRGBColor(250, 250, 250);
    [xiaBaiView addSubview:lineSender];
    [lineSender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    

    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];

    [xiaBaiView addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-13);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(94/2);
    }];

    xiaBaiView.backgroundColor = [UIColor whiteColor];
    self.tiShiView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, kWindowW-100, 50)];
    self.tiShiView.backgroundColor = [UIColor clearColor];
    [xiaBaiView addSubview:self.tiShiView];


    UILabel *lichengLa = [[UILabel alloc]init];
    lichengLa.text = @"里程数：";
    [xiaBaiView addSubview:lichengLa];
    [lichengLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(45);
    }];

    UILabel *lichengLa2 = [[UILabel alloc]init];
    lichengLa2.text = @"KM";
    [xiaBaiView addSubview:lichengLa2];
    [lichengLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(45);
    }];

    UILabel * lineLable = [[UILabel alloc]init];
    lineLable.backgroundColor = kLineBgColor;
    [xiaBaiView addSubview:lineLable];
    [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lichengLa2.mas_bottom);
        make.left.mas_equalTo(lichengLa.mas_right);
        make.right.mas_equalTo(lichengLa2.mas_left);
        make.height.mas_equalTo(1);
    }];


    NumberKeyboard *m_keyBoard2;
    m_keyBoard2 = [[NumberKeyboard alloc]init];
    m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
    m_keyBoard2.maxLength = 8;
    m_keyBoard2.myDelegate = self;
    self.liChengTextField = [[UITextField alloc]init];
    m_keyBoard2.currentField = self.liChengTextField;
    self.liChengTextField.inputView = m_keyBoard2;
    self.liChengTextField.placeholder = @"请输入公里数...";
    self.liChengTextField.delegate = self;
    self.liChengTextField.returnKeyType = UIReturnKeyDone;
    self.liChengTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [xiaBaiView addSubview:self.liChengTextField];
    [self.liChengTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lichengLa);
        make.left.mas_equalTo(lichengLa.mas_right);
        make.right.mas_equalTo(lichengLa2.mas_left);
    }];

    [self.view bringSubviewToFront:shangView];
    
}
-(void)queDingBtChick:(UIButton *)sender
{
    
    [self.liChengTextField resignFirstResponder];
    if (self.gas<=0) {
        [self showMessageWithContent:@"请选择油量" point:self.view.center afterDelay:2.0];
        return;
    }

    if (self.liChengTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入里程数" point:self.view.center afterDelay:2.0];
        return;
    }

    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    [mDict setObject:[NSString stringWithFormat:@"%.0f",self.jinduSlider.value] forKey:@"gas"];
    [mDict setObject:self.liChengTextField.text forKey:@"repairmile"];
    

    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/pull_gas" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (weakSelf.shiFouFanHui == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            NSString *query_url = KISDictionaryHaveKey(dataDic, @"query_url");
            if (query_url.length>0) {
                SuccessfulOrderViewController *vc = [[SuccessfulOrderViewController alloc]init];
                vc.chuZhiDict = dataDic;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                [defaultCenter postNotificationName:kShuaXinGuoZuoTai object:nil];
            }
        }
    } failure:^(id error) {

    }];
}

-(void)newValue:(JXCircleSlider*)slider{
    NSInteger contter=0;
    if(slider.angle >=170)
    {
        contter = (slider.angle-180)/1.8;
        if (contter<0) {
            contter = 0;
        }
        if (contter>100) {
            contter = 100;
        }
        self.zhanShiLabel.text = [NSString stringWithFormat:@"%ld %%",contter];
    }
    if (slider.angle >= 0 &&slider.angle < 10) {
        contter = 100;
        self.zhanShiLabel.text = [NSString stringWithFormat:@"%ld %%",contter];
    }
}
@end
