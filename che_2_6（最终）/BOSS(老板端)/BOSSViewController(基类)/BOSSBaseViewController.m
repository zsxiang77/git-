//
//  BOSSBaseViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "AssistantMenuView.h"
#import "UMMobClick/MobClick.h"
#import "LonInViewController.h"
#import "FillVINCodeViewController.h"

@interface BOSSBaseViewController ()
{
    UILabel* showLabel;//黑底白字 提示文字
    UIView* m_showWindowView;//图片 window
}

@end

@implementation BOSSBaseViewController


-(void)setAlertControllerWithTitle:(NSString *)titlr message:(NSString *)message actionTitle:(NSString  *)titi
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:titlr message:message delegate:self cancelButtonTitle:titi otherButtonTitles:nil];
    [alt show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:m_mainTopTitle];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:m_mainTopTitle];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGBA(0XF5F5F5, 1);
    
    self.automaticallyAdjustsScrollViewInsets = NO;//scrollView 20px的差
    // 解决内容超出frame显示
    self.edgesForExtendedLayout = UIRectEdgeNone;               //视图控制器，四条边不指定
    self.extendedLayoutIncludesOpaqueBars = NO;                 //不透明的操作栏<br>    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    
    m_loadView = [[BOSSLoadView alloc] init];
    [self.view addSubview:m_loadView];
    m_loadView.hidden = YES;
    
    [UserInfo shareInstance].shiFouBOSS = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setTopViewWithTitle:(NSString*)titleStr withRootBackButton:(BOOL)hasBacButton
{
    m_mainTopTitle = titleStr;
    
    m_baseTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kNavBarHeight)];
    m_baseTopView.backgroundColor = kNavBarColor;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kRGBColor(88, 158, 254).CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)kRGBColor(50, 88, 225).CGColor];
    gradientLayer.locations = @[@1.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, kWindowW, kBOSSNavBarHeight);
    [m_baseTopView.layer addSublayer:gradientLayer];
    
    
    [self.view addSubview:m_baseTopView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight-1, kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [m_baseTopView addSubview:line];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kWindowW-100, 44)];
    titleLabel.textColor = kRGBColor(51, 51, 51);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [m_baseTopView addSubview:titleLabel];
    
    if (hasBacButton) {
        UIImageView *backImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"back_btn")];
        backImageView.frame = CGRectMake(10, (kBOSSNavBarHeight - 27)/2+10,15*0.8 ,25*0.8);
        [m_baseTopView addSubview:backImageView];
        
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        //        [backButton setBackgroundImage:DJImageNamed(@"") forState:UIControlStateNormal];
        //        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backRootButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [m_baseTopView addSubview:backButton];
    }
}
- (void)setTopViewWithTitle:(NSString*)titleStr withBackButton:(BOOL)hasBacButton
{
    m_mainTopTitle = titleStr;
    
    m_baseTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kBOSSNavBarHeight)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kRGBColor(88, 158, 254).CGColor,  (__bridge id)kRGBColor(50, 88, 225).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, kWindowW, kBOSSNavBarHeight);
    [m_baseTopView.layer addSublayer:gradientLayer];
    [self.view addSubview:m_baseTopView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight-1, kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [m_baseTopView addSubview:line];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kWindowW-100, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.tag = 200;
    [m_baseTopView addSubview:titleLabel];
    
    if (hasBacButton) {
        UIImageView *backImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_back_btn")];
        backImageView.frame = CGRectMake(10, (kBOSSNavBarHeight - 27)/2+10,13,21);
        [m_baseTopView addSubview:backImageView];
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        //        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        [backButton setBackgroundImage:DJImageNamed(@"back_btn") forState:UIControlStateNormal];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [m_baseTopView addSubview:backButton];
    }
}

-(void)settitleLabelText:(NSString *)title
{
    UILabel* titleLabel = [m_baseTopView viewWithTag:200];
    titleLabel.text = title;
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backRootButtonClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) setNavBarToBring
{
    [self.view bringSubviewToFront:m_baseTopView];
}

#pragma mark 联网框
- (void)showOrHideLoadView:(BOOL)isShow
{
    if (isShow) {
        [m_loadView displayView];
        [self.view bringSubviewToFront:m_loadView];
    }
    else{
        [m_loadView dismissView];
    }
}

#pragma mark 黑底白字提示

- (void)showMessageWithContent:(NSString*)content point:(CGPoint)point afterDelay:(float)delay
{
    if (showLabel != nil) {
        [showLabel removeFromSuperview];
    }
    if (content == nil || content.length == 0) {
        return;
    }
    CGRect contentSize = [content boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KAddFont_6P(15.0)]} context:nil];
    
    float width = MIN(contentSize.size.width + 60, 300);
    
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, contentSize.size.height + 20)];
    showLabel.center = point;
    showLabel.backgroundColor = kColorWithRGB(40, 40, 40, 1.0);
    showLabel.alpha = 1.0;
    showLabel.font = [UIFont systemFontOfSize:KAddFont_6P(15.0)];
    showLabel.numberOfLines = 0;
    showLabel.textColor = [UIColor whiteColor];
    showLabel.layer.cornerRadius = KIS_IPHONE_6P?4:2;
    showLabel.layer.masksToBounds = YES;
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.text = content;
    
    [self.view addSubview:showLabel];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideView) object:nil];//取消该方法的调用
    [self performSelector:@selector(hideView) withObject:nil afterDelay:delay inModes:@[NSRunLoopCommonModes]];//touch 上反应迟缓
}

- (void)hideView
{
    showLabel.frame = CGRectZero;
}

#pragma mark window提示
- (void)showMessageWindowWithTitle:(NSString*)content point:(CGPoint)point delay:(float)delay
{
    if (m_showWindowView != nil) {
        [m_showWindowView removeFromSuperview];
        m_showWindowView = nil;
    }
    
    CGRect contentSize = [content boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KAddFont_6P(15.0)]} context:nil];
    
    float width = MIN(contentSize.size.width + 60, 300);
    m_showWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, contentSize.size.height + 20)];
    m_showWindowView.center = point;
    m_showWindowView.backgroundColor = kColorWithRGB(40, 40, 40, 1.0);
    m_showWindowView.alpha = 1.0;
    m_showWindowView.layer.cornerRadius = KIS_IPHONE_6P?4:2;
    
    UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, contentSize.size.height + 20)];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = [UIFont systemFontOfSize:KAddFont_6P(15.0)];
    contentLabel.text = content;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [m_showWindowView addSubview:contentLabel];
    
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window addSubview:m_showWindowView];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideWindowView) object:nil];
    [self performSelector:@selector(hideWindowView) withObject:nil afterDelay:delay];
}

- (void)hideWindowView
{
    if (m_showWindowView != nil) {
        [m_showWindowView removeFromSuperview];
        m_showWindowView = nil;
    }
}

#pragma mark tabbar高度
- (float)getTabBarHeight
{
    NSLog(@"%@", NSStringFromCGRect(self.tabBarController.tabBar.frame));
    return CGRectGetHeight(self.tabBarController.tabBar.frame);
}

#pragma mark 无数据view
- (void)showNotDataView:(BOOL)isShow title:(NSString*)showTitle view:(UIView*)addView startY:(float)showY
{
    if([m_notDataView nextResponder] == addView){
        [m_notDataView removeFromSuperview];
    }
    if (isShow) {
        m_notDataView = [[UIView alloc] initWithFrame:CGRectMake(0, showY, CGRectGetWidth(self.view.frame), 100)];
        m_notDataView.backgroundColor = [UIColor clearColor];
        [addView addSubview:m_notDataView];
        
        UILabel* showL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(m_notDataView.frame), CGRectGetHeight(m_notDataView.frame))];
        showL.textAlignment = NSTextAlignmentCenter;
        [showL setText:showTitle];
        [showL setTextColor:kRGBColor(171, 171, 171)];
        showL.font = [UIFont boldSystemFontOfSize:18.0];
        showL.backgroundColor = [UIColor clearColor];
        [m_notDataView addSubview:showL];
    }
}

#pragma mark 请求失败view
- (void)showConnectFailView:(BOOL)isShow mySEL:(SEL)refreshRequest inView:(UIView*)addView startY:(float)startY
{
    if([m_notDataView nextResponder] == addView){
        [m_notDataView removeFromSuperview];
    }
    if (isShow) {
        m_notDataView = [[UIView alloc] initWithFrame:CGRectMake(0, startY, CGRectGetWidth(addView.frame), CGRectGetHeight(addView.frame)-startY)];
        m_notDataView.backgroundColor = [UIColor clearColor];
        [addView addSubview:m_notDataView];
        
        UIImageView* image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(m_notDataView.frame)-100, CGRectGetMidY(m_notDataView.frame)-100-startY-20, 200, 200)];
        image.image = DJImageNamed(@"data_fail");
        [m_notDataView addSubview:image];
        
        UIButton* touch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(m_notDataView.frame), CGRectGetHeight(m_notDataView.frame))];
        [touch addTarget:self action:refreshRequest forControlEvents:UIControlEventTouchUpInside];
        [m_notDataView addSubview:touch];
    }
}

- (void)showNotDataView:(BOOL)isShow title:(NSString*)showTitle view:(UIView*)addView startY:(float)showY font:(UIFont*)font textColor:(UIColor*)textColor
{
    if([m_notDataView nextResponder] == addView){
        [m_notDataView removeFromSuperview];
    }
    if (isShow) {
        m_notDataView = [[UIView alloc] initWithFrame:CGRectMake(0, showY, CGRectGetWidth(self.view.frame), 100)];
        m_notDataView.backgroundColor = [UIColor clearColor];
        [addView addSubview:m_notDataView];
        
        UILabel* showL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(m_notDataView.frame), CGRectGetHeight(m_notDataView.frame))];
        showL.textAlignment = NSTextAlignmentCenter;
        [showL setText:showTitle];
        [showL setTextColor:textColor];
        showL.font = font;
        showL.backgroundColor = [UIColor clearColor];
        [m_notDataView addSubview:showL];
    }
}

- (UIStatusBarStyle)preferredStausbarStyle {
    return UIStatusBarStyleLightContent;  //返回值是一个状态栏样式，这里我选择的是白色（亮色）文本颜色的样式
}

#pragma mark alertView
- (void)showAlertViewWithTitle:(NSString*)title Message:(NSString*)message buttonTitle:(NSString*)btnTitle
{
    //ios8.0键盘消失就使用alertView 等alertView消失后 键盘会闪一下（原因：键盘动画）
    if([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0){
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    else{
        
    }
}

#pragma mark- 助手
/**
 * 设置右上角的助手按钮
 */
- (void) setNavBarAssistantButtonWithItems:(NSArray*)items
{
    [self.menuItems addObjectsFromArray:items];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWindowW-30, 32, 21, 21)];
    imageView.image = DJImageNamed(@"ic_add_follow");//[UIImage imageNamed:@"assistant_icon"];
    [m_baseTopView addSubview:imageView];
    
    UIButton *assistantButton = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW-40, kNavBarHeight-44, 40, 44)];
    [assistantButton addTarget:self action:@selector(assistantButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [m_baseTopView addSubview:assistantButton];
}

- (NSMutableArray*) menuItems
{
    if (!_menuItems) {
        _menuItems = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return _menuItems;
}

- (void) assistantButtonClick:(id) sender
{
    AssistantMenuView *assistantMenuView = [[AssistantMenuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    [self.view addSubview:assistantMenuView];
    assistantMenuView.items = self.menuItems;
    [assistantMenuView showMenuView];
    
    kWeakSelf(weakSelf)
    assistantMenuView.didClickedMenuCallBack = ^(NSInteger index){
        [weakSelf assistantActionWithIndex:index];
    };
}

/**
 * 助手按钮的响应事件
 * 子类需重写此方法
 */
- (void) assistantActionWithIndex:(NSInteger) index
{
    
}

- (BOOL)loginCheck
{
    if (![UserInfo shareInstance].isLogined) {
        
        LonInViewController *vc = [[LonInViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self presentViewController:vc animated:YES completion:nil];
        return NO;
    }
    return YES;
}

@end
