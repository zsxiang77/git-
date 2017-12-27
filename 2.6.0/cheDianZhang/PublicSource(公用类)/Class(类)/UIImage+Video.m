//
//  UIImage+Video.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/21.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "UIImage+Video.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Video)
+(UIImage *)imageWithVieo:(NSURL *)url
{
//    根据视频的url创建AVURLAsset
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:url options:nil];
    //    根据视频的AVURLAsset创建AVAssetImageGenerator对象
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
//    定义获取0针处的视频截图
    CMTime time = CMTimeMake(27, 10);
    CMTime actualTime;
//    获取time处的视频截图
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:nil];
//    将CGImageRef转化为UIimage
    UIImage *thumb = [[UIImage alloc]initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

@end
