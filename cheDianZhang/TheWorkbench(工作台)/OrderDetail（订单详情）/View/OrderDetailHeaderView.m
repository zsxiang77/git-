//
//  OrderDetailHeaderView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderDetailHeaderView.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailHeaderView

-(instancetype)initWithModel:(TheWorkModel *)chuanzhiModel
{
    if (self = [super init]) {
        self.backgroundColor = kRGBColor(244, 245,246);
        
        CGFloat jisuanGao = 0;
        
        UIView *shangMianView = [[UIView alloc]init];
        shangMianView.backgroundColor = [UIColor whiteColor];
        [self addSubview:shangMianView];
        [shangMianView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(74);
        }];
        jisuanGao += 74;
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [shangMianView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UIView *chePaiV = [[UIView alloc]init];
        chePaiV.backgroundColor = [UIColor blueColor];
        [shangMianView addSubview:chePaiV];
        [chePaiV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(7.5);
        }];
        self.topCarNumberLa = [[UILabel alloc]init];
        self.topCarNumberLa.textColor = [UIColor whiteColor];
        self.topCarNumberLa.font = [UIFont systemFontOfSize:14];
        self.topCarNumberLa.textAlignment = NSTextAlignmentCenter;
        [self.topCarNumberLa.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [self.topCarNumberLa.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [self.topCarNumberLa.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [chePaiV addSubview:self.topCarNumberLa];
        [self.topCarNumberLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(3);
            make.right.bottom.mas_equalTo(-3);
        }];
        
        self.topMianImageView = [[UIImageView alloc]init];
        [shangMianView addSubview:self.topMianImageView];
        [self.topMianImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-7.5);
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(25);
        }];
        self.topShuoMLabel = [[UILabel alloc]init];
        self.topShuoMLabel.numberOfLines = 0;
        self.topShuoMLabel.textColor = kNavBarColor;
        self.topShuoMLabel.font = [UIFont systemFontOfSize:13];
        [shangMianView addSubview:self.topShuoMLabel];
        [self.topShuoMLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topMianImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.topMianImageView);
            make.right.mas_equalTo(-140);
        }];
        
        self.topLeiXinLabel = [[UILabel alloc]init];
        self.topLeiXinLabel.font = [UIFont systemFontOfSize:14];
        self.topLeiXinLabel.textColor = kNavBarColor;
        [shangMianView addSubview:self.topLeiXinLabel];
        [self.topLeiXinLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(25);
        }];
        
        self.topStateLabel = [[UILabel alloc]init];
        self.topStateLabel.font = [UIFont systemFontOfSize:13];
        self.topStateLabel.textColor = kRGBColor(253, 183, 46);
        [shangMianView addSubview:self.topStateLabel];
        [self.topStateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.topLeiXinLabel.mas_left).mas_equalTo(-35);
            make.centerY.mas_equalTo(self.topLeiXinLabel);
        }];
        
        self.stateImageView = [[UIImageView alloc]init];
        [shangMianView addSubview:self.stateImageView];
        [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.topStateLabel);
            make.right.mas_equalTo(self.topStateLabel.mas_left).mas_equalTo(-7);
            make.width.height.mas_equalTo(15);
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor grayColor];
        [shangMianView addSubview:self.timeLabel];
        [self.timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-14);
        }];
        
        UIView *diangHaoView = [[UIView alloc]init];
        diangHaoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:diangHaoView];
        [diangHaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(shangMianView.mas_bottom);
            make.height.mas_equalTo(38);
        }];
        jisuanGao += 38;
        
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [diangHaoView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *dingDanLa = [[UILabel alloc]init];
        dingDanLa.text = @"订单号";
        dingDanLa.font = [UIFont systemFontOfSize:13];
        [diangHaoView addSubview:dingDanLa];
        [dingDanLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        
        self.erWeiMaImageView = [[UIImageView alloc]init];
        [diangHaoView addSubview:self.erWeiMaImageView];
        [self.erWeiMaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(diangHaoView);
            make.right.mas_equalTo(-10);
            make.width.height.mas_equalTo(20);
        }];
        
        UIButton *erWeiMaButton = [[UIButton alloc]init];
        [erWeiMaButton addTarget:self action:@selector(erWeiMaButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [diangHaoView addSubview:erWeiMaButton];
        [erWeiMaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(diangHaoView);
            make.right.mas_equalTo(-10);
            make.width.height.mas_equalTo(30);
        }];
        
        self.dingDanText = [[UILabel alloc]init];
        self.dingDanText.font = [UIFont systemFontOfSize:14];
        [diangHaoView addSubview:self.dingDanText];
        [self.dingDanText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(diangHaoView);
            make.right.mas_equalTo(self.erWeiMaImageView.mas_left).mas_equalTo(-10);
        }];
//        ========================
        
        UIView *diangHaoView2 = [[UIView alloc]init];
        diangHaoView2.backgroundColor = [UIColor whiteColor];
        [self addSubview:diangHaoView2];
        [diangHaoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(diangHaoView.mas_bottom);
            make.height.mas_equalTo(38);
        }];
        jisuanGao += 38;
        
        UILabel *line3 = [[UILabel alloc]init];
        line3.backgroundColor = kLineBgColor;
        [diangHaoView2 addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        UILabel *dingDanLa2 = [[UILabel alloc]init];
        dingDanLa2.text = @"锁单";
        dingDanLa2.font = [UIFont systemFontOfSize:14];
        [diangHaoView2 addSubview:dingDanLa2];
        [dingDanLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        
        self.suoDanSwitch = [[UISwitch alloc]init];
        self.suoDanSwitch.transform = CGAffineTransformMakeScale( 0.8, 0.8);
        [diangHaoView2 addSubview:self.suoDanSwitch];
        [self.suoDanSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
        
//        ===============================
        NSInteger jigeDian = 1;
        if ([[UserInfo shareInstance].isExplod boolValue]) {
            jigeDian = 3;
        }
        
        if (![chuanzhiModel.class_name isEqualToString:@"维修"]) {
            jigeDian = 0;
        }
        
        for (int i = 0; i<jigeDian; i++) {
            UIView *diangHaoView3 = [[UIView alloc]init];
            diangHaoView3.backgroundColor = [UIColor whiteColor];
            [self addSubview:diangHaoView3];
            [diangHaoView3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(diangHaoView2.mas_bottom).mas_equalTo(i*40);
                make.height.mas_equalTo(40);
            }];
            jisuanGao += 40;
            UILabel *line4 = [[UILabel alloc]init];
            line4.backgroundColor = kLineBgColor;
            [diangHaoView3 addSubview:line4];
            [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.height.mas_equalTo(1);
            }];
            UILabel *dingDanLa4 = [[UILabel alloc]init];
            if (i == 0) {
                dingDanLa4.text = @"接车信息";
            }else  if (i == 1) {
                dingDanLa4.text = @"销售人员";
            }else if (i == 2) {
                dingDanLa4.text = @"检验人员";
            }
            
            
            dingDanLa4.font = [UIFont systemFontOfSize:14];
            [diangHaoView3 addSubview:dingDanLa4];
            [dingDanLa4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(10);
            }];
            
            
            UIImageView *tiaozhuanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
            [diangHaoView3 addSubview:tiaozhuanImageView];
            [tiaozhuanImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(diangHaoView3);
                make.width.height.mas_equalTo(25);
            }];
            
            UIButton *jieCheInformetionBt = [[UIButton alloc]init];
            [jieCheInformetionBt addTarget:self action:@selector(jieCheInformetionBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            jieCheInformetionBt.tag = 3000 + i;
            [diangHaoView3 addSubview:jieCheInformetionBt];
            [jieCheInformetionBt  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            UILabel *la = [[UILabel alloc]init];
            la.font = [UIFont systemFontOfSize:13];
            la.tag = 4000+i;
            [diangHaoView3 addSubview:la];
            [la  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-40);
                make.centerY.mas_equalTo(diangHaoView3);
            }];
        }
        
        
        
        UILabel *guZhangLabel  = [[UILabel alloc]init];
        guZhangLabel.textColor = [UIColor grayColor];
        guZhangLabel.font = [UIFont systemFontOfSize:14];
        guZhangLabel.text = @"故障描述";
        [self addSubview:guZhangLabel];
        [guZhangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(jisuanGao);
            make.height.mas_equalTo(30);
        }];
        jisuanGao += 30;
//        ==================================
        
        UIView *diangHaoView4 = [[UIView alloc]init];
        diangHaoView4.backgroundColor = [UIColor whiteColor];
        [self addSubview:diangHaoView4];
        [diangHaoView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(jisuanGao);
            make.height.mas_equalTo(50);
        }];
        jisuanGao += 50;
        self.weiXiuFAnLabel = [[UILabel alloc]init];
        self.weiXiuFAnLabel.font = [UIFont systemFontOfSize:13];
        self.weiXiuFAnLabel.numberOfLines = 3;
        [diangHaoView4 addSubview:self.weiXiuFAnLabel];
        [self.weiXiuFAnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(diangHaoView4);
        }];
        
        UILabel *guZhangLabel2  = [[UILabel alloc]init];
        guZhangLabel2.textColor = [UIColor grayColor];
        guZhangLabel2.backgroundColor = [UIColor clearColor];
        guZhangLabel2.font = [UIFont systemFontOfSize:14];
        guZhangLabel2.text = @"维修方案";
        [self addSubview:guZhangLabel2];
        [guZhangLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(diangHaoView4.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        jisuanGao += 30;
        
        
        
        self.frame = CGRectMake(0, 0, kWindowW, jisuanGao);
    }
    return self;
}

-(void)jieCheInformetionBtChick:(UIButton *)sender
{
    NSInteger index = sender.tag - 3000;
    self.jieCheInformetionBtBlock(index);
}

-(void)erWeiMaButtonChick:(UIButton *)sender
{
    self.erWeiMaButtonBlock();
}

@end
