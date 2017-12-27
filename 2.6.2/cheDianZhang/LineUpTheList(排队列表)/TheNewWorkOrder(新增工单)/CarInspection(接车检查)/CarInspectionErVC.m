//
//  CarInspectionErVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarInspectionErVC.h"
#import "HPGrowingTextView.h"

#define FANGXIANGTAG  (3000)
#define WENTITAG  (4000)

@interface CarInspectionErVC ()<HPGrowingTextViewDelegate>

@property(nonatomic,strong)UIScrollView *mianScrollView;
@property(nonatomic,strong)HPGrowingTextView *schemeTextView;

@end

@implementation CarInspectionErVC

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
    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        self.mianScrollView.frame = CGRectMake(0, kNavBarHeight-keyboardFrameBeginRect.size.height+70, kWindowW, kWindowH-kNavBarHeight);
        [weakSelf setNavBarToBring];
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mianScrollView.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"接车检查" withBackButton:YES];
    [self yeMianBuJu];
}

-(void)yeMianBuJu
{
    CGFloat sheZhiHeight = 0;
    self.mianScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    self.mianScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mianScrollView];
    
    UIView *shangView1 = [[UIView alloc]initWithFrame:CGRectMake(0, sheZhiHeight, kWindowW, 150)];
    shangView1.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:shangView1];
    sheZhiHeight += 150;
    
    UIImageView *zhanShiImageView = [[UIImageView alloc]initWithImage:self.chuRuMoel.cunImage];
    zhanShiImageView.contentMode = UIViewContentModeScaleAspectFit;
    [shangView1 addSubview:zhanShiImageView];
    [zhanShiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(shangView1);
        make.width.height.mas_equalTo(130);
    }];
    
    UIView *shangView2 = [[UIView alloc]initWithFrame:CGRectMake(0, sheZhiHeight+10, kWindowW, 110)];
    shangView2.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:shangView2];
    sheZhiHeight += 120;
    
    for (int i = 0; i<5; i++) {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake((kWindowW/5)*i, 0, kWindowW/5, 30)];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [bt setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
        [bt addTarget:self action:@selector(fangXiangChick:) forControlEvents:(UIControlEventTouchUpInside)];
        bt.tag = FANGXIANGTAG + i;
        [shangView2 addSubview:bt];
        if (i== 0) {
            [bt setTitle:@"正前" forState:(UIControlStateNormal)];
            self.chuRuMoel.fangXiang = @"正前";
            bt.selected = YES;
        }else if (i== 1) {
            [bt setTitle:@"左侧" forState:(UIControlStateNormal)];
        }else if (i== 2) {
            [bt setTitle:@"右侧" forState:(UIControlStateNormal)];
        }else if (i== 3) {
            [bt setTitle:@"正后" forState:(UIControlStateNormal)];
        }else
        {
            [bt setTitle:@"车顶" forState:(UIControlStateNormal)];
        }
        
    }
    
    for (int i = 0; i<6; i++) {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake((kWindowW/3)*(i%3), 30+(i/3)*40, kWindowW/3, 40)];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [bt setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
        [bt addTarget:self action:@selector(wenTiChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [bt.layer setMasksToBounds:YES];
        [bt.layer setBorderWidth:0.5];
        [bt.layer setBorderColor:kLineBgColor.CGColor];
        bt.tag = WENTITAG + i;
        [shangView2 addSubview:bt];
        if (i== 0) {
            [bt setTitle:@"凹陷" forState:(UIControlStateNormal)];
        }else if (i== 1) {
            [bt setTitle:@"掉漆" forState:(UIControlStateNormal)];
        }else if (i== 2) {
            [bt setTitle:@"刮痕" forState:(UIControlStateNormal)];
        }else if (i== 3) {
            [bt setTitle:@"裂纹" forState:(UIControlStateNormal)];
        }else if (i== 4) {
            [bt setTitle:@"破损" forState:(UIControlStateNormal)];
        }else
        {
            [bt setTitle:@"锈蚀" forState:(UIControlStateNormal)];
        }
    }
    
    UILabel *beiZhuLa = [[UILabel alloc]initWithFrame:CGRectMake(10, sheZhiHeight, kWindowW-20, 30)];
    beiZhuLa.textColor = [UIColor grayColor];
    beiZhuLa.text = @"备注";
    [self.mianScrollView addSubview:beiZhuLa];
    
    self.schemeTextView = [[HPGrowingTextView alloc]initWithFrame:CGRectMake(0, sheZhiHeight+30, kWindowW, 100)];
    self.schemeTextView.backgroundColor = [UIColor clearColor];
    self.schemeTextView.isScrollable = NO;
    self.schemeTextView.minNumberOfLines = 1;
    self.schemeTextView.maxNumberOfLines = 6;
    self.schemeTextView.font = [UIFont systemFontOfSize:13];
    self.schemeTextView.delegate = self;
    self.schemeTextView.returnKeyType = UIReturnKeyDone;
    self.schemeTextView.placeholder = @"备注信息...";
    self.schemeTextView.placeholderColor = kRGBColor(220, 220, 220);
    [self.mianScrollView addSubview:self.schemeTextView];
    sheZhiHeight+=140;
    
    
    UIView *biBuView = [[UIView alloc]init];
    if ((sheZhiHeight+70)<(kWindowH-kNavBarHeight)) {
        biBuView.frame = CGRectMake(0, sheZhiHeight, kWindowW, (kWindowH-kNavBarHeight)-sheZhiHeight);
        sheZhiHeight+=((kWindowH-kNavBarHeight)-sheZhiHeight);
    }else{
        biBuView.frame = CGRectMake(0, sheZhiHeight, kWindowW, 70);
        sheZhiHeight+=70;
    }
    biBuView.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:biBuView];
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [biBuView addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    self.mianScrollView.contentSize = CGSizeMake(kWindowW, sheZhiHeight);
}

-(void)queDingBtChick:(UIButton *)sender
{
    [self.schemeTextView resignFirstResponder];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:self.chuRuMoel.cunImage];
    self.chuRuMoel.beiZhu = self.schemeTextView.text;
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:@"order/order_queue/upload_file" viewController:self isShowLoading:YES withimage:array success:^(id responseObject) {
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        weakSelf.chuRuMoel.tuPianNameStr = KISDictionaryHaveKey(adData, @"names");
        weakSelf.tianJianWenTiChick(weakSelf.chuRuMoel);
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } failure:^(id error) {
        
    }];
}

-(void)fangXiangChick:(UIButton *)sender
{
    [self.schemeTextView resignFirstResponder];
    for (int i = 0; i<5; i++) {
        UIButton *bt = [self.mianScrollView viewWithTag:FANGXIANGTAG + i];
        bt.selected = NO;
    }
    
    sender.selected = !sender.selected;
    self.chuRuMoel.fangXiang = sender.titleLabel.text;
    
}
-(void)wenTiChick:(UIButton *)sender
{
    [self.schemeTextView resignFirstResponder];
    sender.selected = !sender.selected;
    NSMutableArray *tianJianArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<6; i++) {
        UIButton *bt = [self.mianScrollView viewWithTag:WENTITAG + i];
        if (bt.selected == YES) {
            [tianJianArray addObject:bt.titleLabel.text];
        }
    }
    self.chuRuMoel.wenTiArray = tianJianArray;
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.schemeTextView resignFirstResponder];
        return NO;
    }
    
    if (self.schemeTextView.text.length>255) {//50字
        return NO;
    }else
    {
        return YES;
    }
    
}

@end
