//
//  XiMeiDetailHeaderView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiDetailHeaderView.h"
#import "CheDianZhangCommon.h"

@implementation XiMeiDetailHeaderView

-(instancetype)init
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
            make.right.mas_equalTo(100);
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
        self.topStateLabel.textColor = [UIColor orangeColor];
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
        self.jiSuanHeight = jisuanGao;
        
        self.frame = CGRectMake(0, 0, kWindowW, jisuanGao);
    }
    return self;
}
-(void)erWeiMaButtonChick:(UIButton *)sender
{
    self.erWeiMaButtonBlock();
}


-(void)sheZHiBuJuWithXiangMu:(NSArray *)subjects withHaoCaiArray:(NSArray *)comm_imgs withSouDan:(BOOL)suoDan
{
    CGFloat jisuanGao = self.jiSuanHeight;
    if (suoDan == YES) {
        UIView *diangHaoView2 = [[UIView alloc]init];
        diangHaoView2.backgroundColor = [UIColor whiteColor];
        [self addSubview:diangHaoView2];
        [diangHaoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(jisuanGao);
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
       [self.suoDanSwitch addTarget:self action:@selector(suoDanSwitchChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [diangHaoView2 addSubview:self.suoDanSwitch];
        [self.suoDanSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    
    
    if (subjects.count>0) {
        UIView *diangHaoView2 = [[UIView alloc]init];
        diangHaoView2.backgroundColor = [UIColor clearColor];
        [self addSubview:diangHaoView2];
        [diangHaoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(jisuanGao);
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
        UILabel *xiangMuLa = [[UILabel alloc]init];
        xiangMuLa.text = @"项目信息";
        xiangMuLa.textColor = [UIColor grayColor];
        xiangMuLa.font = [UIFont systemFontOfSize:14];
        [diangHaoView2 addSubview:xiangMuLa];
        [xiangMuLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        
        UIView *xiangmuView = [[UIView alloc]init];
        xiangmuView.backgroundColor = [UIColor whiteColor];
        [self addSubview:xiangmuView];
        [xiangmuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(diangHaoView2.mas_bottom);
            make.height.mas_equalTo(subjects.count*30);
        }];
        jisuanGao += subjects.count*30;
        
        for (int i = 0; i<subjects.count; i++) {
            UILabel *xiangMuLabel = [[UILabel alloc]init];
            xiangMuLabel.font = [UIFont systemFontOfSize:14];
            xiangMuLabel.text = subjects[i];
            xiangMuLabel.numberOfLines = 0;
            [xiangmuView addSubview:xiangMuLabel];
            [xiangMuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(i*30);
                make.height.mas_equalTo(30);
            }];
        }
        UIView *lineXin = [[UIView alloc]init];
        lineXin.backgroundColor = kLineBgColor;
        [self addSubview:lineXin];
        [lineXin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }else{
        UIView *diangHaoView2 = [[UIView alloc]init];
        diangHaoView2.backgroundColor = [UIColor clearColor];
        [self addSubview:diangHaoView2];
        [diangHaoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(jisuanGao);
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
        UILabel *xiangMuLa = [[UILabel alloc]init];
        xiangMuLa.text = @"项目信息";
        xiangMuLa.textColor = [UIColor grayColor];
        xiangMuLa.font = [UIFont systemFontOfSize:14];
        [diangHaoView2 addSubview:xiangMuLa];
        [xiangMuLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        
        UIView *xiangmuView = [[UIView alloc]init];
        xiangmuView.backgroundColor = [UIColor whiteColor];
        [self addSubview:xiangmuView];
        [xiangmuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(diangHaoView2.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        jisuanGao += 30;
        
        UIView *lineXin = [[UIView alloc]init];
        lineXin.backgroundColor = kLineBgColor;
        [self addSubview:lineXin];
        [lineXin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    
    if (comm_imgs.count>0) {
        
        UIView *diangHaoView2 = [[UIView alloc]init];
        diangHaoView2.backgroundColor = [UIColor clearColor];
        [self addSubview:diangHaoView2];
        [diangHaoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(jisuanGao);
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
        UILabel *xiangMuLa = [[UILabel alloc]init];
        xiangMuLa.text = @"耗材信息";
        xiangMuLa.textColor = [UIColor grayColor];
        xiangMuLa.font = [UIFont systemFontOfSize:14];
        [diangHaoView2 addSubview:xiangMuLa];
        [xiangMuLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        
        UIView *xiangmuView = [[UIView alloc]init];
        xiangmuView.backgroundColor = [UIColor whiteColor];
        [self addSubview:xiangmuView];
        [xiangmuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(diangHaoView2.mas_bottom);
            make.height.mas_equalTo(100);
        }];
        jisuanGao += 100;
        
        self.zuoYouScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-50, 100)];
        self.zuoYouScrollView.backgroundColor = [UIColor whiteColor];
        [xiangmuView addSubview:self.zuoYouScrollView];
        
        [self zuoYouScrollViewBuju:comm_imgs];
        
        UIButton *chaKanBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-50, 0, 50, 100)];
        [chaKanBt addTarget:self action:@selector(chaKanChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [chaKanBt setTitle:@"查看" forState:(UIControlStateNormal)];
        [chaKanBt setTitleColor:kNavBarColor forState:(UIControlStateNormal)];
        [xiangmuView addSubview:chaKanBt];
    }
    
    self.frame = CGRectMake(0, 0, kWindowW, jisuanGao);
}

-(void)suoDanSwitchChick:(UISwitch *)sender
{
    self.suoDanSwitchBlock(sender);
}

-(void)chaKanChick:(UIButton *)sender
{
    self.chaKaButtonBlock();
}
-(void)zuoYouScrollViewBuju:(NSArray *)images
{
    while ([self.zuoYouScrollView.subviews lastObject] != nil)
    {
        [(UIView*)[self.zuoYouScrollView.subviews lastObject] removeFromSuperview];
    }
    
    
    for (int i = 0; i<images.count; i++) {
        UIImageView *maImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*100+10, 10, 80, 80)];
        [self.zuoYouScrollView addSubview:maImageView];
        [maImageView  sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:DJImageNamed(@"ic_launcher")];
    }
    self.zuoYouScrollView.contentSize = CGSizeMake((images.count)*100, 100);
}

@end
