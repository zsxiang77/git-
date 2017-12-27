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
    [self setTopViewWithTitle:@"接车信息" withBackButton:YES];
    
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } 
    self.gas = 0;
    UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 40)];
    titleLa.text = @"2.输入公里数和汽油量";
    titleLa.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLa];
    
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+40, kWindowW, 230)];
    shangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shangView];
    
    HuanBackView *backView = [[HuanBackView alloc]initWithFrame:CGRectMake((kWindowW-190)/2, 10, 190, 190)];
    [shangView addSubview:backView];
    
    self.sTLoopProgressView = [[STLoopProgressView alloc]initWithFrame:CGRectMake(5, 5, 180, 180)];
    self.sTLoopProgressView.persentage = 0;
    [backView addSubview:self.sTLoopProgressView];
    
    self.jinduSlider = [[UISlider alloc] initWithFrame:CGRectMake(30, 200, kWindowW-60, 20)];
    self.jinduSlider.minimumValue = 0;// 设置最小值
    self.jinduSlider.maximumValue = 100;// 设置最大值
    self.jinduSlider.value = 0;// 设置初始值
    self.jinduSlider.continuous = YES;// 设置可连续变化
    [self.jinduSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [self.jinduSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.jinduSlider addTarget:self action:@selector(sliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [shangView addSubview:self.jinduSlider];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    _tapGesture.delegate = self;
    [self.jinduSlider addGestureRecognizer:_tapGesture];
    
    self.zhanShiLabel = [[UILabel alloc]init];
    self.zhanShiLabel.text = @"0 %油量";
    self.zhanShiLabel.textColor = [UIColor greenColor];
    [backView addSubview:self.zhanShiLabel];
    [self.zhanShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(backView);
    }];
    
    
    UIView *xiaBaiView = [[UIView alloc]init];
    [self.view addSubview:xiaBaiView];
    [xiaBaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(shangView.mas_bottom).mas_equalTo(0);
    }];
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"生成订单" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [xiaBaiView addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    xiaBaiView.backgroundColor = [UIColor whiteColor];
    
    self.tiShiView = [[UIView alloc]initWithFrame:CGRectMake(30, 0, kWindowW-100, 50)];
    self.tiShiView.backgroundColor = [UIColor clearColor];
    [xiaBaiView addSubview:self.tiShiView];
    
    UIImageView *saoJiaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"xiangshanghuangsanjiao")];
    saoJiaoImageView.frame = CGRectMake(3, 0, 10*109/59, 10);
    [self.tiShiView addSubview:saoJiaoImageView];
    
    UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 140, 25)];
    shuoMingLabel.font = [UIFont systemFontOfSize:14];
    [shuoMingLabel.layer setMasksToBounds:YES];
    [shuoMingLabel.layer setCornerRadius:3];
    shuoMingLabel.text = @"拖动来设置油量信息";
    shuoMingLabel.textColor = [UIColor whiteColor];
    shuoMingLabel.textAlignment = NSTextAlignmentCenter;
    shuoMingLabel.backgroundColor = kRGBColor(253, 143, 16);
    [self.tiShiView addSubview:shuoMingLabel];
    
    UILabel *lichengLa = [[UILabel alloc]init];
    lichengLa.text = @"里程数：";
    [xiaBaiView addSubview:lichengLa];
    [lichengLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(35);
    }];
    
    UILabel *lichengLa2 = [[UILabel alloc]init];
    lichengLa2.text = @"KM";
    [xiaBaiView addSubview:lichengLa2];
    [lichengLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(35);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [xiaBaiView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)sliderTouchDown:(UISlider *)sender {
    _tapGesture.enabled = NO;
    self.tiShiView.hidden = YES;
}

- (void)sliderTouchUp:(UISlider *)sender {
    _tapGesture.enabled = YES;
    self.tiShiView.hidden = YES;
}
- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self.jinduSlider];
    CGFloat value = (self.jinduSlider.maximumValue - self.jinduSlider.minimumValue) * (touchPoint.x / self.jinduSlider.frame.size.width );
    [self.jinduSlider setValue:value animated:YES];
    
    self.sTLoopProgressView.persentage = (self.jinduSlider.value)/100.0;
    self.zhanShiLabel.text = [NSString stringWithFormat:@"%.0f %%油量",self.jinduSlider.value];
    self.gas = [[NSString stringWithFormat:@"%.0f",self.jinduSlider.value] integerValue];
    self.tiShiView.hidden = YES;
}

-(void)sliderValueChanged:(UISlider *)sender
{
    self.sTLoopProgressView.persentage = (sender.value)/100.0;
    self.zhanShiLabel.text = [NSString stringWithFormat:@"%.0f %%油量",sender.value];
    self.gas = [[NSString stringWithFormat:@"%.0f",sender.value] integerValue];
    self.tiShiView.hidden = YES;
}


- (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

-(void)queDingBtChick:(UIButton *)sender
{
    [self.liChengTextField resignFirstResponder];
    if (self.gas<=0) {
        [self showMessageWithContent:@"请选择油量" point:self.view.center afterDelay:2.0];
        return;
    }
    self.zuiZhongModel.gas = [NSString stringWithFormat:@"%ld",(long)self.gas];
    
    if (self.liChengTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入里程数" point:self.view.center afterDelay:2.0];
        return;
    }
    self.zuiZhongModel.gas = [NSString stringWithFormat:@"%ld",(long)self.gas];
    
    self.zuiZhongModel.repairmile = [NSString stringWithFormat:@"%@",self.liChengTextField.text];
    
    [self.zuiZhongModel.upload removeAllObjects];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.abnormal forKey:@"abnormal"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.deliver_mobile forKey:@"deliver_mobile"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.deliver_name forKey:@"deliver_name"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.exist forKey:@"exist"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.gas forKey:@"gas"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.goods_remark forKey:@"goods_remark"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.image_info forKey:@"image_info"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.imagec forKey:@"images"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.image_info_sum forKey:@"image_info_sum"];
    
    
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.is_unit forKey:@"is_unit"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.mobile forKey:@"mobile"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.realname forKey:@"realname"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.repair_describe forKey:@"repair_describe"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.repairmile forKey:@"repairmile"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.repairnature forKey:@"repairnature"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.repairtype forKey:@"repairtype"];
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.target_id forKey:@"target_id"];
    if ([self.zuiZhongModel.is_unit isEqualToString:@"1"]) {
        [self.zuiZhongModel.upload setObject:self.zuiZhongModel.unit_full_name forKey:@"unit_full_name"];
    }else{
        [self.zuiZhongModel.upload setObject:@"" forKey:@"unit_full_name"];
    }
    
    [self.zuiZhongModel.upload setObject:self.zuiZhongModel.user_id forKey:@"user_id"];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    NSString *upload = [self convertToJSONData:self.zuiZhongModel.upload];
    upload = [upload stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    upload =  [upload stringByReplacingOccurrencesOfString:@" " withString:@""];
    [mDict setObject:upload forKey:@"upload"];

    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/index" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSString *query_url = KISDictionaryHaveKey(dataDic, @"query_url");
        if (query_url.length>0) {
            SuccessfulOrderViewController *vc = [[SuccessfulOrderViewController alloc]init];
            vc.chuZhiDict = dataDic;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
            [defaultCenter postNotificationName:kShuaXinGuoZuoTai object:nil];
        }
        
        
        NPrintLog(@"%@",KISDictionaryHaveKey(responseObject, @"msg"));
        
    } failure:^(id error) {
        
    }];
}


@end
