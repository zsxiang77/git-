//
//  LCBottomView.m
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LCBottomView.h"
#import "LCMessageViewModel.h"
#import "UIImage+ImageWithColor.h"
#import <Speech/Speech.h>
@interface LCBottomView() <UITextFieldDelegate,SFSpeechRecognizerDelegate>
//@property (nonatomic, strong) UIImageView *leftBT;
@property(nonatomic,strong)UIButton *leftBT;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UIButton *xiaYibuBT;
@property (nonatomic,strong) UIButton *changanYuyinBtn;
@property (nonatomic, strong) LCBottomView *bottomView;


@property(nonatomic,strong)SFSpeechRecognizer *bufferRec;//语音识别器
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest *bufferRequest; //识别请求
@property(nonatomic,strong)SFSpeechRecognitionTask *bufferTask;//语音识别任务
@property(nonatomic,strong)AVAudioEngine *bufferEngine;//录音引擎
@property(nonatomic,strong)AVAudioInputNode *buffeInputNode;


@property(nonatomic,assign)BOOL shiFouShiJianDao;
@end

@implementation LCBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillChangeFream:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        self.frame = CGRectMake(0, kWindowH-50, kScreenWidth,50);
        self.backgroundColor = UIColorHex(#f6f6f6);
    //发送语音认证请求(首先要判断设备是否支持语音识别功能
    //语音
    self.bufferRec.delegate = self;
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        bool isButtonEnabled = false;
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                isButtonEnabled = true;
                NSLog(@"可以语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                isButtonEnabled = false;
                NSLog(@"用户被拒绝访问语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                isButtonEnabled = false;
                NSLog(@"不能在该设备上进行语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                isButtonEnabled = false;
                NSLog(@"没有授权语音识别");
                break;
            default:
                break;
        }
    }];
        
        self.fuCengImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWindowW/2-60, kWindowH/2-60, 120, 120)];
        self.fuCengImageView.image=[UIImage imageNamed:@"WechatIMG19"];
        self.fuCengImageView.hidden = YES;
        self.yuyinTime=[[UILabel alloc]init];
        self.yuyinTime.frame=CGRectMake(0, 95, 120, 20);
        self.yuyinTime.textColor=[UIColor whiteColor];
        self.yuyinTime.font=[UIFont systemFontOfSize:13];
        self.yuyinTime.textAlignment = NSTextAlignmentCenter;
        [self.fuCengImageView addSubview:self.yuyinTime];
        
        
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.fuCengImageView];
    }
    return self;
}

- (void)setUpViews{
    self.leftBT = ({
//        UIImageView *im = [[UIImageView alloc]init];
//        [self addSubview:im];
//        im.userInteractionEnabled = YES;
//        im.image = [UIImage imageNamed:@"语音图标"];
//        im.contentMode = UIViewContentModeScaleAspectFit;
//        [im mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(0);
//            make.left.mas_offset(11.5);
//            make.size.mas_equalTo(CGSizeMake(23.5, 23.5));
//        }];
        
        //语音输入按钮
        UIButton * btn=[[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"语音图标"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(3,3,3,3);
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(11.5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
          //  make.size.mas_equalTo(CGSizeMake(25.5, 25.5));
        }];
        [btn addTarget:self action:@selector(yuyinanANniuClick:) forControlEvents:UIControlEventTouchUpInside];
        @weakify(self)
        btn;
    });
    
    self.leftBT.hidden = NO;
    
    self.xiaYibuBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [self addSubview:bt];
        bt.backgroundColor = UIColorHex(#4A90E2);
        [bt setTitle:@"下一步" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];//[UIFont systemFontOfSize:14];
        [bt setTitleColor:UIColorHex(#ffffff) forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(114);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            if (!LC_isStrEmpty(self.textFiled.text)) {
                LCMessageViewModel *model = [LCMessageViewModel new];
                model.message = self.textFiled.text;
                NSDate *date = [[NSDate alloc]init];
                model.timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //@"yyyy-MM-dd HH:mm:ss zzz"
                // 2018-02-05 23:36:55 GMT+8
                [dateFormatter setDateFormat:@"MM-dd HH:mm"];
                model.time = [dateFormatter stringFromDate:date];
                NSLog(@"currentDateString = %@",model.time);
                [MobClick event:@"Diagnosis_Self_Motion_Manual_Operation"];
                !self.sendMessage ? : self.sendMessage(model);
                self.textFiled.text = nil;
            }
            !self.nextStep ? : self.nextStep();
            [self hidenKeyboard];
        }];
        bt;
    });
    
    
    
    
    self.textFiled = [UITextField new];
    _textFiled.delegate = self;
    _textFiled.keyboardType = UIKeyboardTypeDefault;
    _textFiled.returnKeyType = UIReturnKeySend;
    _textFiled.layer.cornerRadius = 2.5;
    _textFiled.layer.borderColor = UIColorHex(#C2C2C2).CGColor;
    _textFiled.layer.borderWidth = 0.5;
    [self addSubview:_textFiled];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftBT.mas_right).mas_equalTo(5);
//        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-125);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    
    //长安点击语音
    self.changanYuyinBtn=({
        UIButton * Cbtn=[[UIButton alloc]init];
        [Cbtn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [Cbtn setTitleColor:kRGBColor(102, 102, 102) forState:UIControlStateNormal];
        [Cbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        Cbtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        Cbtn.layer.cornerRadius=2.5;
        Cbtn.layer.masksToBounds=YES;
        Cbtn.backgroundColor=[UIColor whiteColor];
        [Cbtn addTarget:self action:@selector(anzhaunSpenckClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:Cbtn];
        [Cbtn addTarget:self action:@selector(speakBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [Cbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-125);
            make.left.mas_equalTo(self.leftBT.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
        Cbtn;
    });
    [self bringSubviewToFront:self.changanYuyinBtn];
    self.changanYuyinBtn.hidden=NO;
self.superViewController.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan=NO;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (!LC_isStrEmpty(textField.text)) {
        LCMessageViewModel *model = [LCMessageViewModel new];
        model.message = textField.text;
        
        NSDate *date = [[NSDate alloc]init];
        model.timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //@"yyyy-MM-dd HH:mm:ss zzz"
        // 2018-02-05 23:36:55 GMT+8
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        model.time = [dateFormatter stringFromDate:date];
        NSLog(@"currentDateString = %@",model.time);
        !self.sendMessage ? : self.sendMessage(model);
        textField.text = nil;
    }
    return YES;
}

- (void)hidenKeyboard{
    if ([self.textFiled canResignFirstResponder]) {
        [self.textFiled resignFirstResponder];
    }
}

- (void)keyboardWillChangeFream:(NSNotification *)fication{
//    NSLog(@"----- %@",fication.userInfo); //
    CGRect endframe = [[fication.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect endf = CGRectMake(0, endframe.origin.y-50, kScreenWidth, 50);
    NSTimeInterval time  = [[fication.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = endf;
    }];
    
    if ((endframe.origin.y-kWindowH)<(-10)) {
        self.xiaYibuBT.hidden = YES;
        [self.textFiled mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.leftBT.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(-8);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
    }else{
        self.xiaYibuBT.hidden = NO;
        [self.textFiled mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.leftBT.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(-125);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
    }
}

#pragma mark - UIGestureRecognizerDelegate
-(void)startRecording{
    self.bufferRec = [[SFSpeechRecognizer alloc]initWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    self.bufferEngine = [[AVAudioEngine alloc]init];
    self.buffeInputNode = [self.bufferEngine inputNode];
    
    if (_bufferTask != nil) {
        [_bufferTask cancel];
        _bufferTask = nil;
    }
    
    if (!audioSession) {
        audioSession = [AVAudioSession sharedInstance];
    }
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    [audioSession setActive:true error:nil];
    
    // block外的代码也都是准备工作，参数初始设置等
    self.bufferRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    self.bufferRequest.shouldReportPartialResults = true;
    kWeakSelf(weakSelf)
    self.bufferTask = [self.bufferRec recognitionTaskWithRequest:self.bufferRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (result != nil) {
            NSString*ste= result.bestTranscription.formattedString;
            NSLog(@"语音识别-----%@",ste);
            weakSelf.yuYingZhuanHStr = ste;
        }
        if (error != nil) {
        }
    }];
    // 监听一个标识位并拼接流文件
    AVAudioFormat *format =[self.buffeInputNode outputFormatForBus:0];
    [self.buffeInputNode installTapOnBus:0 bufferSize:1024 format:format block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.bufferRequest appendAudioPCMBuffer:buffer];
    }];
    
    // 准备并启动引擎
    [self.bufferEngine prepare];
    NSError *error = nil;
    if (![self.bufferEngine startAndReturnError:&error]) {

    };
}
//语音按钮点击事件
-(void)yuyinanANniuClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.textFiled.hidden = NO;
        self.changanYuyinBtn.hidden=YES;
        [_textFiled becomeFirstResponder];
    }else{
        self.textFiled.hidden = YES;
        self.changanYuyinBtn.hidden=NO;
        
        [_textFiled resignFirstResponder];
    }
    [self bringSubviewToFront:self.changanYuyinBtn];
    
}
#pragma mark - 点击
//长安说话
-(void)anzhaunSpenckClick:(UIButton*)sander
{
    self.shiFouShiJianDao = NO;
    self.yuYingZhuanHStr = @"";
<<<<<<< Updated upstream
    
    NSLog(@"开始录音");
=======
    self.fuCengImageView.hidden = NO;
    NPrintLog(@"开始录音");
>>>>>>> Stashed changes
    [self startRecording];
    [sander setTitle:@"松开 结束" forState:UIControlStateNormal];
    self.shiFouJieShuLuYin = NO;
    leftTime = 15;
    [self setDaoJiShi];
    
    
//    [self yuyindaojishiWirhShiJian:15];
}
//结束语音
-(void)speakBtnPress:(UIButton*)sender
{
    leftTime = 15;
    if (self.shiFouShiJianDao) {
        return;
    }
    self.shiFouJieShuLuYin = YES;
    self.fuCengImageView.hidden = YES;
    NPrintLog(@"结束录音");
    [sender setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.bufferEngine stop];
    [self.buffeInputNode removeTapOnBus:0];
    self.bufferRequest = nil;
    self.bufferTask = nil;
    
    LCMessageViewModel *model = [LCMessageViewModel new];
    model.message = self.yuYingZhuanHStr;
    NSDate *date = [[NSDate alloc]init];
    model.timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //@"yyyy-MM-dd HH:mm:ss zzz"
    // 2018-02-05 23:36:55 GMT+8
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    model.time = [dateFormatter stringFromDate:date];
    if (self.yuYingZhuanHStr.length>0) {
        [MobClick event:@"Diagnosis_Self_Motion"];
        !self.sendMessage ? : self.sendMessage(model);
    }
}

//语音倒计时

- (void)setDaoJiShi
{
    
    NPrintLog(@"12412414124");
    if(m_timer != nil)
    {
        [m_timer invalidate];
        m_timer = nil;
    }
    
    m_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(refreshLeftTime)
                                             userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
}
- (void)refreshLeftTime
{

    if (leftTime > 0)
    {
        if (self.shiFouJieShuLuYin) {
            if(m_timer != nil)
            {
                [m_timer invalidate];
                m_timer = nil;
            }
            return;
        }
        self.yuyinTime.text=[NSString stringWithFormat:@"倒计时:%lds",leftTime];
        self.fuCengImageView.hidden = NO;
        [self startRecording];
    }else
    {
        if(m_timer != nil)
        {
            [m_timer invalidate];
            m_timer = nil;
        }
        leftTime = 15;
        self.shiFouShiJianDao = YES;
        self.fuCengImageView.hidden = YES;
        NSLog(@"结束录音");
        [self.changanYuyinBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.bufferEngine stop];
        [self.buffeInputNode removeTapOnBus:0];
        self.bufferRequest = nil;
        self.bufferTask = nil;
        
        LCMessageViewModel *model = [LCMessageViewModel new];
        model.message = self.yuYingZhuanHStr;
        NSDate *date = [[NSDate alloc]init];
        model.timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        model.time = [dateFormatter stringFromDate:date];
        if (self.yuYingZhuanHStr.length>0) {
            [MobClick event:@"Diagnosis_Self_Motion"];
            !self.sendMessage ? : self.sendMessage(model);
        }
    }
    leftTime --;
}

@end
