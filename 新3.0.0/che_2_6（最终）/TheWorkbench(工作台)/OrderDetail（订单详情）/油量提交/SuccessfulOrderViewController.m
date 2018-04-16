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
#import "AITIntroduceViewController.h"
#import "SettingAITSerialNumberVC.h"
#import "UIImage+Video.h"
#import "MyQuartz.h"
@interface SuccessfulOrderViewController ()

@end

@implementation SuccessfulOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setTopViewWithTitle:@"订单成功" withBackButton:NO];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGBA(0X4377EE, 1).CGColor,(__bridge id)UIColorFromRGBA(0X78AFF8, 1).CGColor];
    gradientLayer.locations = @[@0.1, @1];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    [self.view.layer addSublayer:gradientLayer];
    
    MyQuartz * view= [[MyQuartz alloc]initWithFrame:CGRectMake(22, 149/2, kWindowW-44, kWindowH-149/2-18)];
    [self.view addSubview:view];
    
    UIView * toubuView =[[UIView alloc]init];
    [view addSubview:toubuView];
    [toubuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.mas_equalTo(view);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(26);
    }];
    
    UIImageView * zuoImg = [[UIImageView alloc]init];
    zuoImg.image = [UIImage imageNamed:@"ic_checked"];
    [toubuView addSubview:zuoImg];
    [zuoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(26);
    }];
    
    UILabel *lable = [[UILabel alloc]init];
    lable.text=@"订单成功";
    lable.font = [UIFont systemFontOfSize:17];
    [lable setTextColor:kRGBColor(98, 172, 13)];
    [toubuView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zuoImg.mas_right).mas_equalTo(7.5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *wechatImageView = [[UIImageView alloc] init];
    wechatImageView.image = [UIImage qrCodeImageWithContent:KISDictionaryHaveKey(self.chuZhiDict, @"query_url") codeImageSize:187 red:0 green:0 blue:0];//重绘二维码,使其显示清晰
    [view addSubview:wechatImageView];
    [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toubuView.mas_bottom).mas_equalTo(14);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(kWindowW-188);
        make.width.mas_equalTo(kWindowW-188);
    }];
    
    UILabel * imgxiaLable = [[UILabel alloc]init];
    imgxiaLable.font = [UIFont systemFontOfSize:13];
    imgxiaLable.text=@"请提醒客户扫描查看工单详情";
    [imgxiaLable setTextColor:kRGBColor(74, 74, 74)];
    [view addSubview:imgxiaLable];
    [imgxiaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(wechatImageView.mas_bottom).mas_equalTo(1.5);
    }];
    
    UIButton *fanHuiBt = [[UIButton alloc]init];
    [fanHuiBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [fanHuiBt.layer setCornerRadius:3];
    fanHuiBt.backgroundColor = kZhuTiColor;
    [fanHuiBt setTitle:@"返回工作台" forState:(UIControlStateNormal)];
    [fanHuiBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [fanHuiBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:fanHuiBt];
    [fanHuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgxiaLable.mas_bottom).mas_equalTo(16);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(94/2);
        make.centerX.mas_equalTo(view);
    }];
    
    UILabel * xiaLableText = [[UILabel alloc]init];
    xiaLableText.font = [UIFont systemFontOfSize:15];
    [xiaLableText setTextColor:kRGBColor(74, 74, 74)];
    xiaLableText.text = @"关于AIT检测设备";
    [view addSubview:xiaLableText];
    if(kWindowW>320){
        [xiaLableText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-362/2);
            make.centerX.mas_equalTo(view);
        }];
    }else{
        [xiaLableText mas_makeConstraints:^(MASConstraintMaker *make) {
            //  make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(87/2*0.8);
            make.bottom.mas_equalTo(-362/2*0.8);
            make.centerX.mas_equalTo(view);
        }];
    }
    
    
    UIImageView * xiaoTuBiao = [[UIImageView alloc]init];
    xiaoTuBiao.image = [UIImage imageNamed:@"jishiTubiao"];
    [view addSubview:xiaoTuBiao];
    if(kWindowW>320){
        [xiaoTuBiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(71/2);
            make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(178/2);
            make.height.mas_equalTo(25/2);
            make.width.mas_equalTo(25/2);
        }];
    }else{
        [xiaoTuBiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(71/2*0.8);
            make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(178/2*0.8);
            make.height.mas_equalTo(25/2*0.8);
            make.width.mas_equalTo(25/2*0.8);
        }];
        
    }
    
    
    self.xiatuLable = [[UILabel alloc]init];
    self.xiatuLable.font = [UIFont systemFontOfSize:12];
    [self.xiatuLable setTextColor:kRGBColor(245, 166, 35)];
    self.xiatuLable.numberOfLines=0;
    self.xiatuLable.text = @"该设备可使用AIT设备，请插入设备进行检测";
    [view addSubview:self.xiatuLable];
    if(kWindowW>320){
        [self.xiatuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xiaoTuBiao.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(xiaoTuBiao);
        }];
    }else{
        [self.xiatuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xiaoTuBiao.mas_right).mas_equalTo(3*0.8);
            make.centerY.mas_equalTo(xiaoTuBiao);
        }];
    }
    
    
    UILabel * buyLablezuoShan = [[UILabel alloc]init];
    [buyLablezuoShan setTextColor:kRGBColor(74, 74, 74)];
    buyLablezuoShan.text=@"若您未购买AIT设备，您可以：";
    buyLablezuoShan.font = [UIFont systemFontOfSize:12];
    buyLablezuoShan.numberOfLines=0;
    [view addSubview:buyLablezuoShan];
    if(kWindowW>320){
        [buyLablezuoShan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(274/2);
            make.width.mas_equalTo(342/2);
        }];
    }else{
        [buyLablezuoShan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19*0.8);
            make.top.mas_equalTo(fanHuiBt.mas_bottom).mas_equalTo(274/2*0.8);
            make.width.mas_equalTo(342/2*0.8);
        }];
    }
    
    
    UIView * topView = [[UIView alloc]init];
    [topView.layer setMasksToBounds:YES];
    [topView.layer setBorderWidth:0.5];
    [topView.layer setBorderColor:UIColorFromRGBA(0x858488, 1.0).CGColor];
    [view addSubview:topView];
    if(kWindowW>320){
        [topView.layer setCornerRadius:83/4];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(buyLablezuoShan);
            make.width.mas_equalTo(246/2);
            make.right.mas_equalTo(-39/2);
            make.height.mas_equalTo(83/2);
        }];
    }else{
        [topView.layer setCornerRadius:83/4*0.8];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(buyLablezuoShan);
            make.width.mas_equalTo(246/2*0.8);
            make.right.mas_equalTo(-39/2*0.8);
            make.height.mas_equalTo(83/2*0.8);
        }];
    }
    
    UILabel * topLable = [[UILabel alloc]init];
    topLable.text = @"购买AIT产品";
    [topLable setTextColor:UIColorFromRGBA(0xf5a723, 1.0)];
    [topView addSubview:topLable];
    if(kWindowW>320){
        topLable.font=[UIFont systemFontOfSize:12];
        [topLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(7.5);
            make.centerY.mas_equalTo(topView);
        }];
    }else{
        topLable.font=[UIFont systemFontOfSize:12*0.8];
        [topLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(7.5*0.8);
            make.centerY.mas_equalTo(topView);
        }];
    }
    
    
    UIImageView * topImg = [[UIImageView alloc]init];
    topImg.image = [UIImage imageNamed:@"AIT_buy"];
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [topView addSubview:topImg];
    if(kWindowW>320){
        [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topLable.mas_right).mas_equalTo(4.5);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(28);
            make.centerY.mas_equalTo(topLable);
        }];
    }else{
        [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topLable.mas_right).mas_equalTo(4.5*0.8);
            make.height.mas_equalTo(28*0.8);
            make.width.mas_equalTo(28*0.8);
            make.centerY.mas_equalTo(topLable);
        }];
    }
    
    
    UIButton *buyAitBt = [[UIButton alloc]init];
    buyAitBt.titleLabel.font = [UIFont systemFontOfSize:12];
    [buyAitBt addTarget:self action:@selector(buyAitBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:buyAitBt];
    if(kWindowW>320){
        [buyAitBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(buyLablezuoShan);
            make.width.mas_equalTo(246/2);
            make.right.mas_equalTo(-39/2);
            make.height.mas_equalTo(83/2);
        }];
    }else{
        [buyAitBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(buyLablezuoShan);
            make.width.mas_equalTo(246/2*0.8);
            make.right.mas_equalTo(-39/2*0.8);
            make.height.mas_equalTo(83/2*0.8);
        }];
    }
    
    
    UILabel * NobuyLablezuoShan = [[UILabel alloc]init];
    [NobuyLablezuoShan setTextColor:kRGBColor(74, 74, 74)];
    NobuyLablezuoShan.text = @"或设置已有AIT设备序列号：";
    NobuyLablezuoShan.font = [UIFont systemFontOfSize:12];
    NobuyLablezuoShan.numberOfLines=0;
    [view addSubview:NobuyLablezuoShan];
    if(kWindowW>320){
        [NobuyLablezuoShan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19);
            make.bottom.mas_equalTo(-63/2);
            make.width.mas_equalTo(342/2);
        }];
    }else{
        [NobuyLablezuoShan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(19*0.8);
            make.bottom.mas_equalTo(-63/2*0.8);
            make.width.mas_equalTo(342/2*0.8);
        }];
    }
    
    
    UIView * bomView = [[UIView alloc]init];
    [bomView.layer setMasksToBounds:YES];
    [bomView.layer setBorderWidth:0.5];
    [bomView.layer setBorderColor:UIColorFromRGBA(0x858488, 1.0).CGColor];
    [view addSubview:bomView];
    if(kWindowW>320){
        [bomView.layer setCornerRadius:83/4];
        [bomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(NobuyLablezuoShan);
            make.width.mas_equalTo(246/2);
            make.right.mas_equalTo(-39/2);
            make.height.mas_equalTo(83/2);
        }];
    }else{
        [bomView.layer setCornerRadius:83/4*0.8];
        [bomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(NobuyLablezuoShan);
            make.width.mas_equalTo(246/2*0.8);
            make.right.mas_equalTo(-39/2*0.8);
            make.height.mas_equalTo(83/2*0.8);
        }];
    }
    
    UILabel * bomLable = [[UILabel alloc]init];
    bomLable.text = @"设置序列号";
    [bomLable setTextColor:UIColorFromRGBA(0x4A90E2, 1.0)];
    [bomView addSubview:bomLable];
    if(kWindowW>320){
        bomLable.font=[UIFont systemFontOfSize:12];
        [bomLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(7.5);
            make.centerY.mas_equalTo(bomView);
        }];
    }else{
        bomLable.font=[UIFont systemFontOfSize:12*0.8];
        [bomLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(7.5*0.8);
            make.centerY.mas_equalTo(bomView);
        }];
    }
    
    
    UIImageView * bomImg = [[UIImageView alloc]init];
    bomImg.image = [UIImage imageNamed:@"AIT_set"];
    bomImg.contentMode = UIViewContentModeScaleAspectFit;
    [bomView addSubview:bomImg];
    if(kWindowW>320){
        [bomImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topLable.mas_right).mas_equalTo(4.5);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(28);
            make.centerY.mas_equalTo(bomLable);
        }];
    }else{
        [bomImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topLable.mas_right).mas_equalTo(4.5*0.8);
            make.height.mas_equalTo(28*0.8);
            make.width.mas_equalTo(28*0.8);
            make.centerY.mas_equalTo(bomLable);
        }];
    }
    
    
    UIButton *settingAitBt = [[UIButton alloc]init];
    [settingAitBt addTarget:self action:@selector(settingAitBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:settingAitBt];
    if(kWindowW>320){
        [settingAitBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(NobuyLablezuoShan);
            make.width.mas_equalTo(246/2);
            make.right.mas_equalTo(-39/2);
            make.height.mas_equalTo(83/2);
        }];
    }else{
        [settingAitBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(NobuyLablezuoShan);
            make.width.mas_equalTo(246/2*0.8);
            make.right.mas_equalTo(-39/2*0.8);
            make.height.mas_equalTo(83/2*0.8);
        }];
    }
    
    
    
    if ([KISDictionaryHaveKey(self.chuZhiDict, @"ait_switch") boolValue] == YES) {
        [self setYeMianYangShiWith:[KISDictionaryHaveKey(self.chuZhiDict, @"is_ait") boolValue]];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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


-(void)buyAitBtChick:(UIButton *)sender
{
    kWeakSelf(weakSelf)
    AITIntroduceViewController *vc = [[AITIntroduceViewController alloc]init];
    [weakSelf.navigationController pushViewController:vc animated:YES];
}
-(void)settingAitBtChick:(UIButton *)sender
{
    kWeakSelf(weakSelf)
    SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
    [weakSelf.navigationController pushViewController:vc animated:YES];
}
-(void)setYeMianYangShiWith:(BOOL)sender
{
    if (sender == YES) {
        self.xiatuLable.text = @"该车型可使用AIT设备，请插入设备进行检测";
    }else{
        self.xiatuLable.text = @"AIT产品插入汽车可直接检测";
    }
}
@end

