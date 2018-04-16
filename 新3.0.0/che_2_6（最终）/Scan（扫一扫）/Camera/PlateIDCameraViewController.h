//
//  PlateIDCameraViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMedia/CoreMedia.h>

@interface PlateIDCameraViewController : BaseViewController

@property(nonatomic,assign)BOOL shiFouHuiDiao;
@property(nonatomic,strong)void (^saoMiaoJieGUo)(NSString *jieGuo);

@end
