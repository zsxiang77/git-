//
//  WKWebViewViewController.m
//  DaJiang365
//
//  Created by 周岁祥 on 2017/7/5.
//  Copyright © 2017年 泰宇. All rights reserved.
//

#import "WKWebViewViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import<WebKit/WebKit.h>

@interface WKWebViewViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    UILabel*      m_myTitleLabel;//title 获取html的title
    WKWebView*    m_webView;
}

@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation WKWebViewViewController


- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 2)];
        self.progressView.tintColor = [UIColor orangeColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:self.progressView];
        [self.view bringSubviewToFront:self.progressView];
    }
    return _progressView;
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == m_webView) {
        [self.view bringSubviewToFront:self.progressView];
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:m_webView.estimatedProgress animated:YES];
        if(m_webView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// 记得取消监听
- (void)dealloc {
    [m_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    // if you have set either WKWebView delegate also set these to nil here
    [m_webView setNavigationDelegate:nil];
    [m_webView setUIDelegate:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.navTitle) {
        [self setTopViewWithTitle:self.navTitle withBackButton:YES];
    }
    
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];//防止键盘弹不出来（掉完系统短信后 web的键盘无法弹出）
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    //    config.mediaPlaybackRequiresUserAction = NO;//把手动播放设置NO ios(8.0, 9.0)
    config.allowsInlineMediaPlayback = YES;//是否允许内联(YES)或使用本机全屏控制器(NO)，默认是NO。
    config.mediaPlaybackAllowsAirPlay = YES;//允许播放，ios(8.0, 9.0)
    
    
    m_webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-kNavBarHeight) configuration:config];
//    m_webView.backgroundColor
    if(self.isNoShowNavBar){
        m_webView.frame = CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }
    else{
        m_webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        if (@available(iOS 11.0, *)) {
            m_webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self buildNavBar];
//        m_webView.scrollView.bounces = NO;
    }
    m_webView.UIDelegate = self;
    m_webView.navigationDelegate = self;
    //    [m_webView sizeToFit];
    [m_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
//    if (self.wenAnName.length>0) {
//        NSString* path = [[NSBundle mainBundle] pathForResource:@"L_print" ofType:@"html"];
//        NPrintLog(@"path  %@",path);
//        NSData* htmldata = [NSData dataWithContentsOfFile:path];
//        NSString* htmlcontent = [[NSString alloc] initWithData:htmldata encoding:NSUTF8StringEncoding];
//        NSString *imagePath  = [[NSBundle mainBundle] bundlePath];
//        [m_webView loadHTMLString:htmlcontent baseURL:[NSURL fileURLWithPath:imagePath]];
//        [m_webView evaluateJavaScript:@"alertMessage('hello')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
//            NSLog(@"alert");
//        }];
//    }else
//    {
        [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
//    }
//    if (self.chuanData) {
//        NSString *str = (NSString *)self.chuanData;
//        NPrintLog(@"qwertty%@",str);
//        if (str.length>0) {
//            str = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\"><title>打印</title><script src='http://192.168.1.196:8000/CLodopfuncs.js'></script></head></html><script type=\"text/javascript\">;%@LODOP.PRINTA();</script>",str];
//        }
//
//        [m_webView loadHTMLString:str baseURL:nil];
//    }
    
    m_webView.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:m_webView];
    m_webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [m_webView.scrollView.mj_header endRefreshing];
        [m_webView reload];
    }];
    [m_baseTopView addSubview:self.guanBiBt];
}

#pragma mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();//此处的completionHandler()就是调用JS方法时，`evaluateJavaScript`方法中的completionHandler
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


-(UIButton *)guanBiBt
{
    if (!_guanBiBt) {
        _guanBiBt = [[UIButton alloc]initWithFrame:CGRectMake(40, 20, 40, 44)];
        [_guanBiBt setTitle:@"关闭" forState:(UIControlStateNormal)];
        [_guanBiBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_guanBiBt addTarget:self action:@selector(guanBiSelect:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _guanBiBt;
}
-(void)guanBiSelect:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backButtonClick:(id)sender
{
    if (m_webView.canGoBack == YES) {
        [m_webView goBack];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)buildNavBar
{
    [self setTopViewWithTitle:nil withBackButton:YES];
    m_mainTopTitle = @"html5";
    
    UIButton* refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-44, 20, 44, 44)];
    [refreshBtn setImage:DJImageNamed(@"refresh_btn_bg") forState:UIControlStateNormal];
    refreshBtn.backgroundColor = [UIColor clearColor];
    [refreshBtn addTarget:self action:@selector(refreshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    
    m_myTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, CGRectGetWidth(self.view.frame)-88, 44)];
    m_myTitleLabel.font = DJBoldSystemFont(18.0);
    m_myTitleLabel.textColor = [UIColor whiteColor];
    m_myTitleLabel.textAlignment = NSTextAlignmentCenter;
    m_myTitleLabel.text = self.navTitle;
    m_myTitleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:m_myTitleLabel];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self showOrHideLoadView:NO];
    if (self.navTitle == nil) {
//        m_myTitleLabel.text = [m_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    [m_webView.scrollView.mj_header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [self showOrHideLoadView:NO];
    [m_webView.scrollView.mj_header endRefreshing];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showOrHideLoadView:YES];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSMutableURLRequest *mutableRequest = [navigationAction.request mutableCopy];
    NSDictionary *requestHeaders = navigationAction.request.allHTTPHeaderFields;
    //我们项目使用的token同步的，cookie的话类似
    if (requestHeaders[@"Set-Cookie"]) {
        
        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
        
    } else {
        //这里添加请求头，把需要的都添加进来
        //        [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
        //        [mutableRequest setValue:[Global Datatoken]forHTTPHeaderField:@"token"];
        [mutableRequest setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
        //这个我发现不能使用，于是我就直接不写了，但是下边的换了一种写法，结果都能达到同步
        //        navigationAction.request=[mutableRequest copy];
        
        [webView loadRequest:mutableRequest];
        
        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    }
    
    
    NSURLRequest *request = navigationAction.request;
    
    NSURL* url = [request URL];
    NPrintLog(@"%@", url);
    if ([[url scheme] isEqualToString:@"html5back"]) {//需跳转
        NSString* pushType = [url host];
        if ([pushType isEqualToString:@"leagueList"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
//    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    
    
}

- (void)refreshButtonClick:(id)sender
{
    CGPoint offset = m_webView.scrollView.contentOffset;
    offset.y = -m_webView.scrollView.contentInset.top;
    [m_webView.scrollView setContentOffset:offset animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [m_webView reload];
    });
}




@end
