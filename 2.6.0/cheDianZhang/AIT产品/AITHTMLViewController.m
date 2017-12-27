//
//  AITHTMLViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/9.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITHTMLViewController.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import<WebKit/WebKit.h>
#import "SegmentButtonsView.h"
#import "DuplexTableView.h"

@interface AITHTMLViewController ()<WKUIDelegate,WKNavigationDelegate,DuplexTableDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView*    maiTabelView[2];
    WKWebView*    m_webView[2];
    UIButton*      m_mySegBtn[2];
    SegmentButtonsView*  m_segButtonsView;
    DuplexTableView *m_moreTable;
}

@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation AITHTMLViewController


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
    if ([keyPath isEqual: @"estimatedProgress"] && object == m_webView[0]) {
        [self.view bringSubviewToFront:self.progressView];
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:m_webView[0].estimatedProgress animated:YES];
        if(m_webView[0].estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else if ([keyPath isEqual: @"estimatedProgress"] && object == m_webView[1]) {
        [self.view bringSubviewToFront:self.progressView];
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:m_webView[1].estimatedProgress animated:YES];
        if(m_webView[1].estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// 记得取消监听
- (void)dealloc {
    for (int i = 0; i<2; i++) {
        [m_webView[i] removeObserver:self forKeyPath:@"estimatedProgress"];
        [m_webView[i] setNavigationDelegate:nil];
        [m_webView[i] setUIDelegate:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.chuanZhiArray.count == 1) {
        [self setTopViewWithTitle:[NSString stringWithFormat:@"%@AIT检测报告",KISDictionaryHaveKey(self.chuanZhiArray[0], @"name")] withBackButton:YES];
        [self danGeView];
    }else{
        [self setTopViewWithTitle:@"AIT检测报告" withBackButton:YES];
        [self buildMainViewWitharray:self.chuanZhiArray];
    }
}

-(void)danGeView
{
    m_webView[0] = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    m_webView[0].UIDelegate = self;
    m_webView[0].navigationDelegate = self;

    [m_webView[0] addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [m_webView[0] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KISDictionaryHaveKey(self.chuanZhiArray[0], @"url")]]];
    
    m_webView[0].scrollView.backgroundColor = [UIColor whiteColor];
    m_webView[0].scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
    
    [self.view addSubview:m_webView[0]];
}

#pragma mark 分栏
- (void)buildMainViewWitharray:(NSArray *)array
{
    //----------按钮-------------//
    NSMutableArray* btns = [[NSMutableArray alloc] init];
    if (![array isKindOfClass:[NSArray class]]) {
        return;
    }
    CGFloat jisuanKuai = kWindowW/(array.count);
    for (int i = 0; i < array.count; i++) {
        m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(jisuanKuai*i, 0, jisuanKuai, 43)];
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor grayColor];
        [m_mySegBtn[i] addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        [m_mySegBtn[i] setTitle:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"name")] forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(102, 102, 102, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kNavBarColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        m_mySegBtn[i].titleLabel.font = DJSystemFont(KAddFont_6P(16.0));
        m_mySegBtn[i].tag = i;
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 43-1.5, jisuanKuai, 1.5)];
    bottomView.backgroundColor = kNavBarColor;
    m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake(0,kNavBarHeight, kWindowW, 43) buttonArray:btns bottomView:bottomView];
    [self.view addSubview:m_segButtonsView];
    
    for (int i = 0; i < array.count; i++) {
        maiTabelView[i] = [[UITableView alloc]initWithFrame:CGRectMake(kWindowW * i, 0, kWindowW, kWindowH-kNavBarHeight-43)];
        maiTabelView[i].separatorStyle = UITableViewCellSeparatorStyleNone;
        maiTabelView[i].delegate = self;
        maiTabelView[i].dataSource = self;
        maiTabelView[i].scrollEnabled = NO;
        
        
        m_webView[i] = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-kNavBarHeight-43)];
        m_webView[i].UIDelegate = self;
        m_webView[i].navigationDelegate = self;
        //    [m_webView sizeToFit];
        [m_webView[i] addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
        [m_webView[i] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KISDictionaryHaveKey(self.chuanZhiArray[i], @"url")]]];

        m_webView[i].scrollView.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
            m_webView[0].scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        }else{
            m_webView[1].scrollView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData1)];
        }
        
        [maiTabelView[i] addSubview:m_webView[i]];
    }
    
    
    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+43, kWindowW, kWindowH-kNavBarHeight-43)];
    m_moreTable.backgroundColor = [UIColor yellowColor];
    
    m_moreTable.myDelegate = self;
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count; i++) {
        [tableArray addObject:maiTabelView[i]];
    }
    [m_moreTable buildMainViewWithTabel:tableArray head:nil visibleHeight:40 isHaveDownRefresh:NO];
    [self.view addSubview:m_moreTable];
}

-(void)loadNewData0
{
    [m_webView[0].scrollView.mj_header endRefreshing];
    [m_webView[0] reload];
}
-(void)loadNewData1
{
    [m_webView[1].scrollView.mj_header endRefreshing];
    [m_webView[1] reload];
}
#pragma mark 切换

- (void)segmentButtonClick:(UIButton*)segBtn
{
    for (int i = 0; i <self.chuanZhiArray.count ; i++) {
        if (segBtn != m_mySegBtn[i]) {
            m_mySegBtn[i].selected = NO;
        }
        else{
            m_mySegBtn[i].selected = YES;
        }
    }
    NSUInteger tag = segBtn.tag;//1,2
    [m_moreTable setFatherScrollToIndex:tag];
    
    [self tableChangedToIndex:tag];
}
- (void)tableChangedToIndex:(NSInteger)index
{
    [m_segButtonsView SGBscrollViewDidEndDecelerating:index];
}
- (void)fatherScrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    NSInteger index = offsetofScrollView.x/CGRectGetWidth(scrollView.frame);
    for (int i = 0; i < self.chuanZhiArray.count; i++) {
        if (i != index) {
            m_mySegBtn[i].selected = NO;
        }
        else{
            m_mySegBtn[i].selected = YES;
        }
    }
    [m_segButtonsView SGBscrollViewDidScroll:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //表格滑动
    [m_moreTable tableViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    return cell;
}

@end
