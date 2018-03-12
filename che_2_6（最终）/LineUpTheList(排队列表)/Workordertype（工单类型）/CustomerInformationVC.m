//
//  CustomerInformationVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/31.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CustomerInformationVC.h"
#import "UIImageView+WebCache.h"
#import "WritePersonalViewController.h"
#import "kehuXuQiuViewController.h"
#import "MaintenanceHistoryVC.h"
#import "AddXiMeiViewController.h"

@interface CustomerInformationVC ()

@property(nonatomic,strong)UIScrollView *maScrollView;

@end

@implementation CustomerInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"客户信息" withBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.maScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-60)];
    [self.view addSubview:self.maScrollView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    while ([self.maScrollView.subviews lastObject] != nil)
    {
        [[self.maScrollView.subviews lastObject] removeFromSuperview];
    }
    [self setBuJuWithmaScrollView:self.maScrollView];
}


-(void)setBuJuWithmaScrollView:(UIScrollView *)maScrollView
{
    NSArray *users_cars = KISDictionaryHaveKey(self.userInformetionDict, @"users_cars");
    NSArray *order_list = KISDictionaryHaveKey(self.userInformetionDict, @"order_list");
    
    CGFloat jisuanHei = 0;
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 89)];
    jisuanHei += 89;
    [maScrollView addSubview:view1];
    UILabel *line1 = [[UILabel alloc]init];
    line1.backgroundColor = kLineBgColor;
    [view1 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    UILabel *chepaLabel = [[UILabel alloc]init];
    [chepaLabel.layer setMasksToBounds:YES];
    chepaLabel.textColor = [UIColor whiteColor];
    [chepaLabel.layer setCornerRadius:2];
    [chepaLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
    [chepaLabel.layer setBorderWidth:1];
    chepaLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_cars[0], @"car_number")];
    chepaLabel.textAlignment = NSTextAlignmentCenter;
    chepaLabel.font = [UIFont boldSystemFontOfSize:14];
    [view1 addSubview:chepaLabel];
    [chepaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(13);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(20);
    }];
    
    UIView *chepaView = [[UIView alloc]init];
    [chepaView.layer setMasksToBounds:YES];
    [chepaView.layer setCornerRadius:2];
    chepaView.backgroundColor = kChePaiColor;
    [view1 addSubview:chepaView];
    [chepaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(chepaLabel.mas_left).mas_equalTo(-3);
        make.top.mas_equalTo(chepaLabel.mas_top).mas_equalTo(-3);
        make.bottom.mas_equalTo(chepaLabel.mas_bottom).mas_equalTo(3);
        make.right.mas_equalTo(chepaLabel.mas_right).mas_equalTo(3);
    }];
    [view1 bringSubviewToFront:chepaLabel];
    
    UIImageView *jianTouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
    [view1 addSubview:jianTouImageView];
    [jianTouImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(chepaView);
        make.width.height.mas_equalTo(19);
    }];
    
    UILabel *naemMoLabel = [[UILabel alloc]init];
    naemMoLabel.font = [UIFont systemFontOfSize:14];
    if (self.xiMeiZuiZhongModel) {
        naemMoLabel.text = [NSString stringWithFormat:@"%@  %@",self.xiMeiZuiZhongModel.realname,self.xiMeiZuiZhongModel.mobile];
    }else{
        naemMoLabel.text = [NSString stringWithFormat:@"%@  %@",self.zuiZhongModel.realname,self.zuiZhongModel.mobile];
    }
    naemMoLabel.textColor = kRGBColor(102, 102, 102);
    [view1 addSubview:naemMoLabel];
    [naemMoLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(jianTouImageView.mas_left).mas_equalTo(-5);
        make.centerY.mas_equalTo(chepaView);
    }];
    
    UIImageView *cheLeiImageView = [[UIImageView alloc]init];
    [cheLeiImageView sd_setImageWithURL:[NSURL URLWithString:KISDictionaryHaveKey(users_cars[0], @"brand_img")]];
    [view1 addSubview:cheLeiImageView];
    [cheLeiImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(50);
        make.width.height.mas_equalTo(25);
    }];
    
    UILabel *cheLeiLabel = [[UILabel alloc]init];
    cheLeiLabel.font = [UIFont systemFontOfSize:15];
    cheLeiLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_cars[0], @"car_info")];
    cheLeiLabel.textColor = kRGBColor(102, 102, 102);
    [view1 addSubview:cheLeiLabel];
    [cheLeiLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cheLeiImageView.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(cheLeiImageView);
    }];
    
    UIButton *xiugaiBt = [[UIButton alloc]init];
    [xiugaiBt addTarget:self action:@selector(xiugaiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view1 addSubview:xiugaiBt];
    [xiugaiBt  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(kWindowW/2);
    }];
    //    ==========================================
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, jisuanHei, kWindowW, 45)];
    jisuanHei += 45;
    [maScrollView addSubview:view2];
    UILabel *line2 = [[UILabel alloc]init];
    line2.backgroundColor = kLineBgColor;
    [view2 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *zuoLabe2 = [[UILabel alloc]init];
    zuoLabe2.font = [UIFont systemFontOfSize:14];
    if (self.shiFouWeiXiu) {
        zuoLabe2.text = @"历史维修记录";
    }else{
        zuoLabe2.text = @"历史洗美记录";
    }
    
    zuoLabe2.textColor = kRGBColor(51, 51, 51);
    [view2 addSubview:zuoLabe2];
    [zuoLabe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view2);
        make.left.mas_equalTo(10);
    }];
    
    UIImageView *jianTouImageView2 = [[UIImageView alloc]initWithImage:DJImageNamed(@"hall_jiantou-1")];
    [view2 addSubview:jianTouImageView2];
    [jianTouImageView2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(view2);
        make.width.height.mas_equalTo(19);
    }];
    
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.font = [UIFont systemFontOfSize:14];
    if ([NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.userInformetionDict, @"last_time")].length>0) {
        dateLabel.text = [NSString stringWithFormat:@"上次到店时间：%@",KISDictionaryHaveKey(self.userInformetionDict, @"last_time")];
    }else{
        dateLabel.text = @"无";
    }
    
    dateLabel.textColor = kRGBColor(102, 102, 102);
    [view2 addSubview:dateLabel];
    [dateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(jianTouImageView2.mas_left).mas_equalTo(-5);
        make.centerY.mas_equalTo(view2);
    }];
    
    UIButton *weiXiuBt = [[UIButton alloc]init];
    [weiXiuBt addTarget:self action:@selector(weiXiuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view2 addSubview:weiXiuBt];
    [weiXiuBt  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(kWindowW/2);
    }];
    
#warning 客户预约
    
//    if (order_list.count>0) {
//        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, jisuanHei, kWindowW, 260)];
//        jisuanHei += 260;
//        [maScrollView addSubview:view3];
//        
//        UIImageView *yuyueImage = [[UIImageView alloc]initWithImage:DJImageNamed(@"new_liShiYuYue")];
//        [view3 addSubview:yuyueImage];
//        [yuyueImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(10);
//            make.width.height.mas_equalTo(19);
//        }];
//        
//        UILabel *yuyueLabel = [[UILabel alloc]init];
//        yuyueLabel.text = @"该客户当日预约";
//        yuyueLabel.font = [UIFont systemFontOfSize:15];
//        yuyueLabel.textColor = kRGBColor(51, 51, 51);
//        [view3 addSubview:yuyueLabel];
//        [yuyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(yuyueImage);
//            make.left.mas_equalTo(73/2);
//        }];
//        
//        UIView *yuyueView = [[UIView alloc]init];
//        [view3 addSubview:yuyueView];
//        [yuyueView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(view3);
//            make.top.mas_equalTo(yuyueLabel.mas_bottom).mas_equalTo(19);
//            make.width.mas_equalTo(167);
//            make.height.mas_equalTo(209);
//        }];
//        
//        UIImageView *yuyueBackIm = [[UIImageView alloc]initWithImage:DJImageNamed(@"new_yuYueView")];
//        [yuyueView addSubview:yuyueBackIm];
//        [yuyueBackIm mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(0);
//        }];
//        
//        UIImageView *tuBiaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_repair_old")];
//        [yuyueView addSubview:tuBiaoImageView];
//        [tuBiaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(10);
//            make.centerX.mas_equalTo(yuyueView);
//            make.width.height.mas_equalTo(22);
//        }];
//        
//        UILabel *yuyueLabelTitle = [[UILabel alloc]init];
//        yuyueLabelTitle.textColor = kRGBColor(51, 51, 51);
//        yuyueLabelTitle.text = @"工单预约";
//        yuyueLabelTitle.font = [UIFont boldSystemFontOfSize:15];
//        [yuyueView addSubview:yuyueLabelTitle];
//        [yuyueLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(41);
//            make.centerX.mas_equalTo(yuyueView);
//        }];
//        
//        UILabel *yuYueline = [[UILabel alloc]init];
//        yuYueline.backgroundColor = kLineBgColor;
//        [yuyueView addSubview:yuYueline];
//        [yuYueline mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.top.mas_equalTo(75);
//            make.height.mas_equalTo(1);
//        }];
//        
//        NSDictionary *order_listDict = order_list[0];
//        
//        UILabel *yuyueLabelLeiBie = [[UILabel alloc]init];
//        yuyueLabelLeiBie.textColor = kRGBColor(51, 51, 51);
//        yuyueLabelLeiBie.font = [UIFont boldSystemFontOfSize:13];
//        yuyueLabelLeiBie.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(order_listDict, @"service")];
//        yuyueLabelLeiBie.numberOfLines = 0;
//        [yuyueView addSubview:yuyueLabelLeiBie];
//        [yuyueLabelLeiBie mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.top.mas_equalTo(81);
//        }];
//        
//        UILabel *yuyueLabelDate = [[UILabel alloc]init];
//        yuyueLabelDate.textColor = kRGBColor(155, 155, 155);
//        yuyueLabelDate.font = [UIFont boldSystemFontOfSize:12];
//        yuyueLabelDate.text = [NSString stringWithFormat:@"预约到店时间：\n%@",KISDictionaryHaveKey(order_listDict, @"appointment")];
//        yuyueLabelDate.numberOfLines = 2;
//        [yuyueView addSubview:yuyueLabelDate];
//        [yuyueLabelDate mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.top.mas_equalTo(114);
//        }];
//    }
    maScrollView.contentSize = CGSizeMake(kWindowW, jisuanHei);
    
    //    ====================================
    UIButton *okButton = [[UIButton alloc]init];
    okButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [okButton setTitle:@"新建工单" forState:(UIControlStateNormal)];
    [okButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:5];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-13);
        make.height.mas_equalTo(47);
    }];
}

-(void)xiugaiBtChick:(UIButton *)sender
{
    WritePersonalViewController *vc = [[WritePersonalViewController alloc] init];
    vc.shiFouQieHuan = YES;
    if (self.shiFouWeiXiu == YES) {
        vc.zuiZhongModel = self.zuiZhongModel;
    }else{
        vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
    }
    NSDictionary *users_details = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
    vc.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"user_id")];
    [OrderInfoPushManager sharedOrderInfoPushManager].type = OrderInfoPushTypePerctInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)weiXiuBtChick:(UIButton *)sender
{
    MaintenanceHistoryVC *vc = [[MaintenanceHistoryVC alloc]init];
    NSDictionary *users_details = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
    vc.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"user_id")];
    vc.shiFouWeiXiu = self.shiFouWeiXiu;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)okButtonChick:(UIButton *)sendre
{
    if (self.shiFouWeiXiu) {
        kehuXuQiuViewController *kehuXuQiu = [kehuXuQiuViewController new];
        [self.navigationController pushViewController:kehuXuQiu animated:YES];
    }else{
        AddXiMeiViewController *vc = [[AddXiMeiViewController alloc]init];
        vc.userInformetionDict = self.userInformetionDict;
#warning 家数据
        vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
