//
//  TheWorkbenchViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "WorkOrderTypeVC.h"


@interface TheWorkbenchViewController ()<DuplexTableDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL                 isUserPush;
}

@property(nonatomic,assign)BOOL shiFouJiaZai;
@end

@implementation TheWorkbenchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"" withBackButton:NO];
    
    weixiuMyList = YES;
    xiMeiMyList = YES;
    m_mainTopTitle = @"工作台";
    diJiYeIndex = 0;
    
    [self buildSearchView];
    [self rREQUEST_METHODNetwork];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessageBenDI) name:kShuaXinGuoZuoTai object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJieShouXiaoXi object:nil];
    
}



-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter removeObserver:self name:kJieShouXiaoXi object:nil];
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    
    NSString *content_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(userInfo, @"content_type")];
    
    if ([content_type isEqualToString:@"3"]) {
        if (self.shiFouJiaZai == YES) {
            [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
            if (self.seachTableView.hidden == NO) {
                [self postSearchrequest_methodDatawithShuaXin:YES];
            }
        }
        self.shiFouJiaZai = YES;
    }
    if ([content_type isEqualToString:@"11"]) {
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.channelsArray) {
        [self rREQUEST_METHODNetwork];
    }
    
}
-(void)networkDidReceiveMessageBenDI{
    [main_dataArry[0] removeAllObjects];
    [m_myTableView[0] reloadData];
    [main_dataArry[1] removeAllObjects];
    [m_myTableView[1] reloadData];
    
    [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
    
    if (self.seachTableView.hidden == NO) {
        [self postSearchrequest_methodDatawithShuaXin:YES];
    }
}
#pragma mark 搜索
-(void)resetTableScroll
{
    self.seachTableView.hidden = NO;
    [self.view bringSubviewToFront:self.seachTableView];
    self.myListSearchButton.selected = NO;
    self.allListSearchButton.selected  = YES;
//    [self postQingQiuSearch:self.searchText.text];
}
-(UITableView *)seachTableView
{
    if (!_seachTableView) {
        self.seachArray = [[NSMutableArray alloc]init];
        _seachTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+63/2+10, kWindowW, kWindowH-(kNavBarHeight+(63/2+10))-[self getTabBarHeight]) style:(UITableViewStylePlain)];
        _seachTableView.backgroundColor = [UIColor whiteColor];
        _seachTableView.delegate = self;
        _seachTableView.dataSource = self;
        _seachTableView.hidden = YES;
        _seachTableView.tableFooterView = [[UIView alloc] init];
        _seachTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_seachTableView];
        [self.view bringSubviewToFront:_seachTableView];
    }
    return _seachTableView;
}
#pragma mark 分栏
- (void)buildMainViewWitharray:(NSArray *)array
{
    //----------按钮-------------//
    NSMutableArray* btns = [[NSMutableArray alloc] init];
    if (![array isKindOfClass:[NSArray class]]) {
        return;
    }
    CGFloat jisuanKuai = (105/2)+35/2;
    CGFloat jisuanZongWight = (105/2)+35/2+53/4;
    for (int i = 0; i < array.count; i++) {
        if (!m_mySegBtn[i]) {
            m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(jisuanKuai*i, 0, jisuanKuai, 43)];
        }
        if (i==0) {
            m_mySegBtn[i].frame = CGRectMake(0, 0, jisuanKuai, 43);
        }else{
            m_mySegBtn[i].frame = CGRectMake(jisuanZongWight+(jisuanZongWight-jisuanKuai), 0, jisuanKuai, 43);
        }
        m_mySegBtn[0].selected = YES;
        [m_mySegBtn[i] setTitle:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] forState:UIControlStateNormal];
        if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] isEqualToString:@"维修"]) {
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group") forState:(UIControlStateNormal)];
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group_select") forState:(UIControlStateSelected)];
        }
        if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i], @"channel_name")] isEqualToString:@"洗美"]) {
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group_xi") forState:(UIControlStateNormal)];
            [m_mySegBtn[i] setImage:DJImageNamed(@"Group_xi_select") forState:(UIControlStateSelected)];
        }
        m_mySegBtn[i].imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 40);
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(102, 102, 102, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kZhuTiColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        if (m_mySegBtn[i].selected == YES) {
            m_mySegBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }else{
            m_mySegBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
        
        m_mySegBtn[i].tag = i;
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake((jisuanKuai - 105/2)/2, 43-1.5, 105/2, 1.5)];
    bottomView.backgroundColor = kZhuTiColor;
    if (!m_segButtonsView) {
        m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake((kWindowW-(array.count*jisuanZongWight))/2,kNavBarHeight-43, array.count*jisuanZongWight, 43) buttonArray:btns bottomView:bottomView];
        m_segButtonsView.backgroundColor = [UIColor clearColor];
        [m_baseTopView addSubview:m_segButtonsView];
    }
    
    
    //底部表格
    for (int i = 0; i < array.count; i++) {
        
        main_dataArry[i] = [[NSMutableArray alloc]init];
        if (!m_myTableView[i]) {
            m_myTableView[i] = [[UITableView alloc]initWithFrame:CGRectMake(kWindowW * i, 0, kWindowW, kWindowH-[self getTabBarHeight]-(63/2+10)*2-kNavBarHeight) style:UITableViewStylePlain];
            
            m_myTableView[i].delegate = self;
            m_myTableView[i].tag = i + 2000;
            m_myTableView[i].dataSource = self;
            m_myTableView[i].backgroundColor = kColorWithRGB(246, 246, 246, 1.0);
            m_myTableView[i].tableFooterView = [[UIView alloc] init];
            m_myTableView[i].separatorStyle = UITableViewCellSeparatorStyleNone;
            
            m_myTableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        }
    }
    
    m_myTableView[0].contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    if (!m_moreTable) {
        m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+(63/2+10)*2, kWindowW, kWindowH-kNavBarHeight-(63/2+10)*2-[self getTabBarHeight])];
        m_moreTable.backgroundColor = [UIColor clearColor];
        m_moreTable.myDelegate = self;
        
        [self.view addSubview:m_moreTable];
    }
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count; i++) {
        [tableArray addObject:m_myTableView[i]];
    }
    [m_moreTable buildMainViewWithTabel:tableArray head:nil visibleHeight:40 isHaveDownRefresh:NO];
    m_moreTable.fatherScroll.scrollEnabled = NO;
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
            m_mySegBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
        else{
            m_mySegBtn[i].selected = YES;
            m_mySegBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }
    }
    NSUInteger tag = segBtn.tag;//1,2
    [m_moreTable setFatherScrollToIndex:tag];
    
    [self tableChangedToIndex:tag];
    
    if (self.seachTableView.hidden == NO) {
        [self postSearchrequest_methodDatawithShuaXin:YES];
    }
}
- (void)tableChangedToIndex:(NSInteger)index
{
    [m_segButtonsView SGBscrollViewDidEndDecelerating:index];
    diJiYeIndex = index;
    
    if (index == 0) {
        if (weixiuMyList == YES) {
            myListButton.selected = YES;
            allListButton.selected = NO;
        }else{
            myListButton.selected = NO;
            allListButton.selected = YES;
        }
    }
    if (index == 1) {
        if (xiMeiMyList == YES) {
            myListButton.selected = YES;
            allListButton.selected = NO;
        }else{
            myListButton.selected = NO;
            allListButton.selected = YES;
        }
    }
    
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
    }else if (tableView == m_myTableView[1])
    {
        return main_dataArry[1].count;
    }else{
        return self.seachArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    TheWorkbenchWeiXiuCell *cell = (TheWorkbenchWeiXiuCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[TheWorkbenchWeiXiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    TheWorkModel *model;
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
    }else if (tableView == m_myTableView[1])
    {
        model = main_dataArry[1][indexPath.row];
    }else{
        model = self.seachArray[indexPath.row];
    }
    
    [cell refeleseWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheWorkModel *model;
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
    }else if(tableView == self.seachTableView)
    {
        model = self.seachArray[indexPath.row];
    }else
    {
        model = main_dataArry[1][indexPath.row];
    }
    
    if ([model.class_name isEqualToString:@"维修"]) {
        return 80;
    }else
    {
        return 110;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    TheWorkModel *model;
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
        [self getrequest_methodWithTheWorkModel:model];
    }else if (tableView == m_myTableView[1])
    {
        model = main_dataArry[1][indexPath.row];
        [self getrequest_methodWithTheWorkModel:model];
    }else{
        model = self.seachArray[indexPath.row];
        [self getrequest_methodWithTheWorkModel:model];
    }
    
}
-(UIButton *)myListSearchButton
{
    if (!_myListSearchButton) {
        _myListSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 117/2, 54/2)];
        _myListSearchButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_myListSearchButton.layer setMasksToBounds:YES];
        [_myListSearchButton.layer setCornerRadius:54/4];
        _myListSearchButton.selected = YES;
        [_myListSearchButton addTarget:self action:@selector(myListSearchButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_myListSearchButton setTitle:@"与我相关" forState:(UIControlStateNormal)];
        [_myListSearchButton setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [_myListSearchButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        [_myListSearchButton setBackgroundImage:[UIImage imageWithUIColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
        [_myListSearchButton setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
    }
    return _myListSearchButton;
}
-(UIButton *)allListSearchButton
{
    if (!_allListSearchButton) {
        _allListSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(227/2-117/2, 0, 117/2, 54/2)];
        _allListSearchButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_allListSearchButton.layer setMasksToBounds:YES];
        [_allListSearchButton.layer setCornerRadius:54/4];
        _allListSearchButton.selected = NO;
        [_allListSearchButton addTarget:self action:@selector(allListSearchButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_allListSearchButton setTitle:@"显示所有" forState:(UIControlStateNormal)];
        [_allListSearchButton setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [_allListSearchButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        [_allListSearchButton setBackgroundImage:[UIImage imageWithUIColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
        [_allListSearchButton setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
    }
    return _allListSearchButton;
}

-(void)myListSearchButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        self.allListSearchButton.selected = NO;
    }else{
        self.allListSearchButton.selected = YES;
    }
    [self postSearchrequest_methodDatawithShuaXin:YES];
}
-(void)allListSearchButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        self.myListSearchButton.selected = NO;
    }else{
        self.myListSearchButton.selected = YES;
    }
    [self postSearchrequest_methodDatawithShuaXin:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.seachTableView) {
        
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *seaLabel = [[UILabel alloc]init];
        seaLabel.font = [UIFont systemFontOfSize:14];
        seaLabel.textColor = kRGBColor(51, 51, 51);
        seaLabel.text = @"搜索结果";
        [headerView addSubview:seaLabel];
        [seaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(headerView);
        }];
        
        UIView *qieView2 = [[UIView alloc]init];
        qieView2.backgroundColor = kRGBColor(244, 244, 244);
        [qieView2.layer setMasksToBounds:YES];
        [qieView2.layer setBorderWidth:0.5];
        [qieView2.layer setCornerRadius:54/4];
        [qieView2.layer setBorderColor:kLineBgColor.CGColor];
        [headerView addSubview:qieView2];
        [qieView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(headerView);
            make.width.mas_equalTo(227/2);
            make.height.mas_equalTo(54/2);
        }];
        
        [qieView2 addSubview:self.myListSearchButton];
        [qieView2 addSubview:self.allListSearchButton];
        return headerView;
    }else
        return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.seachTableView) {
        return 40;
    }else{
        return 0;
    }
}

@end
