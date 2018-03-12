//
//  StoreTheDataViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreTheDataViewController.h"
#import "MJRefresh.h"
#import<WebKit/WebKit.h>

@interface StoreTheDataViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    UILabel*      m_myTitleLabel;//title 获取html的title
    WKWebView*    m_webView;
}

@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation StoreTheDataViewController

- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 2)];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];//防止键盘弹不出来（掉完系统短信后 web的键盘无法弹出）
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.mediaPlaybackRequiresUserAction = NO;//把手动播放设置NO ios(8.0, 9.0)
    config.allowsInlineMediaPlayback = YES;//是否允许内联(YES)或使用本机全屏控制器(NO)，默认是NO。
    config.mediaPlaybackAllowsAirPlay = YES;//允许播放，ios(8.0, 9.0)
    
    m_webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-[self getTabBarHeight]) configuration:config];
    m_webView.UIDelegate = self;
    m_webView.navigationDelegate = self;
    //    [m_webView sizeToFit];
    [m_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sa/data_center/index",HOST_URLHTML]]]];
//    [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://inflexion.icarzoo.com/sa/data_center/index"]]];
//    [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://sv.baidu.com/videoui/page/videoland?context=%7B%22nid%22%3A%22sv_13427224545953515741%22%7D&pd=feedtab_h5&pagepdSid="]]];
    
    if (@available(iOS 11.0, *)) {
        m_webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    m_webView.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:m_webView];
    m_webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [m_webView.scrollView.mj_header endRefreshing];
        [m_webView reload];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
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
}


@end
