//
//  OrderDetailHeaderView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailHeaderView.h"
#import "CheDianZhangCommon.h"
#import "UIImage+GIF.h"


@implementation OrderDetailHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 62)];
        view1.backgroundColor = [UIColor whiteColor];
        [self addSubview:view1];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [view1 addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        dingDanHaoLabel = [[UILabel alloc]init];
        dingDanHaoLabel.font = [UIFont boldSystemFontOfSize:12];
        dingDanHaoLabel.textColor = kRGBColor(74, 74, 74);
        [view1 addSubview:dingDanHaoLabel];
        [dingDanHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
        }];
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.textColor = kRGBColor(74, 74, 74);
        [view1 addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
        }];
        
        UIView *chepaiView = [[UIView alloc]init];
        chepaiView.backgroundColor = kChePaiColor;
        [chepaiView.layer setMasksToBounds:YES];
        [chepaiView.layer setCornerRadius:2.5];
        [view1 addSubview:chepaiView];
        [chepaiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(30);
            make.width.mas_equalTo(94);
            make.height.mas_equalTo(25);
        }];
        
        chePaiLabel = [[UILabel alloc]init];
        chePaiLabel.font = [UIFont boldSystemFontOfSize:15];
        chePaiLabel.textColor = [UIColor whiteColor];
        chePaiLabel.textAlignment = NSTextAlignmentCenter;
        [chePaiLabel.layer setMasksToBounds:YES];
        [chePaiLabel.layer setCornerRadius:2.5];
        [chePaiLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
        chePaiLabel.adjustsFontSizeToFitWidth = YES;
        [chePaiLabel.layer setBorderWidth:1];
        [chepaiView addSubview:chePaiLabel];
        [chePaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(3);
            make.bottom.right.mas_equalTo(-3);
        }];
        
        leiXieLabel = [[UILabel alloc]init];
        leiXieLabel.backgroundColor = kRGBColor(255, 197, 0);
        leiXieLabel.font = [UIFont boldSystemFontOfSize:12.5];
        leiXieLabel.textColor = kRGBColor(148, 18, 18);
        leiXieLabel.textAlignment = NSTextAlignmentCenter;
        [leiXieLabel.layer setMasksToBounds:YES];
        [leiXieLabel.layer setCornerRadius:2.5];
        [view1 addSubview:leiXieLabel];
        [leiXieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(chepaiView.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(chepaiView);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(25);
        }];
        
        
        zhuangTaiLabel = [[UILabel alloc]init];
        zhuangTaiLabel.font = [UIFont boldSystemFontOfSize:12];
        zhuangTaiLabel.textColor = kRGBColor(148, 18, 18);
        [view1 addSubview:zhuangTaiLabel];
        [zhuangTaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(chepaiView);
        }];
        
        zhuangTaiImageView= [[UIImageView alloc]init];
        [view1 addSubview:zhuangTaiImageView];
        [zhuangTaiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(zhuangTaiLabel.mas_left).mas_equalTo(-3);
            make.centerY.mas_equalTo(chepaiView);
            make.width.height.mas_equalTo(15);
        }];
//        =====================================
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 62, kWindowW, 55)];
        view2.backgroundColor = [UIColor whiteColor];
        [self addSubview:view2];
        
        cheImageView = [[UIImageView alloc]init];
        [view2 addSubview:cheImageView];
        [cheImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(3);
            make.width.height.mas_equalTo(28);
        }];
        
        cheLeiXLabel = [[UILabel alloc]init];
        cheLeiXLabel.font = [UIFont boldSystemFontOfSize:17];
        cheLeiXLabel.textColor = kRGBColor(74, 74, 74);
        [view2 addSubview:cheLeiXLabel];
        [cheLeiXLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cheImageView.mas_right).mas_equalTo(6);
            make.centerY.mas_equalTo(cheImageView);
        }];
        
        songNameLabel = [[UILabel alloc]init];
        songNameLabel.font = [UIFont systemFontOfSize:14];
        songNameLabel.textColor = kRGBColor(132, 132, 132);
        [view2 addSubview:songNameLabel];
        [songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cheLeiXLabel.mas_right).mas_equalTo(6);
            make.centerY.mas_equalTo(cheImageView);
        }];
        
        UIImageView *viImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"detail_VIN")];
        [view2 addSubview:viImageView];
        [viImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(40);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(15);
        }];
        
        vinLabel = [[UILabel alloc]init];
        vinLabel.font = [UIFont boldSystemFontOfSize:15];
        vinLabel.textColor = kRGBColor(74, 74, 74);
        [view2 addSubview:vinLabel];
        [vinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(viImageView.mas_right).mas_equalTo(6);
            make.centerY.mas_equalTo(viImageView);
        }];
        
//        ===========================================================
        
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 118, kWindowW, 390/2)];
        view3.backgroundColor = [UIColor whiteColor];
        [self addSubview:view3];
        
        zuo3View = [[UIView alloc]init];
        [view3 addSubview:zuo3View];
        [zuo3View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW/2);
        }];
        
        UIView *zuo3View2 = [[UIView alloc]init];
        [view3 addSubview:zuo3View2];
        [zuo3View2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW/2);
        }];
        
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = kLineBgColor;
        [zuo3View2 addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-30);
        }];
        
        aitButton = [[UIButton alloc]init];
        aitButton.titleLabel.font = [UIFont systemFontOfSize:27/2];
        [aitButton addTarget:self action:@selector(aitDianTiaoChicik:) forControlEvents:(UIControlEventTouchUpInside)];
        [zuo3View2 addSubview:aitButton];
        [aitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-30);
            make.height.mas_equalTo(38);
        }];
        
        
        
        aitImageView = [[UIImageView alloc]init];
        [zuo3View2 addSubview:aitImageView];
        [aitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-35);
            make.height.width.mas_equalTo(100);
        }];
        
        UILabel *aitLa1 = [[UILabel alloc]init];
        aitLa1.textColor = kZhuTiColor;
        aitLa1.text = @"什么是AIT";
        aitLa1.font = [UIFont systemFontOfSize:10];
        [zuo3View2 addSubview:aitLa1];
        [aitLa1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zuo3View2);
            make.top.mas_equalTo(5);
        }];
        UIImageView *alib = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_sa_ait_title")];
        [zuo3View2 addSubview:alib];
        [alib mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zuo3View2);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(28);
        }];
        [zuo3View2 bringSubviewToFront:aitLa1];
        
        UIButton *aitjieShaoBt = [[UIButton alloc]init];
        [aitjieShaoBt addTarget:self action:@selector(aitjieShaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [zuo3View2 addSubview:aitjieShaoBt];
        [aitjieShaoBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(zuo3View2);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(28);
        }];
        
        
        UILabel *aitLa2 = [[UILabel alloc]init];
        aitLa2.textColor = kRGBColor(74, 74, 74);
        aitLa2.text = @"AIT设备";
        aitLa2.font = [UIFont boldSystemFontOfSize:17];
        [zuo3View2 addSubview:aitLa2];
        [aitLa2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(25);
        }];
        
        aitDianJiImageView = [[UIImageView alloc]init];
        [zuo3View2 addSubview:aitDianJiImageView];
        [aitDianJiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(aitLa2.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(aitLa2);
            make.width.height.mas_equalTo(17);
        }];
        
        
        aitLabel = [[UILabel alloc]init];
        aitLabel.numberOfLines = 0;
        aitLabel.font = [UIFont systemFontOfSize:27/2];
        [zuo3View2 addSubview:aitLabel];
        [aitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(50);
            make.right.mas_equalTo(-30);
        }];
        
        [zuo3View2 bringSubviewToFront:aitButton];
//        ===========================================================
        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 118+390/2, kWindowW, 10)];
        view4.backgroundColor = kRGBColor(250, 250, 250);
        [self addSubview:view4];
        
        self.view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 118+390/2+10, kWindowW, 152/2)];
        self.view5.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.view5];
        tuiJianImageView = [[UIImageView alloc]init];
        [self.view5 addSubview:tuiJianImageView];
        [tuiJianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(27/2);
            make.top.mas_equalTo(17);
            make.width.mas_equalTo(86);
            make.height.mas_equalTo(27);
        }];
        
        UIImageView *dianiTuiImag = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_sa_info_arrows_right")];
        dianiTuiImag.contentMode = UIViewContentModeScaleAspectFit;
        [self.view5 addSubview:dianiTuiImag];
        [dianiTuiImag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(tuiJianImageView);
            make.width.height.mas_equalTo(73/2);
        }];
        tuiJianLabel = [[UILabel alloc]init];
        tuiJianLabel.font = [UIFont systemFontOfSize:53/2];
        [self.view5 addSubview:tuiJianLabel];
        [tuiJianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(dianiTuiImag.mas_left).mas_equalTo(-3);
            make.centerY.mas_equalTo(tuiJianImageView);
        }];
        
        UIImageView *dianiTuiImag2 = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_sa_info_new")];
        [self.view5 addSubview:dianiTuiImag2];
        [dianiTuiImag2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(tuiJianLabel.mas_left).mas_equalTo(-3);
            make.centerY.mas_equalTo(tuiJianImageView);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(18);
        }];
        
        UIImageView *im = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_sa_info_hint")];
        [self.view5 addSubview:im];
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(14);
            make.height.width.mas_equalTo(12);
        }];
        
        UILabel *labq = [[UILabel alloc]init];
        labq.font = [UIFont systemFontOfSize:9];
        labq.textColor = kRGBColor(132, 132, 132);
        labq.text = @"根据车辆信息以及检测报告推荐，完善信息会推荐更精确哦";
        [self.view5 addSubview:labq];
        [labq mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(im);
            make.left.mas_equalTo(im.mas_right).mas_equalTo(3);
        }];
        
        UIButton *tuijianXM = [[UIButton alloc]init];
        [tuijianXM addTarget:self action:@selector(tuijianXMChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view5 addSubview:tuijianXM];
        [tuijianXM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        
        UIView *heJiView = [[UILabel alloc]init];
        heJiView.backgroundColor = [UIColor whiteColor];
        [self addSubview:heJiView];
        [heJiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *heJiLine = [[UILabel alloc]init];
        heJiLine.backgroundColor = kLineBgColor;
        [heJiView addSubview:heJiLine];
        [heJiLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        self.heJiLabel = [[UILabel alloc]init];
        self.heJiLabel.textColor = [UIColor redColor];
        self.heJiLabel.font = [UIFont systemFontOfSize:14];
        [heJiView addSubview:self.heJiLabel];
        [self.heJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.top.mas_equalTo(0);
        }];
        
        UILabel *hejiLabel1 = [[UILabel alloc]init];
        hejiLabel1.font = [UIFont systemFontOfSize:14];
        hejiLabel1.textColor = kRGBColor(74, 74, 75);
        hejiLabel1.text = @"总计：";
        [heJiView addSubview:hejiLabel1];
        [hejiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.heJiLabel.mas_left).mas_equalTo(-3);
            make.bottom.top.mas_equalTo(0);
        }];
    }
    return self;
}
-(void)tuijianXMChick:(UIButton *)sender
{
    self.tuijianXMChickBlcok();
}


-(void)aitDianTiaoChicik:(UIButton *)sender
{
    self.aitTiaoZhuanBlcok();
}
-(void)refreshData:(OrderDetailModel *)model
{
    dingDanHaoLabel.text = [NSString stringWithFormat:@"工单号：%@",model.order_info.ordercode];
    dateLabel.text = model.order_info.create_time;
    chePaiLabel.text = model.order_info.car_number;
    if ([model.order_info.class_name isEqualToString:@"维修"]) {
        leiXieLabel.backgroundColor = kRGBColor(255, 197, 0);
        leiXieLabel.textColor = kRGBColor(146, 18, 18);
    }else{
        leiXieLabel.backgroundColor = kRGBColor(98, 172, 13);
        leiXieLabel.textColor = [UIColor whiteColor];
    }
    leiXieLabel.text = model.order_info.class_name;
    if ([model.order_info.order_status integerValue] == 1) {
        zhuangTaiLabel.textColor = kRGBColor(255, 155, 0);
        zhuangTaiImageView.image = DJImageNamed(@"waiting_repair");
    }else if ([model.order_info.order_status integerValue] == 7) {
        zhuangTaiLabel.textColor = UIColorFromRGBA(0X62AC0D, 1);
        zhuangTaiImageView.image = DJImageNamed(@"waiting_WanCheng");
    }else if ([model.order_info.order_status integerValue] == 3) {
        zhuangTaiLabel.textColor = UIColorFromRGBA(0X4A90E2, 1);
        zhuangTaiImageView.image = DJImageNamed(@"waiting_chuChang");
    }else if ([model.order_info.order_status integerValue] == 2) {
        zhuangTaiLabel.textColor = UIColorFromRGBA(0X8B572A, 1);
        zhuangTaiImageView.image = DJImageNamed(@"waiting_statement");
    }
    zhuangTaiLabel.text = model.order_info.status;
    [cheImageView sd_setImageWithURL:[NSURL URLWithString:model.order_info.brand_img]];
    cheLeiXLabel.text = model.order_info.cars_spec;
    songNameLabel.text = [NSString stringWithFormat:@"送修人：%@",model.order_info.send_name];
    vinLabel.text = model.order_info.vin;
    
    
    
    
    
    
    while ([zuo3View.subviews lastObject] != nil)
    {
        [[zuo3View.subviews lastObject] removeFromSuperview];
    }
    
    banYuanView = [[OrderDetailYuanView alloc]initWithFrame:CGRectMake((kWindowW/2-(290/2)), 22, 290/2, 290/4) withInde:[model.inspect_percent floatValue]/100.0];
    [zuo3View addSubview:banYuanView];
    [banYuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22);
        make.centerX.mas_equalTo(zuo3View);
        make.width.mas_equalTo(290/2);
        make.height.mas_equalTo(290/4);
    }];
    
    banYuanView.persentage = [model.inspect_percent floatValue]/100.0;
    
    
    
    jinduLabel = [[UILabel alloc]init];
    
    [zuo3View addSubview:jinduLabel];
    jinduLabel.font = [UIFont boldSystemFontOfSize:22];
    [jinduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(78);
        make.centerX.mas_equalTo(zuo3View);
    }];
    if ([model.inspect_percent floatValue]>50) {
        jinduLabel.textColor = kRGBColor(74, 144, 226);
    }else{
        jinduLabel.textColor = kRGBColor(255, 0, 31);
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%%",model.inspect_percent]];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange([NSString stringWithFormat:@"%@%%",model.inspect_percent].length-1, 1)];
    jinduLabel.attributedText = att;
    [zuo3View bringSubviewToFront:jinduLabel];
    
    UILabel *la1 = [[UILabel alloc]init];
    la1.text = @"接车信息";
    la1.font = [UIFont systemFontOfSize:10];
    la1.textColor = kRGBColor(74, 74, 74);
    [zuo3View addSubview:la1];
    [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(jinduLabel.mas_top).mas_equalTo(-10);
        make.centerX.mas_equalTo(zuo3View);
    }];
    
    UIButton *bt = [[UIButton alloc]init];
    [bt addTarget:self action:@selector(wanShanXXiChcick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setBackgroundImage:DJImageNamed(@"orderDetail_wanShan") forState:(UIControlStateNormal)];
    bt.titleLabel.font = [UIFont boldSystemFontOfSize:27/2.0];
    [bt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    if ([model.order_info.order_status integerValue] == 1) {
        [bt setTitle:@"完善信息" forState:(UIControlStateNormal)];
    }else{
        [bt setTitle:@"查看信息" forState:(UIControlStateNormal)];
    }
    
    [zuo3View addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-30);
        make.height.mas_equalTo(38);
    }];
    
    [aitButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    aitLabel.text = model.ait.massage;
    aitDianJiImageView.image = DJImageNamed(@"ic_checked");
    if ([model.ait.ait_status isEqualToString:@"buy"]) {
        aitButton.hidden = NO;
        [aitButton setBackgroundImage:DJImageNamed(@"orderDetail_ait_zhiChi") forState:(UIControlStateNormal)];
        [aitButton setTitle:@"去购买" forState:(UIControlStateNormal)];
        aitLabel.textColor = kRGBColor(209, 130, 0);
        aitImageView.image = DJImageNamed(@"ic_sa_shop");
        aitDianJiImageView.image = DJImageNamed(@"ic_finish_gray");
    }else if ([model.ait.ait_status isEqualToString:@"unsupport"]) {
        aitButton.hidden = YES;
        aitLabel.textColor = kRGBColor(155, 155, 155);
        aitImageView.image = DJImageNamed(@"orderDetail_ait_buzhichi");
    }else if ([model.ait.ait_status isEqualToString:@"support"]) {
        aitButton.hidden = NO;
        aitLabel.textColor = kRGBColor(74, 144, 226);
        [aitButton setBackgroundImage:DJImageNamed(@"orderDetail_ait_jianCe") forState:(UIControlStateNormal)];
        [aitButton setTitle:@"请插入设备开始检测" forState:(UIControlStateNormal)];
        aitImageView.image = DJImageNamed(@"ic_sa_info_ait_support");
    }else if ([model.ait.ait_status isEqualToString:@"done"]) {
        aitButton.hidden = NO;
        aitLabel.textColor = kRGBColor(98, 172, 13);
        [aitButton setBackgroundImage:DJImageNamed(@"ic_sa_info_ait_done_but") forState:(UIControlStateNormal)];
        [aitButton setTitle:@"查看报告" forState:(UIControlStateNormal)];
        aitImageView.image = DJImageNamed(@"ic_sa_info_ait_done");
    }
    
    if (model.show_list.is_show_recom) {
        self.view5.hidden = NO;
        tuiJianLabel.text = [NSString stringWithFormat:@"%ld",model.show_list.recom_num];
        if (model.show_list.recom_num>0) {
            tuiJianLabel.textColor = [UIColor redColor];
            tuiJianImageView.image = DJImageNamed(@"ic_sa_new");
        }else{
            tuiJianLabel.textColor = [UIColor grayColor];
            tuiJianImageView.image = DJImageNamed(@"ic_sa_new_old");
        }
    }else{
        self.view5.hidden = YES;
    }
}

-(void)wanShanXXiChcick:(UIButton *)sender
{
    self.wanShanXXiChcickBlock();
}

-(void)aitjieShaoBtChick:(UIButton *)sender
{
    
    self.aitjieShaoBtChickBlock();
}

@end
