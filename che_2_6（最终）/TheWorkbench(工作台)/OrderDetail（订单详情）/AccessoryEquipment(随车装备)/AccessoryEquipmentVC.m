//
//  AccessoryEquipmentVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AccessoryEquipmentVC.h"
#import "AccessoryEquiSuiCheCell.h"
#import "AccessoryEquipmentModel.h"
#import "HPGrowingTextView.h"
#import "FunctionalCheckViewController.h"

@interface AccessoryEquipmentVC ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate,SFSpeechRecognizerDelegate,SFSpeechRecognitionTaskDelegate>

@property(nonatomic,strong)HPGrowingTextView *schemeTextView;

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)NSString *goods_remarkStr;



@property(nonatomic,strong)SFSpeechRecognizer *bufferRec;//语音识别器
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest *bufferRequest; //识别请求
@property(nonatomic,strong)SFSpeechRecognitionTask *bufferTask;//语音识别任务
@property(nonatomic,strong)AVAudioEngine *bufferEngine;//录音引擎
@property(nonatomic,strong)AVAudioInputNode *buffeInputNode;
/** 录音设备 */
@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 监听设备 */
@property (nonatomic, strong) AVAudioRecorder *monitor;
/** 监听器 URL */
@property (nonatomic, strong) NSURL *monitorURL;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic,assign)BOOL shiFouShiJianDao;
@end

@implementation AccessoryEquipmentVC

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
    ///关闭定时器
    if(m_timer != nil)
    {
        [m_timer invalidate];
        m_timer = nil;
    }
    leftTime = 10;
    self.shiFouShiJianDao = YES;
    self.fuCengImageView.hidden = YES;
    [self.bufferEngine stop];
    [self.buffeInputNode removeTapOnBus:0];
    self.bufferRequest = nil;
    self.bufferTask = nil;
    [self.timer invalidate];
    self.timer = nil;
    // 监听器也停止
    [self.monitor stop];
    // 删除监听器的录音文件
    [self.monitor deleteRecording];
}
#pragma 键盘的通知
- (void) keyboardWillShow:(NSNotification*)noti
{
    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainTableView.frame = CGRectMake(0, kNavBarHeight-keyboardFrameBeginRect.size.height+70, kWindowW, kWindowH-kNavBarHeight);
        [weakSelf setNavBarToBring];
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainTableView.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"随车装备" withBackButton:YES];
    
    self.goods_remarkStr = @"";
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    [self postHuoQuOrder_goods];
    //发送语音认证请求(首先要判断设备是否支持语音识别功能
    self.bufferRec.delegate = self;
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        bool isButtonEnabled = false;
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                isButtonEnabled = true;
                NPrintLog(@"可以语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                isButtonEnabled = false;
                NPrintLog(@"用户被拒绝访问语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                isButtonEnabled = false;
                NPrintLog(@"不能在该设备上进行语音识别");
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                isButtonEnabled = false;
                NPrintLog(@"没有授权语音识别");
                break;
            default:
                break;
        }
    }];
    self.fuCengImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWindowW/2-60, kWindowH/2-60, 120, 120)];
    self.fuCengImageView.image=[UIImage imageNamed:@"yuyin-1"];
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
    // 1. 音频会话
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
    // 参数设置
    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat: 14400.0], AVSampleRateKey,
                                    [NSNumber numberWithInt: kAudioFormatAppleIMA4], AVFormatIDKey,
                                    [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                                    nil];
    // 监听器
    NSString *monitorPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"monitor.caf"];
    _monitorURL = [NSURL fileURLWithPath:monitorPath];
    _monitor = [[AVAudioRecorder alloc] initWithURL:_monitorURL settings:recordSettings error:NULL];
    _monitor.meteringEnabled = YES;
}

-(void)postHuoQuOrder_goods
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/order_goods" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        NSArray *goods = KISDictionaryHaveKey(dataDic, @"goods");
        weakSelf.goods_remarkStr = KISDictionaryHaveKey(dataDic, @"goods_remark");
        for (int i = 0; i<goods.count; i++) {
            AccessoryEquipmentModel *model = [[AccessoryEquipmentModel alloc]init];
            [model setDataShuJu:goods[i]];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"Cell";
    AccessoryEquiSuiCheCell *cell = (AccessoryEquiSuiCheCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AccessoryEquiSuiCheCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    AccessoryEquipmentModel *model = self.dataArray[indexPath.row];
    
    cell.zuoTitelLabel.text = model.name;
    if (model.dataBool == YES) {
        cell.xuanZhongImaheView.image = [UIImage imageNamed:@"rect_check_box_selected"];
    }else{
        cell.xuanZhongImaheView.image = [UIImage imageNamed:@"rect_check_box_unselect"];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AccessoryEquipmentModel *model = self.dataArray[indexPath.row];
    model.dataBool = !model.dataBool;
    [self.mainTableView  reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 230;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView  = [[UIView alloc]init];
    //    UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWindowW-20, 40)];
    //    shuoMingLabel.textColor = [UIColor grayColor];
    //    shuoMingLabel.text = @"备注";
    //    [footView addSubview:shuoMingLabel];
    //
    //    UIView *whiBeiJingView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 60)];
    //    whiBeiJingView.backgroundColor = [UIColor whiteColor];
    //    [footView addSubview:whiBeiJingView];
    UIView * mainView = [[UIView alloc]init];
    mainView.backgroundColor=[UIColor whiteColor];
    [mainView.layer setMasksToBounds:YES];
    [mainView.layer setBorderWidth:0.5];
    [mainView.layer setBorderColor:kLineBgColor.CGColor];
    [footView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(155);
        make.bottom.mas_equalTo(-136/2);
    }];
    
    UIButton * btn =[[UIButton alloc]init];
    [btn setBackgroundImage: [UIImage imageNamed:@"yuyinBule"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(yuyinClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6);
        make.top.mas_equalTo(6);
        make.width.mas_equalTo(76/2);
        make.height.mas_equalTo(76/2);
    }];
    
    
    self.schemeTextView = [[HPGrowingTextView alloc]init];
    self.schemeTextView.isScrollable = NO;
    self.schemeTextView.text = self.goods_remarkStr;
    self.schemeTextView.minNumberOfLines = 1;
    self.schemeTextView.maxNumberOfLines = 6;
    self.schemeTextView.font = [UIFont systemFontOfSize:13];
    self.schemeTextView.delegate = self;
    self.schemeTextView.returnKeyType = UIReturnKeyDone;
    self.schemeTextView.placeholder = @"备注:请输入备注......";
    self.schemeTextView.placeholderColor = kRGBColor(220, 220, 220);
    [mainView addSubview:self.schemeTextView];
    [self.schemeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWindowW-38-40);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    if (self.shiFouFanHui == YES) {
        [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    }else{
        [queDingBt setTitle:@"下一步" forState:(UIControlStateNormal)];
    }
    
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [footView addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(-13);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(47);
    }];
    
    
    return footView;
}


- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self.goods_remarkStr = self.schemeTextView.text;
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

-(void)queDingBtChick:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    
    NSString *exist = @"";
    for (int i = 0; i<self.dataArray.count; i++) {
        AccessoryEquipmentModel *model = self.dataArray[i];
        if (model.dataBool == YES) {
            if (exist.length>0) {
                exist = [NSString stringWithFormat:@"%@,%@",exist,model.overhaul_id];
            }else{
                exist = model.overhaul_id;
            }
        }
    }
    
    [mDict setObject:exist forKey:@"exist"];
    [mDict setObject:self.schemeTextView.text forKey:@"goods_remark"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/pull_goods" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (weakSelf.shiFouFanHui == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            FunctionalCheckViewController *vc = [[FunctionalCheckViewController alloc]init];
            vc.chuaOrdercode = weakSelf.chuaOrdercode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(id error) {
        
    }];
}
#pragma mark ---yuyin
-(void)yuyinClick:(UIButton*)sender
{
    self.shiFouJieShuLuYin = NO;
    leftTime = 10;
    [self setupTimer];
    self.bufferRec = [[SFSpeechRecognizer alloc]initWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    self.bufferEngine = [[AVAudioEngine alloc]init];
    self.buffeInputNode = [self.bufferEngine inputNode];
    if (_bufferTask != nil) {
        [_bufferTask cancel];
        _bufferTask = nil;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    [audioSession setActive:true error:nil];
    // block外的代码也都是准备工作，参数初始设置等
    self.bufferRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    self.bufferRequest.shouldReportPartialResults = true;
    kWeakSelf(weakSelf)
    self.bufferTask = [self.bufferRec recognitionTaskWithRequest:self.bufferRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        NPrintLog(@"新12312434124");
        if (result != nil) {
            weakSelf.yuYingZhuanHStr = result.bestTranscription.formattedString;
        }
        if (error != nil) {
            NSLog(@"%@",error.userInfo);
        }
    }];
    // 监听一个标识位并拼接流文件
    AVAudioFormat *format =[self.buffeInputNode outputFormatForBus:0];
    [self.buffeInputNode installTapOnBus:0 bufferSize:1024 format:format block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [weakSelf.bufferRequest appendAudioPCMBuffer:buffer];
    }];
    // 准备并启动引擎
    [self.bufferEngine prepare];
    NSError *error = nil;
    if (![self.bufferEngine startAndReturnError:&error]) {
        NPrintLog(@"%@",error.userInfo);
    };
    [self setDaoJiShi];
}

//语音倒计时
- (void)setDaoJiShi
{
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
    }else
    {
        if(m_timer != nil)
        {
            [m_timer invalidate];
            m_timer = nil;
        }
        leftTime = 10;
        self.shiFouShiJianDao = YES;
        self.fuCengImageView.hidden = YES;
        [self.bufferEngine stop];
        [self.buffeInputNode removeTapOnBus:0];
        self.bufferRequest = nil;
        self.bufferTask = nil;
        [self.timer invalidate];
        self.timer = nil;
        // 监听器也停止
        [self.monitor stop];
        // 删除监听器的录音文件
        [self.monitor deleteRecording];
        if (self.yuYingZhuanHStr.length>0) {
            NSString *str = [NSString stringWithFormat:@"%@%@",self.schemeTextView.text,self.yuYingZhuanHStr];
            self.schemeTextView.text = str;
            self.goods_remarkStr=str;
        }else{
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:nil message:@"识别失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [al show];
        }
    }
    leftTime --;
}
// 监听开始与结束的方法
- (void)setupTimer {
    [self.monitor record];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
- (void)updateTimer {
    // 不更新就没法用了
    [self.monitor updateMeters];
    // 获得0声道的音量，完全没有声音-160.0，0是最大音量
    float power = [self.monitor peakPowerForChannel:0];
    if(power>-10){
        self.fuCengImageView.image=[UIImage imageNamed:@"yuyin-3"];
    }else if(power>-20){
        self.fuCengImageView.image=[UIImage imageNamed:@"yuyin-2"];
    }else if(power>-30){
        self.fuCengImageView.image=[UIImage imageNamed:@"yuyin-1"];
    }
}
@end

