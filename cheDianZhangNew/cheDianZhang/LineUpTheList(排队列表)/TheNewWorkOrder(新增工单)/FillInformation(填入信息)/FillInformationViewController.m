//
//  FillInformationViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FillInformationViewController.h"
#import "UIImage+ImageWithColor.h"
#import "SZCalendarPicker.h"
#import "UIImageView+WebCache.h"
#import "IDCardCameraViewController.h"
#import "CommonControlOrView.h"

#define kValidChar   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface FillInformationViewController ()<UITextFieldDelegate>
{
    UITextField      *carIdentifyTextField;
    UITextField      *faNumTextField;
    
    UIButton         *zhuCeTimeBt;
    UIButton         *faZhengTimeBt;
    
    UILabel         *zhuCeTimeLabel;
    UILabel         *faZhengTimeLabel;
    
    UIDatePicker* m_randomPickView;
}


@property(nonatomic,strong)UIView *pickMianView;
@property(nonatomic,strong)UIScrollView *mianScrollView;
@property(nonatomic,strong)UIImageView *titileImageView;
@property(nonatomic,strong)NSArray *colorArray;

@property(nonatomic,assign)NSInteger anNiuJi;

@end

@implementation FillInformationViewController


- (UIView *)mainView
{
    CGRect frame = [[UIScreen mainScreen]applicationFrame];
    UIView *mainView = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kWindowW, frame.size.height)];
    [imageView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
    imageView.alpha = 0.6f;
    [mainView addSubview:imageView];
    
    UIView* toolView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 260 + 20, kWindowW, 44)];
    toolView.backgroundColor = kRGBColor(231, 231, 231);
    toolView.layer.masksToBounds = YES;
    toolView.layer.borderWidth = 0.6;
    toolView.layer.borderColor = [kRGBColor(200, 200, 200) CGColor];
    [mainView addSubview:toolView];
    
    UIButton* cancelButton = [CommonControlOrView setButtonWithFrame:CGRectMake(0, 0, 70, 44) title:@"取消" fontSize:[UIFont systemFontOfSize:18.0] textColor:kRGBColor(104, 36, 28) bgImage:nil HighImage:nil selectImage:nil];
    [cancelButton addTarget:self action:@selector(pressedCancel) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:cancelButton];
    
    UIButton* submitButton = [CommonControlOrView setButtonWithFrame:CGRectMake(kWindowW - 70, 0, 70, 44) title:@"确定" fontSize:[UIFont systemFontOfSize:18.0] textColor:kRGBColor(104, 36, 28) bgImage:nil HighImage:nil selectImage:nil];
    [submitButton addTarget:self action:@selector(pressedOK) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:submitButton];
    
    
    m_randomPickView = [[UIDatePicker alloc] init];
    m_randomPickView.frame = CGRectMake(0, kWindowH - 216  + 20, kWindowW, 216);
    m_randomPickView.datePickerMode = UIDatePickerModeDate;
    NSLocale *local = [NSLocale localeWithLocaleIdentifier:@"zh"];
    m_randomPickView.locale = local;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *minDate = [fmt dateFromString:@"1949-1-1"];
    NSDate *timeDate = [fmt dateFromString:@"2117-1-1"];
    m_randomPickView.maximumDate = timeDate;
    m_randomPickView.minimumDate = minDate;
    m_randomPickView.backgroundColor = [UIColor whiteColor];
    [m_randomPickView addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    [mainView addSubview:m_randomPickView];
    return mainView;
}

-(void)pressedCancel
{
    [self dismissModalView];
}
-(void)pressedOK
{
    if ([self comparewithDate:self.officialDate withcurrentTimeString:@"1949-1-1"] == -1) {
        [self showMessageWindowWithTitle:@"时间必须大于1949-1-1" point:self.view.center delay:1];
        return;
    }
    
    if ([self comparewithDate:self.officialDate withcurrentTimeString:@"2117-1-1"] == 1) {
        [self showMessageWindowWithTitle:@"时间必须大于2117-1-1" point:self.view.center delay:1];
        return;
    }
    if (self.officialDate.length>0) {
        if (self.anNiuJi == 1) {
            zhuCeTimeLabel.text = self.officialDate;
        }
        
        if (self.anNiuJi == 2) {
            faZhengTimeLabel.text = self.officialDate;
        }
        
    }else
    {
        //把日期转成字符串.
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        //设置日期格式
        fmt.dateFormat = @"yyyy-MM-dd";
        //格式化日期.
        NSString *dateString = [fmt stringFromDate:m_randomPickView.date];
        self.officialDate = dateString;
        if (self.anNiuJi == 1) {
            zhuCeTimeLabel.text = self.officialDate;
        }
        
        if (self.anNiuJi == 2) {
            faZhengTimeLabel.text = self.officialDate;
        }
    }
    [self dismissModalView];
}
- (void)dismissModalView
{
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationRepeatAutoreverses:NO];
    CGPoint center = self.pickMianView.center;
    center.y += [UIScreen mainScreen].bounds.size.height;
    self.pickMianView.center = center;
    [UIView commitAnimations];
}

#pragma mark 选择日期
//当日期改变时调
- (void)dateChange:(UIDatePicker *)datePick{
    //把日期转成字符串.
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd";
    //格式化日期.
    NSString *dateString = [fmt stringFromDate:datePick.date];
    self.officialDate = dateString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"填入信息" withBackButton:YES];
    self.colorArray = @[@"黑色",@"白色",@"银色",@"红色",@"蓝色",@"灰色",@"自定义"];
    
    self.view.backgroundColor = kRGBColor(240, 240, 240);
    [self dangQianBuJU];
    
    self.pickMianView = [self mainView];
    self.pickMianView.frame = CGRectMake(0, kWindowH, kWindowW, kWindowH);
    [self.view addSubview:self.pickMianView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self gengXinViewData];
}

-(CarColorView *)carColorView
{
    if (!_carColorView) {
        _carColorView = [[CarColorView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        _carColorView.colorTextFild.delegate = self;
        [_carColorView.okTiJiaoBt addTarget:self action:@selector(colorViewokTiJiaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_carColorView];
        [self.view bringSubviewToFront:_carColorView];
    }
    return _carColorView;
}
-(void)colorViewokTiJiaoBtChick:(UIButton *)sender
{
    [self.carColorView.colorTextFild resignFirstResponder];
    UIButton *bt = [self.mianScrollView viewWithTag:5006];
    [bt setTitle:self.carColorView.colorTextFild.text forState:(UIControlStateNormal)];
    self.carColorView.colorTextFild.text = @"";
    self.carColorView.hidden = YES;
}

-(void)gengXinViewData
{
    if (self.chuanZhiDict) {
        if ((self.cropImagepath.length<=0)||(!self.cropImagepath)) {
            [self.titileImageView  sd_setImageWithURL:[NSURL URLWithString:self.chuanZhiDict.images] placeholderImage:DJImageNamed(@"ic_launcher")];
        }else{
            UIImage *image = [UIImage imageWithContentsOfFile:self.cropImagepath];
            self.titileImageView.image = image;
        }
        
        carIdentifyTextField.text = self.chuanZhiDict.carvin;
        faNumTextField.text =  self.chuanZhiDict.engine_number;
        zhuCeTimeLabel.text = self.chuanZhiDict.register_date;
        faZhengTimeLabel.text = self.chuanZhiDict.issue_date;
        
        for(int i = 0;i<self.colorArray.count;i++){
            if ([self.zhuModel.car_body_color isEqualToString:self.colorArray[i]]) {
                UIButton *bt = [self.mianScrollView viewWithTag:5000+i];
                bt.selected = YES;
            }
        }
        BOOL shiFouXuanZhon = NO;
        for (int i = 0; i<7; i++) {
            UIButton *bt = [self.mianScrollView viewWithTag:5000+i];
            if (bt.selected == YES) {
                shiFouXuanZhon = YES;
            }
        }
        
        if (shiFouXuanZhon == NO) {
            UIButton *bt = [self.mianScrollView viewWithTag:5006];
            NSString *colorStr = self.zhuModel.car_body_color;
            if (colorStr.length>0) {
                bt.selected  = YES;
                [bt setTitle:self.zhuModel.car_body_color forState:(UIControlStateNormal)];
            }
        }
        
        
        NSInteger cartype = self.chuanZhiDict.cartype;
        switch (cartype) {
            case 1:
            {
                UIButton *bt = [self.mianScrollView viewWithTag:6000];
                bt.selected = YES;
            }
                break;
            case 2:
            {
                UIButton *bt = [self.mianScrollView viewWithTag:6001];
                bt.selected = YES;
            }
                break;
            case 3:
            {
                UIButton *bt = [self.mianScrollView viewWithTag:6002];
                bt.selected = YES;
            }
                break;
            case 9:
            {
                UIButton *bt = [self.mianScrollView viewWithTag:6003];
                bt.selected = YES;
            }
                break;
                
            default:
                break;
        }
    }
}

-(void)zhuCeTimeBtChick:(UIButton *)sender
{
    [faNumTextField resignFirstResponder];
    [carIdentifyTextField resignFirstResponder];
    
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationRepeatAutoreverses:NO];
    CGPoint center = self.pickMianView.center;
    center.y -= [UIScreen mainScreen].bounds.size.height;
    self.pickMianView.center = center;
    [UIView commitAnimations];
    
    self.anNiuJi = 1;
    
//    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
//    calendarPicker.today = [NSDate date];
//    calendarPicker.date = calendarPicker.today;
//    calendarPicker.frame = CGRectMake(0, 100, self.view.frame.size.width, 352);
//    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
//
//        if (month<10) {
//            month+=10;
//        }
//
//        if (year<10) {
//            year+=10;
//        }
//        zhuCeTimeLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year,(long)month,(long)day];
//    };
}

-(void)faZhengTimeBtChick:(UIButton *)sender
{
    [faNumTextField resignFirstResponder];
    [carIdentifyTextField resignFirstResponder];
    
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationRepeatAutoreverses:NO];
    CGPoint center = self.pickMianView.center;
    center.y -= [UIScreen mainScreen].bounds.size.height;
    self.pickMianView.center = center;
    [UIView commitAnimations];
    
    self.anNiuJi = 2;
    
//    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
//    calendarPicker.today = [NSDate date];
//    calendarPicker.date = calendarPicker.today;
//    calendarPicker.frame = CGRectMake(0, 100, self.view.frame.size.width, 352);
//    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
//
//        if (month<10) {
//            month+=10;
//        }
//
//        if (year<10) {
//            year+=10;
//        }
//        faZhengTimeLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year,(long)month,day];
//    };
}

-(void)dangQianBuJU
{
    self.mianScrollView.backgroundColor = [UIColor clearColor];
    self.mianScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    [self.view addSubview:self.mianScrollView];
    
    CGFloat juahangJuLi = 0;
    UILabel *titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, juahangJuLi, kWindowW, 40)];
    titiLabel.font = [UIFont systemFontOfSize:14];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.backgroundColor = kRGBColor(230, 230, 230);
    titiLabel.text = @"请确认行驶证信息";
    [self.mianScrollView addSubview:titiLabel];
    juahangJuLi += 40;
    UIView *tupianView = [[UIView alloc]initWithFrame:CGRectMake(0, juahangJuLi, kWindowH, 80)];
    tupianView.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:tupianView];
    self.titileImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_launcher")];
    self.titileImageView.contentMode = UIViewContentModeScaleAspectFit;
    [tupianView addSubview:self.titileImageView];
    [self.titileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(75);
        make.centerX.mas_equalTo(self.view);
    }];
    juahangJuLi += 80;
    
    for (int i = 0; i<4; i++) {
        UIView *beijingViewEr = [[UIView alloc]init];
        beijingViewEr.backgroundColor = [UIColor whiteColor];
        if (i== 0) {
            beijingViewEr.frame = CGRectMake(0, juahangJuLi + 10, kWindowW, 30);
            juahangJuLi += 40;
        }else
        {
            beijingViewEr.frame = CGRectMake(0, juahangJuLi + 1, kWindowW, 30);
            juahangJuLi += 31;
        }
        [self.mianScrollView addSubview:beijingViewEr];
        
        UILabel *zuoLabel = [[UILabel alloc]init];
        zuoLabel.font = [UIFont systemFontOfSize:13];
        [beijingViewEr addSubview:zuoLabel];
        [zuoLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(beijingViewEr);
            make.width.mas_equalTo(100);
        }];
        
        if (i == 0) {
            zuoLabel.text = @"车辆识别代码";
            carIdentifyTextField = [[UITextField alloc]init];
            carIdentifyTextField.placeholder = @"车辆识别代码..";
            carIdentifyTextField.returnKeyType = UIReturnKeyDone;
            carIdentifyTextField.font = [UIFont systemFontOfSize:13];
            carIdentifyTextField.delegate = self;
            [beijingViewEr addSubview:carIdentifyTextField];
            [carIdentifyTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(115);
                make.centerY.mas_equalTo(zuoLabel);
                make.width.mas_equalTo(kWindowW-125);
            }];
            
        }else if (i == 1) {
            zuoLabel.text = @"发动机号";
            faNumTextField = [[UITextField alloc]init];
            faNumTextField.placeholder = @"发动机号..";
            faNumTextField.returnKeyType = UIReturnKeyDone;
            faNumTextField.font = [UIFont systemFontOfSize:13];
            faNumTextField.delegate = self;
            [beijingViewEr addSubview:faNumTextField];
            [faNumTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(115);
                make.centerY.mas_equalTo(zuoLabel);
                make.width.mas_equalTo(kWindowW-125);
            }];
            
        }else if (i == 2) {
            zuoLabel.text = @"注册日期";
            zhuCeTimeLabel = [[UILabel alloc]init];
            zhuCeTimeLabel.font = [UIFont systemFontOfSize:13];
            zhuCeTimeLabel.textAlignment = NSTextAlignmentLeft;
            zhuCeTimeLabel.textColor = [UIColor grayColor];
            zhuCeTimeLabel.text = @"请选择日期";
            [beijingViewEr addSubview:zhuCeTimeLabel];
            [zhuCeTimeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(115);
                make.centerY.mas_equalTo(zuoLabel);
                make.width.mas_equalTo(kWindowW-125);
            }];
            
            zhuCeTimeBt = [[UIButton alloc]init];
            [zhuCeTimeBt addTarget:self action:@selector(zhuCeTimeBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [beijingViewEr addSubview:zhuCeTimeBt];
            [zhuCeTimeBt  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(115);
                make.centerY.mas_equalTo(zuoLabel);
                make.width.mas_equalTo(kWindowW-125);
            }];
            
        }else if (i == 3) {
            zuoLabel.text = @"发证日期";
            
            faZhengTimeLabel = [[UILabel alloc]init];
            faZhengTimeLabel.font = [UIFont systemFontOfSize:13];
            faZhengTimeLabel.textAlignment = NSTextAlignmentLeft;
            faZhengTimeLabel.textColor = [UIColor grayColor];
            faZhengTimeLabel.text = @"请选择日期";
            [beijingViewEr addSubview:faZhengTimeLabel];
            [faZhengTimeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(115);
                make.centerY.mas_equalTo(zuoLabel);
                make.width.mas_equalTo(kWindowW-125);
            }];
            
            
            faZhengTimeBt = [[UIButton alloc]init];
            [faZhengTimeBt addTarget:self action:@selector(faZhengTimeBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [beijingViewEr addSubview:faZhengTimeBt];
            [faZhengTimeBt  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(115);
                make.centerY.mas_equalTo(zuoLabel);
                make.width.mas_equalTo(kWindowW-125);
            }];
            
        }
        
    }
    
    UILabel *carColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, juahangJuLi, kWindowW-10, 30)];
    carColorLabel.textColor = [UIColor grayColor];
    carColorLabel.font = [UIFont systemFontOfSize:14];
    carColorLabel.text = @"车身颜色";
    juahangJuLi += 30;
    [self.mianScrollView addSubview:carColorLabel];
    
    UIView *baiView3 = [[UIView alloc]initWithFrame:CGRectMake(0, juahangJuLi, kWindowW, 80)];
    juahangJuLi += 80;
    baiView3.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:baiView3];
    
    CGFloat  labelWight = kWindowW/4-10;
    for (int i = 0; i<self.colorArray.count; i++) {
        UIButton *coLabelbt = [[UIButton alloc]init];
        [coLabelbt setTitle:self.colorArray[i] forState:(UIControlStateNormal)];
        [coLabelbt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [coLabelbt setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        coLabelbt.tag = 5000 + i;
        [coLabelbt addTarget:self action:@selector(coLabelbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [coLabelbt  setBackgroundImage:[UIImage imageWithUIColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [coLabelbt  setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
        [coLabelbt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [coLabelbt.layer setCornerRadius:3];
        [coLabelbt.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [coLabelbt.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [baiView3 addSubview:coLabelbt];
        if (i<6) {
            [coLabelbt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((kWindowW/4)*(i%4)+5);
                make.top.mas_equalTo((i/4)*40+10);
                make.width.mas_equalTo(labelWight);
                make.height.mas_equalTo(25);
            }];
        }else
        {
//            coLabelbt.imageEdgeInsets = UIEdgeInsetsMake(3, -10, 3, labelWight);
//            [coLabelbt setImage:DJImageNamed(@"xiugai") forState:(UIControlStateNormal)];
            [coLabelbt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((kWindowW/4)*(i%4)+5);
                make.top.mas_equalTo((i/4)*40+10);
                make.width.mas_equalTo(labelWight*2-20);
                make.height.mas_equalTo(25);
            }];
        }
    }
    
    UILabel *carLeixLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, juahangJuLi, kWindowW-10, 30)];
    carLeixLabel.textColor = [UIColor grayColor];
    carLeixLabel.font = [UIFont systemFontOfSize:14];
    carLeixLabel.text = @"车辆类型";
    juahangJuLi += 30;
    [self.mianScrollView addSubview:carLeixLabel];
    
    UIView *baiCarLeiView = [[UIView alloc]initWithFrame:CGRectMake(0, juahangJuLi, kWindowW, 70)];
    juahangJuLi += 70;
    baiCarLeiView.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:baiCarLeiView];
    CGFloat  baiCarWight = kWindowW/4-20;
    for (int i = 0; i<4; i++) {
        UIButton *baiCarbt = [[UIButton alloc]init];
        baiCarbt.tag = 6000+i;
        [baiCarbt addTarget:self action:@selector(baiCarbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [baiCarLeiView addSubview:baiCarbt];
        [baiCarbt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((kWindowW/4)*i+10);
            make.top.mas_equalTo((i/4)*40+10);
            make.width.mas_equalTo(baiCarWight);
            make.height.mas_equalTo(45);
        }];
        UILabel *baiCarLabel = [[UILabel alloc]init];
        baiCarLabel.font = [UIFont systemFontOfSize:12];
        baiCarLabel.adjustsFontSizeToFitWidth = YES;
        baiCarLabel.textColor = [UIColor grayColor];
        baiCarLabel.textAlignment = NSTextAlignmentCenter;
        [baiCarLeiView addSubview:baiCarLabel];
        [baiCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((kWindowW/4)*i+10);
            make.top.mas_equalTo((i/4)*40+35);
            make.width.mas_equalTo(baiCarWight);
            make.height.mas_equalTo(45);
        }];
        
        baiCarbt.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        baiCarbt.imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (i==0) {
            [baiCarbt setImage:DJImageNamed(@"a_car_false") forState:(UIControlStateNormal)];
            [baiCarbt setImage:DJImageNamed(@"a_car_true") forState:(UIControlStateSelected)];
            baiCarLabel.text = @"小型车";
        }else if (i==1) {
            [baiCarbt setImage:DJImageNamed(@"b_car_false") forState:(UIControlStateNormal)];
            [baiCarbt setImage:DJImageNamed(@"b_car_true") forState:(UIControlStateSelected)];
            baiCarLabel.text = @"大中型客车";
        }else if (i==2) {
            [baiCarbt setImage:DJImageNamed(@"c_car_false") forState:(UIControlStateNormal)];
            [baiCarbt setImage:DJImageNamed(@"c_car_true") forState:(UIControlStateSelected)];
            baiCarLabel.text = @"大型货车";
        }else if (i==3) {
            [baiCarbt setImage:DJImageNamed(@"d_car_false") forState:(UIControlStateNormal)];
            [baiCarbt setImage:DJImageNamed(@"d_car_true") forState:(UIControlStateSelected)];
            baiCarLabel.text = @"其他";
        }
        
    }
    
    UIView *xiaZuiHouView = [[UIView alloc]initWithFrame:CGRectMake(0, juahangJuLi, kWindowW, 120)];
    xiaZuiHouView.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:xiaZuiHouView];
    juahangJuLi += 120;
    
    UIButton *okButton = [[UIButton alloc]init];
    [okButton setTitle:@"确定" forState:(UIControlStateNormal)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [okButton.layer setCornerRadius:3];
    [okButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [xiaZuiHouView addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *chongXinButton = [[UIButton alloc]init];
    [chongXinButton setTitle:@"重新扫描" forState:(UIControlStateNormal)];
    [chongXinButton addTarget:self action:@selector(chongXinButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [chongXinButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [chongXinButton.layer setCornerRadius:3];
    [chongXinButton.layer setBorderWidth:1];//设置边界的宽度
    //设置按钮的边界颜色
    [chongXinButton.layer setBorderColor:[kZhuTiColor CGColor]];
    [chongXinButton  setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    [xiaZuiHouView addSubview:chongXinButton];
    [chongXinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(okButton.mas_bottom).mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
    
    self.mianScrollView.contentSize = CGSizeMake(kWindowW, juahangJuLi);
}

-(void)chongXinButtonChick:(UIButton *)sender
{
    IDCardCameraViewController *cameraVC = [[IDCardCameraViewController alloc] init];
    cameraVC.recogType = 6;
    cameraVC.typeName = @"中国行驶证";
    cameraVC.recogOrientation = 0;
    cameraVC.suerViewColler = self;
    [self presentViewController:cameraVC animated:YES completion:nil];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@"\n"]) {
        [carIdentifyTextField resignFirstResponder];
        [faNumTextField resignFirstResponder];
        return NO;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (carIdentifyTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        
        if (carIdentifyTextField.text.length >= 17) {
            textField.text = [toBeString substringToIndex:asciiLengthIndexOfString(toBeString, 17)];
            [self showMessageWindowWithTitle:@"车辆识别代码必须是17位" point:self.view.center delay:1];
            return NO;
        }
        
        
        
//        数字和字母
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:kValidChar] invertedSet];

        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串

        BOOL canChange = [string isEqualToString:filtered];
        
        
        if (string.length == 0 ){return YES;}
        char commitChar = [string characterAtIndex:0];
        if (commitChar > 96 && commitChar < 123){
            NSString * uppercaseString = string.uppercaseString;
            NSString * str1 = [textField.text substringToIndex:range.location];
            NSString * str2 = [textField.text substringFromIndex:range.location];
            textField.text = [NSString stringWithFormat:@"%@%@%@",str1,uppercaseString,str2].uppercaseString;
            return NO;
        }
        
        return canChange;
        
    }
    
    if (faNumTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if (faNumTextField.text.length >=17) {
            textField.text = [toBeString substringToIndex:asciiLengthIndexOfString(toBeString, 17)];
            return NO;
            
        }
    }
    
    
    return YES;
}

- (NSInteger)comparewithDate:(NSString*)bDate withcurrentTimeString:(NSString *)currentTimeString
{
    
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"YYYY-MM-dd"];
    [dateformater setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    
    
    dta = [dateformater dateFromString:currentTimeString];
    dtb = [dateformater dateFromString:bDate];
    
    
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame)
    {
        //        相等  aa=0
        aa=0;
    }else if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else  if (result == NSOrderedDescending){
        //bDate比aDate小
        aa=-1;
    }else
    {
        aa = 5;
    }
    
    return aa;
    
}

-(void)okButtonChick:(UIButton *)sender
{
    if (carIdentifyTextField.text.length != 17) {
        [self showMessageWithContent:@"车辆识别码必须17位" point:self.view.center afterDelay:2.0];
        return;
    }
    self.chuanZhiDict.carvin = carIdentifyTextField.text;
    BOOL shiFouBeiJing = [[UserInfo shareInstance].isExplod boolValue];
    if (faNumTextField.text.length <= 0 && shiFouBeiJing == YES) {
        [self showMessageWithContent:@"请填写发动机号" point:self.view.center afterDelay:2.0];
        return;
    }
    self.chuanZhiDict.engine_number = faNumTextField.text;
    
    if (zhuCeTimeLabel.text.length <= 0) {
        self.chuanZhiDict.register_date = @"";
    }else{
        self.chuanZhiDict.register_date = zhuCeTimeLabel.text;
    }
    
    
    if (faZhengTimeLabel.text.length <= 0) {
        self.chuanZhiDict.issue_date = @"";
    }else{
        self.chuanZhiDict.issue_date = faZhengTimeLabel.text;
    }
    
    
    if ([self comparewithDate:zhuCeTimeLabel.text withcurrentTimeString:faZhengTimeLabel.text] == 1) {
        [self showMessageWithContent:@"发证日期必须大于注册日期或同一天" point:self.view.center afterDelay:2.0];
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    if ([self comparewithDate:faZhengTimeLabel.text withcurrentTimeString:currentTimeString] == 1) {
        [self showMessageWithContent:@"发证日期大于当前时间，请确认您的行驶证。" point:self.view.center afterDelay:2.0];
        return;
    }
    
    BOOL colorBool = NO;
    for (int i = 0; i<7; i++) {
        UIButton *bt = [self.mianScrollView viewWithTag:5000+i];
        if (bt.selected == YES) {
            colorBool = YES;
            self.chuanZhiDict.color = bt.titleLabel.text;
        }
    }
    if (colorBool == NO) {
        [self showMessageWithContent:@"请选择车身颜色" point:self.view.center afterDelay:2.0];
        return;
    }
    
    BOOL carTypeBool = NO;
    for (int i = 0; i<4; i++) {
        UIButton *bt = [self.mianScrollView viewWithTag:6000+i];
        if (bt.selected == YES) {
            carTypeBool = YES;
            if (i == 0) {
                self.chuanZhiDict.cartype = 1;
            }else if (i == 0) {
                self.chuanZhiDict.cartype = 2;
            }else if (i == 0) {
                self.chuanZhiDict.cartype = 3;
            }else{
                self.chuanZhiDict.cartype = 9;
            }
            
        }
    }
    
    if (carTypeBool == NO) {
        [self showMessageWithContent:@"请选择车身类型" point:self.view.center afterDelay:2.0];
        return;
    }
    
    if ((self.cropImagepath.length<=0)||(!self.cropImagepath)) {
        [self postZuiHouQueRenQingQiuWithImage:self.chuanZhiDict.images];
    }else{
        UIImage *image = [UIImage imageWithContentsOfFile:self.cropImagepath];
        self.titileImageView.image = image;
        NSMutableArray *arrar = [[NSMutableArray alloc]init];
        [arrar addObject:image];
        [self postShangChuanTuPianWithImage:arrar];
    }
}
/**
  按钮点击

 @param sender 车身颜色
 */
-(void)coLabelbtChick:(UIButton *)sender
{
    for (int i = 0; i<7; i++) {
        UIButton *bt = [self.mianScrollView viewWithTag:5000+i];
        bt.selected = NO;
    }
    if (sender.tag == 5006) {
        self.carColorView.hidden = NO;
        [self.view bringSubviewToFront:self.carColorView];
    }
    
    sender.selected = !sender.selected;
}

/**
 按钮点击

 @param sender 车辆类型
 */
-(void)baiCarbtChick:(UIButton *)sender
{
    for (int i = 0; i<4; i++) {
        UIButton *bt = [self.mianScrollView viewWithTag:6000+i];
        bt.selected = NO;
    }
    
    sender.selected = !sender.selected;
}




@end
