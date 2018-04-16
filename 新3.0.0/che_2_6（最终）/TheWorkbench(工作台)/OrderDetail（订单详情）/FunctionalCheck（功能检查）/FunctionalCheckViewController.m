//
//  FunctionalCheckViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//
#import "FunctionalCheckViewController.h"
#import "AccessoryEquipmentCell.h"
#import "HPGrowingTextView.h"
#import "FunctionalCheckModel.h"
#import "JieCheInformiTionVC.h"

@interface FunctionalCheckViewController ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate,SFSpeechRecognizerDelegate,SFSpeechRecognitionTaskDelegate>

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)HPGrowingTextView * schemeTextView;

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

@implementation FunctionalCheckViewController
- (void)viewWillDisappear:(BOOL)animated
{
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"功能检查" withBackButton:YES];
    
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.functions_remark = @"";
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    [self postHuoQuOrder_functions];
    
    //发送语音认证请求(首先要判断设备是否支持语音识别功能
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
-(void)postHuoQuOrder_functions
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/order_functions" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        weakSelf.functions_remark = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"functions_remark")];
        NSArray *functions = KISDictionaryHaveKey(dataDic, @"functions");
        for (int i = 0; i<functions.count; i++) {
            FunctionalCheckModel *model = [[FunctionalCheckModel alloc]init];
            [model setDataShuJu:functions[i]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"Cell";
    AccessoryEquipmentCell *cell = (AccessoryEquipmentCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AccessoryEquipmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    FunctionalCheckModel *model = self.dataArray[indexPath.row];
    
    cell.zuoTitelLabel.text = model.name;
    if (model.dataBool == YES) {
        kWeakSelf(weakSelf)
        cell.zuoYouBt.dianJiSelectBlock = ^(BOOL dianSender) {
            FunctionalCheckModel *model = self.dataArray[indexPath.row];
            model.dataBool = dianSender;
            [weakSelf.mainTableView  reloadData];
        };
    }else{
        kWeakSelf(weakSelf)
        cell.zuoYouBt.dianJiSelectBlock = ^(BOOL dianSender) {
            FunctionalCheckModel *model = self.dataArray[indexPath.row];
            model.dataBool = dianSender;
            [weakSelf.mainTableView  reloadData];
        };
    }
    cell.zuoYouBt.dianJiSelect = model.dataBool;
    [cell.zuoYouBt setBuJuOrZhuangTai];
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FunctionalCheckModel *model = self.dataArray[indexPath.row];
    model.dataBool = !model.dataBool;
    [self.mainTableView  reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 230;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView  = [[UIView alloc]init];
    footView.backgroundColor = self.view.backgroundColor;
    
    UIView * view=[[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:0.5];
    [view.layer setBorderColor:kLineBgColor.CGColor];
    [footView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-136/2);
        make.height.mas_equalTo(155);
    }];
    
    UIButton * btn =[[UIButton alloc]init];
    [btn setBackgroundImage: [UIImage imageNamed:@"yuyinBule"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(yuyinClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6);
        make.top.mas_equalTo(6);
        make.width.mas_equalTo(76/2);
        make.height.mas_equalTo(76/2);
    }];
    
    
    self.schemeTextView = [[HPGrowingTextView alloc]init];
    self.schemeTextView.text = self.functions_remark;
    self.schemeTextView.isScrollable = NO;
    self.schemeTextView.minNumberOfLines = 1;
    self.schemeTextView.maxNumberOfLines = 6;
    self.schemeTextView.font = [UIFont systemFontOfSize:13];
    self.schemeTextView.delegate = self;
    self.schemeTextView.returnKeyType = UIReturnKeyDone;
    self.schemeTextView.placeholder = @"备注:请输入备注..";
    self.schemeTextView.placeholderColor = kRGBColor(220, 220, 220);
    [view addSubview:self.schemeTextView];
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

-(void)queDingBtChick:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    
    NSString *exist = @"";
    for (int i = 0; i<self.dataArray.count; i++) {
        FunctionalCheckModel *model = self.dataArray[i];
        if (model.dataBool == YES) {
            if (exist.length>0) {
                exist = [NSString stringWithFormat:@"%@,%@",exist,model.overhaul_id];
            }else{
                exist = model.overhaul_id;
            }
        }
    }
    
    [mDict setObject:exist forKey:@"abnormal"];
    [mDict setObject:self.schemeTextView.text forKey:@"functions_remark"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/pull_functions" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (weakSelf.shiFouFanHui == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            JieCheInformiTionVC *vc = [[JieCheInformiTionVC alloc]init];
            vc.chuaOrdercode = weakSelf.chuaOrdercode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(id error) {
        
    }];
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
        self.functions_remark = text;
        return YES;
    }
    
}

#pragma mark--yuyin
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
        NSLog(@"%@",error.userInfo);
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
            self.functions_remark=str;
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

