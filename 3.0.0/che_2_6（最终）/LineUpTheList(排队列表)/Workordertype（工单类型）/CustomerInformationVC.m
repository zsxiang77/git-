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
#import "GDYuYueViewController.h"
#import "DWSegmentedControl.h"

@interface CustomerInformationVC ()<DWSegmentedControlDelegate>
@property(nonatomic,strong)DWSegmentedControl *segmentedControl;
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

-(CustomerInformationYYueView *)fuCengView
{
    if (!_fuCengView) {
        _fuCengView = [[CustomerInformationYYueView alloc]init];
        _fuCengView.hidden = YES;
        [self.view addSubview:_fuCengView];
        [self.view bringSubviewToFront:_fuCengView];
    }
    return _fuCengView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    while ([self.maScrollView.subviews lastObject] != nil)
    {
        [[self.maScrollView.subviews lastObject] removeFromSuperview];
    }
    [self setBuJuWithmaScrollView:self.maScrollView];
    [self postHuoQuDataget_appointment];
}

-(void)postHuoQuDataget_appointment
{
    
    NSArray *order_list = KISDictionaryHaveKey(self.userInformetionDict, @"order_list");
    if (!([order_list isKindOfClass:[NSArray class]]&&order_list.count>0)) {
        return;
    }
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(order_list[0], @"ordercode")] forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_query/get_appointment" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            weakSelf.mainModel = [[CustomerInformationYYueModel alloc]init];
            [weakSelf.mainModel setDataShuJu:dataDic];
            
            [self upDataShuJu];
        }else{
            return ;
        }
    } failure:^(id error) {
        
    }];
}

-(void)upDataShuJu
{
    if ([self.mainModel.status integerValue] == 8) {
        yuYueTitleLabel.text = @"预约信息";
        yuYueTimeLabel.text=@"预约到店时间";
        yuYueTimeLabel2.text=self.mainModel.appointment;
        yuYueTitleXiaoLabel.text=@"工单预约";
        yuYueXiaoImageView.image = DJImageNamed(@"ic_repair_old");

    }else{
        yuYueTitleLabel.text = @"信息详情";
        yuYueTimeLabel.text=@"询价时间";
        yuYueTimeLabel2.text=self.mainModel.create_time;
        yuYueTitleXiaoLabel.text=@"询价追踪";
        yuYueXiaoImageView.image = DJImageNamed(@"Boss_jopHeader_xunJia");
    }

    yuYueLeiXLabel2.text=self.mainModel.order_type;
    yuYueSYuLabel2.text=[NSString stringWithFormat:@"还剩%@天到期",self.mainModel.end_days];
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
    if (order_list.count>0) {
        
        
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, jisuanHei, kWindowW, 260)];
        jisuanHei += 260;
        [maScrollView addSubview:view3];

        UIImageView *yuYueImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"new_liShiYuYue")];
        [view3 addSubview:yuYueImageView];
        [yuYueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.width.height.mas_equalTo(19);
        }];

        yuYueTitleLabel = [[UILabel alloc]init];
        yuYueTitleLabel.text = @"预约信息";
        yuYueTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        yuYueTitleLabel.textColor = kRGBColor(51, 51, 51);
        [view3 addSubview:yuYueTitleLabel];
        [yuYueTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(yuYueImageView);
            make.left.mas_equalTo(73/2);
        }];

        UIView *yuyueView = [[UIView alloc]init];
        [view3 addSubview:yuyueView];
        yuyueView.layer.shadowColor = kRGBColor(123, 123, 123).CGColor;//shadowColor阴影颜色
        yuyueView.layer.shadowOffset = CGSizeMake(5,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        yuyueView.layer.shadowOpacity = 0.5;
        yuyueView.layer.shadowRadius = 2;// 阴影扩散的范围控制
        yuyueView.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
        yuyueView.backgroundColor = [UIColor whiteColor];
        [yuyueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(yuYueImageView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(88);
        }];


        yuYueXiaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_repair_old")];
        [yuyueView addSubview:yuYueXiaoImageView];
        [yuYueXiaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(22);
        }];
        
        yuYueTitleXiaoLabel = [[UILabel alloc]init];
        yuYueTitleXiaoLabel.textColor = kRGBColor(51, 51, 51);
        yuYueTitleXiaoLabel.font = [UIFont boldSystemFontOfSize:15];
        [yuyueView addSubview:yuYueTitleXiaoLabel];
        [yuYueTitleXiaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(yuYueXiaoImageView);
            make.left.mas_equalTo(yuYueXiaoImageView.mas_right).mas_equalTo(5);
        }];
        
      
        yuYueTimeLabel=[[UILabel alloc]init];
        yuYueTimeLabel.textColor=kRGBColor(74, 74, 74);
        //yuYueTimeLabel.text=@"预约到店时间:";
        yuYueTimeLabel.font = [UIFont systemFontOfSize:13];
        [yuyueView addSubview:yuYueTimeLabel];
        [yuYueTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-10);
        }];
        
        yuYueTimeLabel2=[[UILabel alloc]init];
        yuYueTimeLabel2.textColor=kRGBColor(51, 51, 51);
        yuYueTimeLabel2.font = [UIFont boldSystemFontOfSize:13];
        [yuyueView addSubview:yuYueTimeLabel2];
        [yuYueTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(yuYueTimeLabel.mas_bottom).mas_equalTo(5);
            make.right.mas_equalTo(-10);
        }];
        
        
        
        yuYueLeiXLabel2=[[UILabel alloc]init];
        yuYueLeiXLabel2.textColor=kRGBColor(155, 155, 155);
        yuYueLeiXLabel2.font = [UIFont boldSystemFontOfSize:13];
        [yuyueView addSubview:yuYueLeiXLabel2];
        [yuYueLeiXLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(38);
            make.bottom.mas_equalTo(-15);
        }];
        
        yuYueSYuLabel2=[[UILabel alloc]init];
        yuYueSYuLabel2.textColor=kRGBColor(74, 144, 266);
        yuYueSYuLabel2.font = [UIFont systemFontOfSize:12];
        [yuyueView addSubview:yuYueSYuLabel2];
        [yuYueSYuLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(yuYueLeiXLabel2);
        }];
        
        yuYueQieHView = [[UIView alloc]init];
        [view3 addSubview:yuYueQieHView];
        [yuYueQieHView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(yuyueView.mas_bottom);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(200);
        }];
        
        
        _segmentedControl = ({
            DWSegmentedControl *sc = [[DWSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 85, 30)];
            sc.backgroundColor = [UIColor clearColor];
            sc.selectedViewColor = [UIColor colorWithHexString:@"4A90E2"];
            sc.normalLabelColor = [UIColor colorWithHexString:@"4a4a4a"];
            sc.delegate = self;
            sc.titles = @[@"是",@"否"];
            [yuYueQieHView addSubview:sc];
            [sc mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.right.mas_equalTo(-12);
                make.size.mas_equalTo(CGSizeMake(85, 30));
            }];
            sc;
        });
        self.shiFouYanYong = YES;

        UILabel *yuLabel = [[UILabel alloc]init];
        yuLabel.text = @"是否沿用预约：";
        yuLabel.font = [UIFont systemFontOfSize:13];
        yuLabel.textColor = kRGBColor(74, 74, 74);
        [yuYueQieHView addSubview:yuLabel];
        [yuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.segmentedControl);
            make.right.mas_equalTo(self.segmentedControl.mas_left).mas_equalTo(2);
        }];
        
        UIButton *yuyueViewBt = [[UIButton alloc]init];
        [yuyueViewBt addTarget:self action:@selector(yuyueViewBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [yuyueView addSubview:yuyueViewBt];
        [yuyueViewBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        
    }
    maScrollView.contentSize = CGSizeMake(kWindowW, jisuanHei);
    
    //    ====================================
    UIButton *okButton = [[UIButton alloc]init];
    okButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [okButton setTitle:@"下一步" forState:(UIControlStateNormal)];
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
-(void)yuyueViewBtChick:(UIButton *)sender
{
    self.fuCengView.mainModel = self.mainModel;
    self.fuCengView.hidden =! self.fuCengView.hidden;
    [self.view bringSubviewToFront:self.fuCengView];
    [self.fuCengView shuaXinDaTaShuJu];
}

#pragma mark - DWSegmentedControlDelegate
-(void)dw_segmentedControl:(DWSegmentedControl *)control didSeletRow:(NSInteger)row
{
    if (row == 0) {
        self.shiFouYanYong = YES;
    }else{
        self.shiFouYanYong = NO;
    }
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
        if ([self.mainModel isKindOfClass:[CustomerInformationYYueModel class]]) {
            if ([self.mainModel.status integerValue] == 8) {
                if (self.shiFouYanYong == YES) {
                    kehuXuQiu.mainModel = self.mainModel;
                }
            }
        }
        [self.navigationController pushViewController:kehuXuQiu animated:YES];
    }else{
        AddXiMeiViewController *vc = [[AddXiMeiViewController alloc]init];
        vc.userInformetionDict = self.userInformetionDict;
        vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    NSArray *order_list = KISDictionaryHaveKey(self.userInformetionDict, @"order_list");
//    if (order_list.count>0) {
//        GDYuYueViewController *vc = [[GDYuYueViewController alloc]init];
//        vc.userInformetionDict = self.userInformetionDict;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//    {
//        if (self.shiFouWeiXiu) {
//            kehuXuQiuViewController *kehuXuQiu = [kehuXuQiuViewController new];
//            [self.navigationController pushViewController:kehuXuQiu animated:YES];
//        }else{
//            AddXiMeiViewController *vc = [[AddXiMeiViewController alloc]init];
//            vc.userInformetionDict = self.userInformetionDict;
//            vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
}

@end
