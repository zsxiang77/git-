//
//  TheWorkbenchViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "DuplexTableView.h"
#import "SegmentButtonsView.h"
#import "WorkOrderTypeVC.h"


@interface TheWorkbenchViewController ()<DuplexTableDelegate,UITableViewDelegate,UITableViewDataSource>
{
    DuplexTableView*    m_moreTable;
    SegmentButtonsView* m_segButtonsView;
    BOOL                 isUserPush;
}

@property(nonatomic,assign)BOOL shiFouJiaZai;
@end

@implementation TheWorkbenchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"工作台" withBackButton:NO];
    diJiYeIndex = 0;
    [self rREQUEST_METHODNetwork];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:kJieShouXiaoXi object:nil];
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    
    NSString *content_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(userInfo, @"content_type")];
    
    if ([content_type isEqualToString:@"3"]) {
        if (self.shiFouJiaZai == YES) {
            [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
        }
        self.shiFouJiaZai = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJieShouXiaoXi object:nil];
    
    if (self.shiFouJiaZai == YES) {
       [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
    }
    self.shiFouJiaZai = YES;
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
        [m_mySegBtn[i] setTitle:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] forState:UIControlStateNormal];
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
    
    //底部表格
    for (int i = 0; i < array.count; i++) {
        
        main_dataArry[i] = [[NSMutableArray alloc]init];
        m_myTableView[i] = [[UITableView alloc]initWithFrame:CGRectMake(kWindowW * i, 0, kWindowW, kWindowH-[self getTabBarHeight]-43-kNavBarHeight) style:UITableViewStylePlain];
        
        m_myTableView[i].delegate = self;
        m_myTableView[i].tag = i + 2000;
        m_myTableView[i].dataSource = self;
        m_myTableView[i].backgroundColor = kColorWithRGB(246, 246, 246, 1.0);
        m_myTableView[i].tableFooterView = [[UIView alloc] init];
        m_myTableView[i].separatorStyle = UITableViewCellSeparatorStyleNone;
        
        m_myTableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
    }
    
    m_myTableView[0].contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+43, kWindowW, kWindowH-kNavBarHeight-43-[self getTabBarHeight])];
    m_moreTable.backgroundColor = [UIColor yellowColor];
    
    m_moreTable.myDelegate = self;
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count; i++) {
        [tableArray addObject:m_myTableView[i]];
    }
    [m_moreTable buildMainViewWithTabel:tableArray head:nil visibleHeight:40 isHaveDownRefresh:NO];
    [self.view addSubview:m_moreTable];
}

-(void)loadNewData0
{
     [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
}
#pragma mark 切换

- (void)segmentButtonClick:(UIButton*)segBtn
{
    NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
    
    for (int i = 0; i <array.count ; i++) {
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
    diJiYeIndex = index;
    if (main_dataArry[index].count<=0) {
        [m_myTableView[index].mj_header beginRefreshing];
    }
}
- (void)fatherScrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    NSInteger index = offsetofScrollView.x/CGRectGetWidth(scrollView.frame);
    NSArray *array = KISDictionaryHaveKey(self.numberDict, @"channels");
    for (int i = 0; i < array.count; i++) {
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
    if (tableView == m_myTableView[0]) {
        return main_dataArry[0].count;
    }else
    {
        return main_dataArry[1].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    TheWorkbenchNewCell *cell = (TheWorkbenchNewCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[TheWorkbenchNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    TheWorkModel *model;
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
    }else
    {
        model = main_dataArry[1][indexPath.row];
    }
    
    [cell refeleseWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TheWorkModel *model;
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
    }else
    {
        model = main_dataArry[1][indexPath.row];
    }
    [self getrequest_methodWithTheWorkModel:model];
}

@end
