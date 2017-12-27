//
//  QrCodeScanningViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/5.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "QrCodeScanningViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h> 
#import "WKWebViewViewController.h"


@interface QrCodeScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (strong,nonatomic) UIView *tupianSaoMiaoView;
//采集的设备
@property (strong,nonatomic) AVCaptureDevice * device;
//设备的输入
@property (strong,nonatomic) AVCaptureDeviceInput * input;
//输出
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
//采集流
@property (strong,nonatomic) AVCaptureSession * session;
//窗口
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * previewLayer;

//扫描框
@property (nonatomic, strong) UIView * view_bg;
//扫描线
@property (nonatomic, strong) CALayer * layer_scanLine;
//提示语
@property (nonatomic, strong) UILabel * lab_word;
//扫描线定时器
@property (nonatomic, strong) NSTimer * timer;

@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;


@end

@implementation QrCodeScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"二维码扫描" withBackButton:YES];
    
    [self initialize];
}
//初始化相机
- (void) initialize
{
    //判断摄像头授权
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"未获得授权使用摄像头" message:@"请在iOS '设置-隐私-相机' 中打开" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alert show];
        return;
    }
    
    UIButton* imaegScanBt = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW-80, 20, 60, 44)];
    [imaegScanBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [imaegScanBt setTitle:@"图片" forState:(UIControlStateNormal)];
    imaegScanBt.backgroundColor = [UIColor clearColor];
    [imaegScanBt addTarget:self action:@selector(imaegScanBtButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [m_baseTopView addSubview:imaegScanBt];
    
    
    [self callCamera];
}

-(UIView *)tupianSaoMiaoView
{
    if (!_tupianSaoMiaoView) {
        _tupianSaoMiaoView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
        _tupianSaoMiaoView.hidden = YES;
        _tupianSaoMiaoView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tupianSaoMiaoView];
        [self.view bringSubviewToFront:_tupianSaoMiaoView];
    }
    return _tupianSaoMiaoView;
}

-(void)imaegScanBtButtonClick:(UIButton *)sender
{
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
    
    

}


//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
    self.tupianSaoMiaoView.hidden = NO;
    [self.view bringSubviewToFront:self.tupianSaoMiaoView];

    UIImage *hbImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    UIImageView * scanZomeBack=[[UIImageView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    scanZomeBack.backgroundColor = [UIColor clearColor];
    scanZomeBack.contentMode =UIViewContentModeScaleAspectFit;
    scanZomeBack.image = hbImage;
    //添加一个背景图片
    //0.15意思为距离屏幕左右距离各为0.15*width；
    //0.25意思为距离屏幕上下距离各为0.25*height;
    //0.7意思为扫描横向范围为0.7*width;
    //0.5意思为扫描纵向范围为0.5*height;
    CGRect mImagerect = CGRectMake((kWindowW-(0.7*kWindowW))/2, 20,0.7*kWindowW,0.5*kWindowH);
    [scanZomeBack setFrame:mImagerect];
    [self.tupianSaoMiaoView addSubview:scanZomeBack];
    
    
    [self getURLWithImage:hbImage];
}

-(void)getURLWithImage:(UIImage *)img{
    
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        NSString *contents = result.text;
        NSLog(@"contents =%@",contents);
        WKWebViewViewController *vc= [[WKWebViewViewController alloc]init];
        vc.isNoShowNavBar = NO;
        vc.webUrl = contents;
        vc.navTitle = @"";
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        CIContext *context = [CIContext contextWithOptions:nil];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        CIImage *image = [CIImage imageWithCGImage:img.CGImage];
        NSArray *features = [detector featuresInImage:image];
        CIQRCodeFeature *feature = [features firstObject];
        
        NSString *qrResult = feature.messageString;
        
        WKWebViewViewController *vc= [[WKWebViewViewController alloc]init];
        vc.isNoShowNavBar = NO;
        vc.webUrl = qrResult;
        vc.navTitle = @"";
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}

//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/**
 *  调用系统相机
 */
- (void)callCamera
{
    //判断是否已授权
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == ALAuthorizationStatusDenied||authStatus == ALAuthorizationStatusRestricted) {
            [self setAlertControllerWithTitle:@"提示" message:@"请前往设置->隐私->相机授权应用拍照权限" actionTitle:@"确定"];
            return ;
        }
    }
    // 判断是否可以打开相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self startScan];
    } else {
        [self setAlertControllerWithTitle:@"提示" message:@"你没有相机" actionTitle:@"确定"];
    }
}
/**
 *  调用系统相册
 */
- (void)callPhoto
{
    //判断是否已授权
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusDenied) {
            [self setAlertControllerWithTitle:@"提示" message:@"请前往设置->隐私->相册授权应用访问相册权限" actionTitle:@"确定"];
            return;
        }
        
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //self.isReload = NO;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [self setAlertControllerWithTitle:@"提示" message:@"你没有相册" actionTitle:@"确定"];
    }
}


-(void)shouQuanset
{
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [self initQRScanView];
                }else{
                    NSLog(@"%@",@"访问受限");
                }
            }];
            break;
        }
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            NSLog(@"%@",@"访问受限");
            break;
        }
            
        case AVAuthorizationStatusAuthorized:{
            //获得权限
            break;
        }
        default:
            break;
    }
}

-(void)initQRScanView
{
    
}

#pragma mark - start saomiao

- (void)startScan {
    
    // Device 实例化设备   //获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input 设备输入     //创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    // Output 设备的输出  //创建输出流
    _output = [[AVCaptureMetadataOutput alloc]init];
    
    //设置代理   在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if (_output) {
        [_session addOutput:_output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        _output.metadataObjectTypes=a;
    }
    
    // Session         //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    _output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // Preview 扫描窗口设置
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _previewLayer.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH - kNavBarHeight);
    
    //设置扫描的范围，假如屏幕宽为width，屏幕高为height，下面参数含义为：
    //0.15意思为距离屏幕左右距离各为0.15*width；
    //0.25意思为距离屏幕上下距离各为0.25*height;
    //0.7意思为扫描横向范围为0.7*width;
    //0.5意思为扫描纵向范围为0.5*height;
    _output.rectOfInterest = CGRectMake(0.15, 0.25, 0.7, 0.5);
    
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    //添加扫描框和扫描线和提示语
    [self addSubviews];
    //设置约束
    [self makeConstraintsForUI];
    
    // Start 开始扫描   //开始捕获
    [_session startRunning];
    
    //扫描线开始动画
    self.timer.fireDate = [NSDate distantPast];
}


#pragma mark - add subviews

- (void)addSubviews {
    
    [self.view addSubview:self.view_bg];
    
    [self.view addSubview:self.lab_word];
    
    //这里需要注意的是扫描线用到了动画效果是用的layer
    [_view_bg.layer addSublayer:self.layer_scanLine];
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
    
    [_view_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(0.7 * kWindowW,  0.5 * (kWindowH - 64)));
        
        make.left.mas_equalTo(@(0.15 * kWindowW));
        
        make.top.mas_equalTo(@(0.25 * (kWindowH - 64) - 32));
    }];
    
    [_lab_word mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kWindowW, 21));
        
        make.left.mas_equalTo(@0);
        
        make.top.mas_equalTo(_view_bg.mas_bottom).with.offset(20);
    }];
}

#pragma mark - setter and getter

- (UIView *)view_bg {
    
    if (!_view_bg) {
        
        _view_bg = [[UIView alloc] init];
        
        _view_bg.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _view_bg.layer.borderWidth = 1.0;
    }
    return _view_bg;
}

- (CALayer *)layer_scanLine {
    
    if (!_layer_scanLine) {
        
        CALayer * layer = [[CALayer alloc] init];
        
        layer.bounds = CGRectMake(0, 0, 0.7 * kWindowW, 1);
        
        layer.backgroundColor = [UIColor greenColor].CGColor;
        
        //起点
        layer.position = CGPointMake(0, 0);
        
        //定位点
        layer.anchorPoint = CGPointMake(0, 0);
        
        _layer_scanLine = layer;
    }
    return _layer_scanLine;
}

- (UILabel *)lab_word {
    
    if (!_lab_word) {
        
        _lab_word = [[UILabel alloc] init];
        
        _lab_word.textAlignment = NSTextAlignmentCenter;
        
        _lab_word.textColor = [UIColor whiteColor];
        
        _lab_word.font = [UIFont systemFontOfSize:13];
        
        _lab_word.text = @"将二维码/条码放入框内，即可进行扫描";
    }
    return _lab_word;
}

- (NSTimer *)timer {
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scanLineMove) userInfo:nil repeats:YES];
        
        [_timer fire];
    }
    return _timer;
}

#pragma mark - timer event

- (void)scanLineMove {
    
    CABasicAnimation * animation = [[CABasicAnimation alloc] init];
    
    //告诉系统要执行什么样的动画
    animation.keyPath = @"position";
    
    //设置通过动画  layer从哪到哪
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0.5 * (kWindowH - 64))];
    
    //动画时间
    animation.duration = 4.0;
    
    //设置动画执行完毕之后不删除动画
    animation.removedOnCompletion = NO;
    
    //设置保存动画的最新动态
    animation.fillMode = kCAFillModeForwards;
    
    //添加动画到layer
    [self.layer_scanLine addAnimation:animation forKey:nil];
}

#pragma mark - AVCaptureMetadataOutputObjects delegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    //得到解析到的结果
    NSString * stringValue;
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        
        stringValue = metadataObject.stringValue;
    }
    
    //停止扫描
    [_session stopRunning];
    //扫描线定时器停止
    self.timer.fireDate = [NSDate distantFuture];
    
    WKWebViewViewController *vc= [[WKWebViewViewController alloc]init];
    vc.isNoShowNavBar = NO;
    vc.webUrl = stringValue;
    vc.navTitle = @"";
    [self.navigationController pushViewController:vc animated:YES];
    
    
//    //创建提示框
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"结果：%@", stringValue] preferredStyle:UIAlertControllerStyleAlert];
//    
//    //取消扫描
//    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [_previewLayer removeFromSuperlayer];
//        
//        //释放定时器并置空
//        [self.timer invalidate];
//        
//        _timer = nil;
//        
//        //提示框返回
//        [self dismissViewControllerAnimated:YES completion:nil];
//        //跳转回之前界面（从当前扫描界面退出）
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//    
//    //重新开始扫描
//    UIAlertAction * actionReStart = [UIAlertAction actionWithTitle:@"重新扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //开始扫描
//        [_session startRunning];
//        //定时器开始
//        self.timer.fireDate = [NSDate distantPast];
//        
//    }];
//    
//    //将提示action添加到alertController控制器上
//    [alertController addAction:actionCancel];
//    [alertController addAction:actionReStart];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
}


@end
