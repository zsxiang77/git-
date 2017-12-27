//
//  SuccessfulOrderViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "SuccessfulOrderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "AITDetectView.h"
#import "BuyAITProductsViewController.h"
#import "SettingAITSerialNumberVC.h"

@interface SuccessfulOrderViewController ()

@end

@implementation SuccessfulOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订单成功" withBackButton:NO];
    
    UIView *erweiView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+10, kWindowW, 150)];
    erweiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:erweiView];
    

    
    
    UIImageView *wechatImageView = [[UIImageView alloc] init];
    wechatImageView.image = [SuccessfulOrderViewController qrCodeImageWithContent:KISDictionaryHaveKey(self.chuZhiDict, @"query_url") codeImageSize:130 red:41 green:41 blue:224];//重绘二维码,使其显示清晰
    [erweiView addSubview:wechatImageView];
    [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(erweiView);
        make.height.with.mas_equalTo(130);
    }];
    
    UIButton *fanHuiBt = [[UIButton alloc]init];
    [fanHuiBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [fanHuiBt.layer setCornerRadius:3];
    fanHuiBt.backgroundColor = kNavBarColor;
    [fanHuiBt setTitle:@"返回工作台" forState:(UIControlStateNormal)];
    [fanHuiBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [fanHuiBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:fanHuiBt];
    [fanHuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(erweiView.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    
    UIButton *daYingBt = [[UIButton alloc]init];
    daYingBt.hidden = YES;
    [daYingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [daYingBt.layer setCornerRadius:3];
    daYingBt.backgroundColor = kNavBarColor;
    [daYingBt setTitle:@"打印二维码" forState:(UIControlStateNormal)];
    [daYingBt addTarget:self action:@selector(daYingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [daYingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:daYingBt];
    [daYingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    
    
    if ([KISDictionaryHaveKey(self.chuZhiDict, @"ait_switch") boolValue] == YES) {
        AITDetectView *aITDetectView = [[AITDetectView alloc]initWithFrame:CGRectMake(0, kWindowH-190, kWindowW, 190)];
        [self.view addSubview:aITDetectView];
        [self.view bringSubviewToFront:aITDetectView];
        [aITDetectView setYeMianYangShiWith:[KISDictionaryHaveKey(self.chuZhiDict, @"is_ait") boolValue]];
//        [aITDetectView setYeMianYangShiWith:NO];
        kWeakSelf(weakSelf)
        aITDetectView.buyAitBtChickBlock = ^{
            BuyAITProductsViewController *vc = [[BuyAITProductsViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        aITDetectView.settingAitBtChickBlock = ^{
            SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
}



//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content{
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *image = qrFilter.outputImage;
    return image;
}
//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size{
    CIImage *image = [SuccessfulOrderViewController qrCodeImageWithContent:content];
    CGRect integralRect = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(integralRect), size/CGRectGetHeight(integralRect));
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    UIImage *image = [SuccessfulOrderViewController qrCodeImageWithContent:content codeImageSize:size];
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    //取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    return resultImage;
}
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}


-(void)queDingBtChick:(UIButton *)sender
{
    
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.navigationController popToRootViewControllerAnimated:NO];
    [delegate.tabBarController setSelectedIndex:0];
//    delegate.tabBarController.hidesBottomBarWhenPushed = NO;
//    [(UINavigationController*)self.tabBarController.selectedViewController popToViewController:[[(UINavigationController*)self.tabBarController.selectedViewController viewControllers] objectAtIndex:index-2] animated:YES];
//
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 蓝牙打印
-(void)daYingBtChick:(UIButton *)sender
{
}


@end
