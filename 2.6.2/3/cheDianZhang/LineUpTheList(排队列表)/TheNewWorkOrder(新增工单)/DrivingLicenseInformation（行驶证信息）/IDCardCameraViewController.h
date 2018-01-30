//
//  CameraViewController.h
//  BankCardRecog
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TheNewWorkOrderModel.h"

#import "Car_zongModel.h"
#import "BaseViewController.h"


//识别方向
typedef NS_ENUM(NSInteger, RecogOrientation){
    RecogInHorizontalScreen    = 0,
    RecogInVerticalScreen      = 1,
};



@interface IDCardCameraViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@property(nonatomic,strong)Users_carsModel *zhuModel;

@property (nonatomic, retain) CALayer *customLayer;

@property (nonatomic,assign) BOOL isProcessingImage;

@property (strong, nonatomic) AVCaptureSession *session;

@property (strong, nonatomic) AVCaptureDeviceInput *captureInput;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property(nonatomic,strong)BaseViewController *suerViewColler;

@property (assign, nonatomic) RecogOrientation recogOrientation;

//识别证件类型及结果个数
@property (assign, nonatomic) int recogType;
@property (strong, nonatomic) NSString *typeName;

@end
