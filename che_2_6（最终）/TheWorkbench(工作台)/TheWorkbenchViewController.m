//
//  TheWorkbenchViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "WorkOrderTypeVC.h"
#import "OrderDetailViewController.h"
#import "UIViewController+MMDrawerController.h"


@interface TheWorkbenchViewController ()<DuplexTableDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL                 isUserPush;
    UIImageView          *touImaageView;
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
    
    touImaageView = [[UIImageView alloc]init];
    [touImaageView.layer setMasksToBounds:YES];
    [touImaageView.layer setCornerRadius:15];
    [m_baseTopView addSubview:touImaageView];
    [touImaageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.height.mas_equalTo(30);
    }];
    
    
    UIButton *touImageButton = [[UIButton alloc]init];
    [m_baseTopView addSubview:touImageButton];
    [touImageButton addTarget:self action:@selector(touImageButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [touImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
}

-(void)touImageButtonChick:(UIButton *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
        }
        self.shiFouJiaZai = YES;
    }
    if ([content_type isEqualToString:@"11"]) {
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

    [touImaageView sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
    
    if (!self.channelsArray) {
        [self rREQUEST_METHODNetwork];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
-(void)networkDidReceiveMessageBenDI{
    [main_dataArry[0] removeAllObjects];
    [m_myTableView[0] reloadData];
    [main_dataArry[1] removeAllObjects];
    [m_myTableView[1] reloadData];
    
    [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
}
#pragma mark 搜索
-(void)resetTableScroll
{
    self.myListSearchButton.selected = NO;
    self.allListSearchButton.selected  = YES;
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
        m_mySegBtn[i].imageEdgeInsets = UIEdgeInsetsMake(10, -5, 10, 50);
        m_mySegBtn[i].titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
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

-(void)yingcaingShaiXuanBlock
{
    if (self.orderDetailShaiXuanView.hidden == NO) {
        [UIView animateWithDuration:0.2 animations:^{
            shaiXuanJianTou.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            shaiXuanJianTou.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
        }];
    }
}
-(OrderDetailShaiXuanView *)orderDetailShaiXuanView
{
    if (!_orderDetailShaiXuanView) {
        _orderDetailShaiXuanView = [[OrderDetailShaiXuanView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        kWeakSelf(weakSelf)
        _orderDetailShaiXuanView.yingCangViweBlock = ^{
            [weakSelf yingcaingShaiXuanBlock];
        };
        _orderDetailShaiXuanView.dianJiAnNiuBtChickBlock = ^(NSInteger index) {
            [weakSelf shuaxinorderDetailShaiXuanView:index];
        };
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0] makeKeyWindow];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_orderDetailShaiXuanView];
        _orderDetailShaiXuanView.hidden = YES;
    }
    return _orderDetailShaiXuanView;
}
-(void)shuaxinorderDetailShaiXuanView:(NSInteger )index
{
    if (index == 0) {
        shaiXuanImageView.image = DJImageNamed(@"waiting_repair");
        shaiXuanTitle.text = @"待施工";
        shaiXuanTitle.textColor = kRGBColor(245, 166, 35);
    }else if (index == 1) {
        shaiXuanImageView.image = DJImageNamed(@"waiting_WanCheng");
        shaiXuanTitle.text = @"已完成";
        shaiXuanTitle.textColor = kRGBColor(98, 172, 13);
    }else if (index == 2) {
        shaiXuanImageView.image = DJImageNamed(@"waiting_chuChang");
        shaiXuanTitle.text = @"待出厂";
        shaiXuanTitle.textColor = kRGBColor(74, 144, 226);
    }else if (index == 3) {
        shaiXuanImageView.image = DJImageNamed(@"waiting_statement");
        shaiXuanTitle.text = @"待结算";
        shaiXuanTitle.textColor = kRGBColor(139, 87, 42);
    }
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
    
    [self postrequest_methodDataWithIndex:diJiYeIndex withShuaXin:YES];
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
        return 0;
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
    }
    
    [cell refeleseWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheWorkModel *model;
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
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
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
    }else if (tableView == m_myTableView[1])
    {
        model = main_dataArry[1][indexPath.row];
    }
    vc.hidesBottomBarWhenPushed = YES;
    vc.chuanZhiModel = model;
    [self.navigationController  pushViewController:vc animated:YES];
    
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
}
-(void)allListSearchButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        self.myListSearchButton.selected = NO;
    }else{
        self.myListSearchButton.selected = YES;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

@end
