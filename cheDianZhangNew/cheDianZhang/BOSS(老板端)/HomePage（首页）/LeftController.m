//
//  LeftController.m
//  LeftMenu
//
//  Created by iMac on 17/4/24.
//  Copyright © 2017年 zws. All rights reserved.
//

#import "LeftController.h"
#import "UIViewController+MMDrawerController.h"
#import "BossUserMeViewController.h"
#import "LeftTableViewCell.h"
#import "BossUserSetViewController.h"
#import "PushController.h"
#import "StoresInformationViewController.h"

#import "MyCollectionViewController.h"
#import "BossJianCeViewController.h"
#import "MykechengViewController.h"
#import "HistroyLookVController.h"
#import "BOSSSystemMessageVC.h"

@interface LeftController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;


@end

@implementation LeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kRGBColor(88, 158, 254).CGColor,  (__bridge id)kRGBColor(50, 88, 225).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    [self.view.layer addSublayer:gradientLayer];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];

    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kWindowW-100, kWindowH-80) style:UITableViewStyleGrouped];
    self.tableview.dataSource = self;
    self.tableview.delegate  = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    
    
    UIImageView *setImage = [[UIImageView alloc]initWithImage:DJImageNamed(@"BOOS_user_set")];
    setImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:setImage];
    [setImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.bottom.mas_equalTo(-26);
        make.height.with.mas_equalTo(20);
    }];
    UILabel *setLabel = [[UILabel alloc]init];
    setLabel.font = [UIFont systemFontOfSize:17];
    setLabel.text = @"设置";
    setLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:setLabel];
    [setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(setImage.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(setImage);
    }];
    
    UIButton *setBt = [[UIButton alloc]init];
    [setBt addTarget:self action:@selector(setBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:setBt];
    [setBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(setImage);
        make.right.mas_equalTo(setLabel);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(setImage);
    }];
    
    
    UIImageView *setFanKui = [[UIImageView alloc]initWithImage:DJImageNamed(@"BOOS_user_fanKui")];
    setFanKui.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:setFanKui];
    [setFanKui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(setLabel.mas_right).mas_equalTo(30);
        make.bottom.mas_equalTo(-26);
        make.height.with.mas_equalTo(20);
    }];
    UILabel *fanKuiLabel = [[UILabel alloc]init];
    fanKuiLabel.font = [UIFont systemFontOfSize:17];
    fanKuiLabel.text = @"意见反馈";
    fanKuiLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:fanKuiLabel];
    [fanKuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(setFanKui.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(setFanKui);
    }];
    
    UIButton *fanKuiBt = [[UIButton alloc]init];
    [fanKuiBt addTarget:self action:@selector(fanKuiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:fanKuiBt];
    [fanKuiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(setFanKui);
        make.right.mas_equalTo(fanKuiLabel);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(setFanKui);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
}

-(void)setBtChick:(UIButton *)sender
{
    BossUserSetViewController *vc = [[BossUserSetViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    //拿到我们的LitterLCenterViewController，让它去push
    UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
    UINavigationController *newNav = nav.selectedViewController;
    [newNav pushViewController:vc animated:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}
-(void)fanKuiBtChick:(UIButton *)sender
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.mainImageView.image = DJImageNamed(@"BOOS_user_xiaoxi");
        cell.mainLabl.text = @"消息通知";
    } else if (indexPath.row == 1) {
        cell.mainImageView.image = DJImageNamed(@"BOOS_user_keCheng");
        cell.mainLabl.text = @"我的课程";
    } else if (indexPath.row == 2) {
        cell.mainImageView.image = DJImageNamed(@"BOOS_user_lishi");
        cell.mainLabl.text = @"历史观看";
    } else if (indexPath.row == 3) {
        cell.mainImageView.image = DJImageNamed(@"BOOS_user_jiance");
        cell.mainLabl.text = @"我的测验";
    } else if (indexPath.row == 4) {
        cell.mainImageView.image = DJImageNamed(@"BOOS_user_shouCang");
        cell.mainLabl.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.mainImageView.image = DJImageNamed(@"BOOS_user_menDian");
        cell.mainLabl.text = @"门店消息";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){
        BOSSSystemMessageVC *pushVc=[[BOSSSystemMessageVC alloc]init];
        UITabBarController *nav=(UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVc.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVc animated:YES];
        
    }else if(indexPath.row==1){
        MykechengViewController*pushVc=[[MykechengViewController alloc]init];
        UITabBarController *nav=(UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVc.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVc animated:YES];
    }else if(indexPath.row==2){
        HistroyLookVController*pushVc=[[HistroyLookVController alloc]init];
        UITabBarController *nav=(UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVc.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVc animated:YES];
    }else if(indexPath.row==3){
        BossJianCeViewController*pushVc=[[BossJianCeViewController alloc]init];
        UITabBarController *nav=(UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVc.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVc animated:YES];
    }else if (indexPath.row == 4) {
        MyCollectionViewController *pushVC = [[MyCollectionViewController alloc]init];
        UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVC.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVC animated:YES];
    }else if (indexPath.row == 5) {
        
        StoresInformationViewController *pushVC = [[StoresInformationViewController alloc] init];
        
        //拿到我们的LitterLCenterViewController，让它去push
        UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVC.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVC animated:YES];
    }else{
        PushController *pushVC = [[PushController alloc] init];
        pushVC.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
        //拿到我们的LitterLCenterViewController，让它去push
        UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
        UINavigationController *newNav = nav.selectedViewController;
        pushVC.hidesBottomBarWhenPushed  = YES;
        [newNav pushViewController:pushVC animated:YES];
    }
    
    
    
//    当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}
//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *touImageView = [[UIImageView alloc]init];
    [touImageView.layer setMasksToBounds:YES];
    [touImageView.layer setCornerRadius:45/2];
    [touImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
    [view addSubview:touImageView];
    [touImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.width.height.mas_equalTo(45);
        make.centerY.mas_equalTo(view);
    }];
    
    UILabel *titieLabel = [[UILabel alloc]init];
    titieLabel.textColor = [UIColor whiteColor];
    titieLabel.text = [UserInfo shareInstance].userReal_name;
    titieLabel.adjustsFontSizeToFitWidth = YES;
    titieLabel.font = [UIFont systemFontOfSize:23];
    [view addSubview:titieLabel];
    [titieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(touImageView.mas_right).mas_equalTo(7);
        make.centerY.mas_equalTo(view);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *jianTouImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"BOOss_baiJIanTou")];
    [view addSubview:jianTouImageView];
    [jianTouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(view);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(16);
    }];
    
    
    UIButton *userBt = [[UIButton alloc]init];
    [userBt addTarget:self action:@selector(imgButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:userBt];
    [userBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    return view;
}


- (void)imgButtonAction {
    
    BossUserMeViewController *pushVC = [[BossUserMeViewController alloc] init];
    pushVC.hidesBottomBarWhenPushed = YES;
    
    //拿到我们的LitterLCenterViewController，让它去push
    UITabBarController* nav = (UITabBarController*)self.mm_drawerController.centerViewController;
    UINavigationController *newNav = nav.selectedViewController;
    newNav.hidesBottomBarWhenPushed  = YES;
    [newNav pushViewController:pushVC animated:YES];
    
    //    当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}


@end
