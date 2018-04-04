//
//  AccessoryEquipmentVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "AccessoryEquipmentModel.h"
#import <Speech/Speech.h>

@interface AccessoryEquipmentVC : BaseViewController
{
    NSTimer*            m_timer;
    NSInteger           leftTime;
    AVAudioSession *audioSession;
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSString *chuaOrdercode;

@property(nonatomic,assign)BOOL  shiFouFanHui;


@property(nonatomic,strong)UIImageView *fuCengImageView;

@property(nonatomic,strong)UILabel *yuyinTime;
@property(nonatomic,strong)NSString *yuYingZhuanHStr;

@property(nonatomic,assign)BOOL shiFouJieShuLuYin;
@end

