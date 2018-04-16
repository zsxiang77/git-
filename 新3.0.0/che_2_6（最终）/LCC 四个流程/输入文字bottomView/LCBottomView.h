//
//  LCBottomView.h
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "kehuXuQiuViewController.h"
#import <Speech/Speech.h>

@interface LCBottomView : UIView
{
    NSTimer*            m_timer;
    NSInteger           leftTime;
    AVAudioSession *audioSession;
}
@property (nonatomic, strong) void (^sendMessage)(id model);
@property (nonatomic, strong) void (^nextStep)(void);

@property (nonatomic, strong) UIButton *xiaYibuBT;

@property(nonatomic,strong)UIImageView *fuCengImageView;

@property(nonatomic,strong)UILabel *yuyinTime;
@property(nonatomic,strong)NSString *yuYingZhuanHStr;

@property(nonatomic,assign)BOOL shiFouJieShuLuYin;

@property(nonatomic,strong)kehuXuQiuViewController *superViewController;

@property(nonatomic,assign)BOOL yuYingShiJieJieShu;//语音识别结束

- (void)hidenKeyboard;


@end
