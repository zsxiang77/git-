//
//  SaoMiaoSFZViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AudioToolbox/AudioToolbox.h>
#import "BaseViewController.h"

//识别方向
typedef NS_ENUM(NSInteger, RecogOrientation){
    RecogInHorizontalScreen    = 0,
    RecogInVerticalScreen      = 1,
};

@interface SaoMiaoSFZViewController : BaseViewController<AVCaptureVideoDataOutputSampleBufferDelegate>



@property(nonatomic,strong)void (^chuanSanGeZhiBlock)(NSString *store_alias,NSString *id_card,NSString *address,NSString *birthday,NSString *nation,NSString *sex);

@property (nonatomic, retain) CALayer *customLayer;

@property (nonatomic,assign) BOOL isProcessingImage;

@property (strong, nonatomic) AVCaptureSession *session;

@property (strong, nonatomic) AVCaptureDeviceInput *captureInput;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property (assign, nonatomic) RecogOrientation recogOrientation;

//识别证件类型及结果个数
@property (assign, nonatomic) int recogType;
@property (strong, nonatomic) NSString *typeName;

@end
