//
//  WeiXiuZhanShiView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "WeiXiuZhanShiView.h"

@implementation WeiXiuZhanShiView

-(instancetype)initWithModel:(TheWorkModel *)chuanzhiModel withWeiXiuZhanShiModel:(WeiXiuZhanShiModel *)mdeo
{
    if (self = [super init]) {
        self.backgroundColor = kRGBColor(245, 245, 245);
        CGFloat jisuanHei = 0;
       if ([chuanzhiModel.class_name isEqualToString:@"维修"]) {
           UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, (95/2)*4+167/2)];
           backView.backgroundColor = [UIColor whiteColor];
           [self addSubview:backView];
           jisuanHei = (95/2)*4+167/2+10;
           
           for (int i = 0; i<4; i++) {
               UILabel *line = [[UILabel alloc]init];
               line.backgroundColor = kLineBgColor;
               line.frame = CGRectMake(10, 167/2+(95/2)*i, kWindowW-10, 1);
               [backView addSubview:line];
           }
           
           
           UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 167/2)];
           [backView addSubview:view1];

           UIView *chePaiV = [[UIView alloc]init];
           [chePaiV.layer setMasksToBounds:YES];
           [chePaiV.layer setCornerRadius:2.5];
           chePaiV.backgroundColor = kChePaiColor;
           [view1 addSubview:chePaiV];
           [chePaiV mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(25);
               make.width.mas_equalTo(100);
               make.left.mas_equalTo(10);
               make.top.mas_equalTo(7.5);
           }];
           
           self.topStateLa  = [[UILabel alloc]init];
           self.topStateLa.font = [UIFont systemFontOfSize:25/2];
           self.topStateLa.text = @"维修";
           self.topStateLa.textAlignment = NSTextAlignmentCenter;
           self.topStateLa.textColor = [UIColor whiteColor];
           self.topStateLa.backgroundColor = kRGBColor(255, 197, 0);
           [self.topStateLa.layer setMasksToBounds:YES];
           [self.topStateLa.layer setCornerRadius:2.5];
           [view1 addSubview:self.topStateLa];
           [self.topStateLa mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(25);
               make.width.mas_equalTo(75/2);
               make.left.mas_equalTo(chePaiV.mas_right).mas_equalTo(7);
               make.top.mas_equalTo(7.5);
           }];
           
           self.topCarNumberLa = [[UILabel alloc]init];
           self.topCarNumberLa.textColor = [UIColor whiteColor];
           self.topCarNumberLa.font = [UIFont systemFontOfSize:14];
           self.topCarNumberLa.textAlignment = NSTextAlignmentCenter;
           [self.topCarNumberLa.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
           [self.topCarNumberLa.layer setBorderWidth:0.5];//设置边界的宽度
           [self.topCarNumberLa.layer setCornerRadius:2.5];
           //设置按钮的边界颜色
           [self.topCarNumberLa.layer setBorderColor:[[UIColor whiteColor] CGColor]];
           [chePaiV addSubview:self.topCarNumberLa];
           [self.topCarNumberLa mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.left.mas_equalTo(3);
               make.right.bottom.mas_equalTo(-3);
           }];
           
           
           self.topMianImageView = [[UIImageView alloc]init];
           [view1 addSubview:self.topMianImageView];
           [self.topMianImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.bottom.mas_equalTo(-7.5);
               make.left.mas_equalTo(10);
               make.width.height.mas_equalTo(25);
           }];
           self.topShuoMLabel = [[UILabel alloc]init];
           self.topShuoMLabel.numberOfLines = 0;
           self.topShuoMLabel.textColor = kZhuTiColor;
           self.topShuoMLabel.font = [UIFont systemFontOfSize:15];
           [view1 addSubview:self.topShuoMLabel];
           [self.topShuoMLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.topMianImageView.mas_right).mas_equalTo(10);
               make.centerY.mas_equalTo(self.topMianImageView);
               make.right.mas_equalTo(-120);
           }];

           self.topStateLabel = [[UILabel alloc]init];
           self.topStateLabel.font = [UIFont systemFontOfSize:13];
           self.topStateLabel.textColor = [UIColor orangeColor];
           [view1 addSubview:self.topStateLabel];
           [self.topStateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-10);
               make.bottom.mas_equalTo(-10);
           }];
           
           self.stateImageView = [[UIImageView alloc]init];
           [view1 addSubview:self.stateImageView];
           [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.mas_equalTo(self.topStateLabel);
               make.right.mas_equalTo(self.topStateLabel.mas_left).mas_equalTo(-7);
               make.width.height.mas_equalTo(15);
           }];
           
           self.aitLabel = [[UILabel alloc]init];
           self.aitLabel.font = [UIFont systemFontOfSize:13];
           self.aitLabel.textColor = kRGBColor(242, 58, 81);
           [view1 addSubview:self.aitLabel];
           [self.aitLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-10);
               make.centerY.mas_equalTo(view1);
           }];
           
           self.aitImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"01_youbaogao")];
           self.aitImageView.contentMode = UIViewContentModeScaleAspectFit;
           self.aitImageView.hidden = YES;
           [view1 addSubview:self.aitImageView];
           [self.aitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.mas_equalTo(self.aitLabel);
               make.right.mas_equalTo(self.aitLabel.mas_left).mas_equalTo(-5);
               make.height.mas_equalTo(15);
               make.width.mas_equalTo(20);
           }];
           
           self.timeLa = [[UILabel alloc]init];
           self.timeLa.font = [UIFont systemFontOfSize:13];
           self.timeLa.textColor = [UIColor grayColor];
           [view1 addSubview:self.timeLa];
           [self.timeLa  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-10);
               make.top.mas_equalTo(10);
           }];
           
           self.topCarNumberLa.text = chuanzhiModel.car_number;
           [self.topMianImageView  sd_setImageWithURL:[NSURL URLWithString:chuanzhiModel.brand_img] placeholderImage:DJImageNamed(@"")];
           
           
           self.topShuoMLabel.text = chuanzhiModel.cars_spec;
           self.topStateLabel.text = KISDictionaryHaveKey(mdeo.order_info, @"status");
           if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"待施工"]) {
               self.topStateLabel.textColor = kRGBColor(255, 155, 0);
               self.stateImageView.image = DJImageNamed(@"waiting_repair");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"待结算"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X8B572A, 1);
               self.stateImageView.image = DJImageNamed(@"waiting_statement");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"已关闭"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X4A4A4A, 1);
               self.stateImageView.image = DJImageNamed(@"waiting_guanBi");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"已完成"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X62AC0D, 1);
               self.stateImageView.image = DJImageNamed(@"waiting_WanCheng");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"待出厂"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X4A90E2, 1);;
               self.stateImageView.image = DJImageNamed(@"waiting_chuChang");
           }
           self.timeLa.text = KISDictionaryHaveKey(mdeo.order_info, @"add_time");
           
           if ([chuanzhiModel.ait_report boolValue]) {
               self.aitLabel.hidden = NO;
               self.aitLabel.text = @"智能检测";
               
               self.aitImageView.hidden = NO;
           }else{
               self.aitLabel.hidden = YES;
               self.aitImageView.hidden = YES;
           }
           
           
//           ============================
           for (int i = 0; i<4; i++) {
               UIView *neView = [[UIView alloc]initWithFrame:CGRectMake(0, (95/2)*i+167/2, kWindowW, 95/2)];
               [backView addSubview:neView];
               
               UILabel *la = [[UILabel alloc]init];
               la.textColor = kRGBColor(102, 102, 102);
               la.font = [UIFont systemFontOfSize:14];
               [neView addSubview:la];
               [la mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.mas_equalTo(10);
                   make.centerY.mas_equalTo(neView);
               }];
               
               UILabel *la2 = [[UILabel alloc]init];
               la2.textColor = kRGBColor(102, 102, 102);
               la2.font = [UIFont systemFontOfSize:14];
               [neView addSubview:la2];
               [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.right.mas_equalTo(-10);
                   make.centerY.mas_equalTo(neView);
               }];
               
               if (i == 0) {
                   la.text = @"订单号";
                   la2.text = KISDictionaryHaveKey(mdeo.order_info, @"ordercode");
               }else if (i == 1) {
                   la.text = @"VIN码";
                   la2.text = KISDictionaryHaveKey(mdeo.order_info, @"vin");
               }else if (i == 2) {
                   la.text = @"送修人";
                   la2.text = KISDictionaryHaveKey(mdeo.users_info, @"realname");
               }else if (i == 3) {
                   la.text = @"电话";
                   la2.text = KISDictionaryHaveKey(mdeo.users_info, @"mobile");
                   la2.textColor = kZhuTiColor;
               }
           }
           
       }else{
           UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, (95/2)*3+167/2)];
           backView.backgroundColor = [UIColor whiteColor];
           [self addSubview:backView];
           jisuanHei = (95/2)*3+167/2+10;
           
           for (int i = 0; i<3; i++) {
               UILabel *line = [[UILabel alloc]init];
               line.backgroundColor = kLineBgColor;
               line.frame = CGRectMake(10, 167/2+(95/2)*i, kWindowW-10, 1);
               [backView addSubview:line];
           }
           
           
           UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 167/2)];
           [backView addSubview:view1];
           
           UIView *chePaiV = [[UIView alloc]init];
           [chePaiV.layer setMasksToBounds:YES];
           [chePaiV.layer setCornerRadius:2.5];
           chePaiV.backgroundColor = kChePaiColor;
           [view1 addSubview:chePaiV];
           [chePaiV mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(25);
               make.width.mas_equalTo(100);
               make.left.mas_equalTo(10);
               make.top.mas_equalTo(7.5);
           }];
           
           self.topStateLa  = [[UILabel alloc]init];
           self.topStateLa.font = [UIFont systemFontOfSize:25/2];
           self.topStateLa.text = chuanzhiModel.class_name;
           self.topStateLa.textAlignment = NSTextAlignmentCenter;
           self.topStateLa.textColor = [UIColor whiteColor];
           self.topStateLa.backgroundColor = kRGBColor(98, 172, 13);
           [self.topStateLa.layer setMasksToBounds:YES];
           [self.topStateLa.layer setCornerRadius:2.5];
           [view1 addSubview:self.topStateLa];
           [self.topStateLa mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(25);
               make.width.mas_equalTo(75/2);
               make.left.mas_equalTo(chePaiV.mas_right).mas_equalTo(7);
               make.top.mas_equalTo(7.5);
           }];
           
           self.topCarNumberLa = [[UILabel alloc]init];
           self.topCarNumberLa.textColor = [UIColor whiteColor];
           self.topCarNumberLa.font = [UIFont systemFontOfSize:14];
           self.topCarNumberLa.textAlignment = NSTextAlignmentCenter;
           [self.topCarNumberLa.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
           [self.topCarNumberLa.layer setBorderWidth:0.5];//设置边界的宽度
           [self.topCarNumberLa.layer setCornerRadius:2.5];
           //设置按钮的边界颜色
           [self.topCarNumberLa.layer setBorderColor:[[UIColor whiteColor] CGColor]];
           [chePaiV addSubview:self.topCarNumberLa];
           [self.topCarNumberLa mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.left.mas_equalTo(3);
               make.right.bottom.mas_equalTo(-3);
           }];
    
           
           self.topMianImageView = [[UIImageView alloc]init];
           [view1 addSubview:self.topMianImageView];
           [self.topMianImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.bottom.mas_equalTo(-7.5);
               make.left.mas_equalTo(10);
               make.width.height.mas_equalTo(25);
           }];
           self.topShuoMLabel = [[UILabel alloc]init];
           self.topShuoMLabel.numberOfLines = 0;
           self.topShuoMLabel.textColor = kZhuTiColor;
           self.topShuoMLabel.font = [UIFont systemFontOfSize:15];
           [view1 addSubview:self.topShuoMLabel];
           [self.topShuoMLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.topMianImageView.mas_right).mas_equalTo(10);
               make.centerY.mas_equalTo(self.topMianImageView);
               make.right.mas_equalTo(-120);
           }];
           
           self.topStateLabel = [[UILabel alloc]init];
           self.topStateLabel.font = [UIFont systemFontOfSize:13];
           self.topStateLabel.textColor = [UIColor orangeColor];
           [view1 addSubview:self.topStateLabel];
           [self.topStateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-10);
               make.bottom.mas_equalTo(-10);
           }];
           
           self.stateImageView = [[UIImageView alloc]init];
           [view1 addSubview:self.stateImageView];
           [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.mas_equalTo(self.topStateLabel);
               make.right.mas_equalTo(self.topStateLabel.mas_left).mas_equalTo(-7);
               make.width.height.mas_equalTo(15);
           }];
           
           self.aitLabel = [[UILabel alloc]init];
           self.aitLabel.font = [UIFont systemFontOfSize:13];
           self.aitLabel.textColor = kRGBColor(242, 58, 81);
           [view1 addSubview:self.aitLabel];
           [self.aitLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-10);
               make.centerY.mas_equalTo(view1);
           }];
           
           self.aitImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"01_youbaogao")];
           self.aitImageView.contentMode = UIViewContentModeScaleAspectFit;
           self.aitImageView.hidden = YES;
           [view1 addSubview:self.aitImageView];
           [self.aitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.mas_equalTo(self.aitLabel);
               make.right.mas_equalTo(self.aitLabel.mas_left).mas_equalTo(-5);
               make.height.mas_equalTo(15);
               make.width.mas_equalTo(20);
           }];
           
           self.timeLa = [[UILabel alloc]init];
           self.timeLa.font = [UIFont systemFontOfSize:13];
           self.timeLa.textColor = [UIColor grayColor];
           [view1 addSubview:self.timeLa];
           [self.timeLa  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-10);
               make.top.mas_equalTo(10);
           }];
           
           
           self.topCarNumberLa.text = chuanzhiModel.car_number;
           [self.topMianImageView  sd_setImageWithURL:[NSURL URLWithString:chuanzhiModel.brand_img] placeholderImage:DJImageNamed(@"")];
           
           
           self.topShuoMLabel.text = chuanzhiModel.cars_spec;
           self.topStateLabel.text = KISDictionaryHaveKey(mdeo.order_info, @"status");
           if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"待施工"]) {
               self.topStateLabel.textColor = kRGBColor(255, 155, 0);
               self.stateImageView.image = DJImageNamed(@"waiting_repair");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"待结算"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X8B572A, 1);
               self.stateImageView.image = DJImageNamed(@"waiting_statement");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"已关闭"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X4A4A4A, 1);
               self.stateImageView.image = DJImageNamed(@"waiting_guanBi");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"已完成"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X62AC0D, 1);
               self.stateImageView.image = DJImageNamed(@"waiting_WanCheng");
           }else if ([KISDictionaryHaveKey(mdeo.order_info, @"status") isEqualToString:@"待出厂"]) {
               self.topStateLabel.textColor = UIColorFromRGBA(0X4A90E2, 1);;
               self.stateImageView.image = DJImageNamed(@"waiting_chuChang");
           }
           self.timeLa.text = KISDictionaryHaveKey(mdeo.order_info, @"add_time");
           
           if ([chuanzhiModel.ait_report boolValue]) {
               self.aitLabel.hidden = NO;
               self.aitLabel.text = @"智能检测";
               
               self.aitImageView.hidden = NO;
           }else{
               self.aitLabel.hidden = YES;
               self.aitImageView.hidden = YES;
           }
           //           ============================
           for (int i = 0; i<3; i++) {
               UIView *neView = [[UIView alloc]initWithFrame:CGRectMake(0, (95/2)*i+167/2, kWindowW, 95/2)];
               [backView addSubview:neView];
               
               UILabel *la = [[UILabel alloc]init];
               la.textColor = kRGBColor(102, 102, 102);
               la.font = [UIFont systemFontOfSize:14];
               [neView addSubview:la];
               [la mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.mas_equalTo(10);
                   make.centerY.mas_equalTo(neView);
               }];
               
               UILabel *la2 = [[UILabel alloc]init];
               la2.textColor = kRGBColor(102, 102, 102);
               la2.font = [UIFont systemFontOfSize:14];
               [neView addSubview:la2];
               [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.right.mas_equalTo(-10);
                   make.centerY.mas_equalTo(neView);
               }];
               
               if (i == 0) {
                   la.text = @"订单号";
                   la2.text = KISDictionaryHaveKey(mdeo.order_info, @"ordercode");
               }else if (i == 1) {
                   la.text = @"客户";
                   la2.text = KISDictionaryHaveKey(mdeo.users_info, @"realname");
               }else if (i == 2) {
                   la.text = @"电话";
                   la2.text = KISDictionaryHaveKey(mdeo.users_info, @"mobile");
               }
           }
           
       }
        self.frame = CGRectMake(0, 0, kWindowW, jisuanHei);
    }
    return self;
}

@end
