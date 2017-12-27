//
//  LineUpTheListVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "LineUpTheListVC.h"
#import "DuplexTableView.h"
#import "SegmentButtonsView.h"
#import "WorkOrderTypeVC.h"
#import "XiMeiDetailViewController.h"
#import "WKWebViewViewController.h"

//#define kJSHANGHEIGHT (52)
#define kJSHANGHEIGHT (0)

@interface LineUpTheListVC ()<DuplexTableDelegate,RTDragCellTableViewDataSource,RTDragCellTableViewDelegate>
{
    DuplexTableView*    m_moreTable;
    SegmentButtonsView* m_segButtonsView;
    BOOL                 isUserPush;
}

@property(nonatomic,strong)TheWorkModel *shanChuModel;
@property(nonatomic,assign)NSInteger shanChuIndex;

@end

@implementation LineUpTheListVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self rREQUEST_METHODNetwork];
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJieShouXiaoXi object:nil];
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
        [self rREQUEST_METHODNetwork];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"排队列表" withBackButton:NO];
    
//    [self buildMainView];
//    [self setNetworkListWithshuaxin:YES withIndex:0];
    [self setupNavigationBar];
    
    [self buildSearchView];

}

- (void)setupNavigationBar
{
    [self setNavBarAssistantButtonWithItems:@[@"新增订单"]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32, 21, 21)];
    imageView.image = DJImageNamed(@"xiaoxi");//[UIImage imageNamed:@"assistant_icon"];
    [m_baseTopView addSubview:imageView];
    
    UIButton *pushManageBt = [[UIButton alloc] initWithFrame:CGRectMake(0, kNavBarHeight-44, 40, 44)];
    [pushManageBt addTarget:self action:@selector(pushManageBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [m_baseTopView addSubview:pushManageBt];
}
-(void)pushManageBtClick:(UIButton *)sender
{
    PushMessageViewController *vc = [[PushMessageViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) assistantActionWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            if (![KISDictionaryHaveKey(self.numberDict, @"channels") isKindOfClass:[NSArray class]]) {
                return;
            }
            WorkOrderTypeVC *vc = [[WorkOrderTypeVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.chePaiStr = @"";
            vc.chuanZhiArray = KISDictionaryHaveKey(self.numberDict, @"channels");
            [self.navigationController pushViewController:vc animated:YES];
            
//            WKWebViewViewController *vc= [[WKWebViewViewController alloc]init];
//            vc.isNoShowNavBar = NO;
//            vc.hidesBottomBarWhenPushed = YES;
////            vc.webUrl = @"http://192.168.1.145/chedian/store_manage/my_print/baoxiao?id=&type=2&ordercode=0100100171078577";
//            vc.wenAnName = @"L_print";
//            vc.navTitle = @"";
//            [self.navigationController pushViewController:vc animated:YES];
            
//            [self postDaYingGongDan];
        }
            break;
            
        default:
            break;
    }
}

-(void)postDaYingGongDan
{
    
    [self showOrHideLoadView:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//@"text/plain"
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];//设置超时
    
    
    //    NSMutableDictionary* requestDic = [NetWorkManager getCommonCookieDictionary];
    NSMutableDictionary* requestDic = [[NSMutableDictionary alloc]init];
    
    
    
    
    NSError *error = nil;
    NSData *cookieData = [NSJSONSerialization dataWithJSONObject:requestDic
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
    NSString *path = @"http://192.168.1.196/chedian/common/common_print/test";

    [manager POST:path parameters:requestDic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        
        
        WKWebViewViewController *vc= [[WKWebViewViewController alloc]init];
        vc.isNoShowNavBar = NO;
        vc.hidesBottomBarWhenPushed = YES;
        //            vc.webUrl = @"http://192.168.1.145/chedian/store_manage/my_print/baoxiao?id=&type=2&ordercode=0100100171078577";
        vc.chuanData  = responseData;
        [self.navigationController pushViewController:vc animated:YES];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHideLoadView:NO];
        
        NPrintLog(@"\n参数：%@\n", [[NSString alloc] initWithData:cookieData encoding:NSUTF8StringEncoding]);
        NPrintLog(@"请求失败 %@ \n参数：%@", error, requestDic);
    }];
    
    
}

#pragma mark 搜索
-(void)resetTableScroll
{
    self.seachTableView.hidden = NO;
    [self.view bringSubviewToFront:self.seachTableView];
    [self postQingQiuSearch:self.searchText.text];
}
-(UITableView *)seachTableView
{
    if (!_seachTableView) {
        self.seachArray = [[NSMutableArray alloc]init];
        _seachTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+kJSHANGHEIGHT, kWindowW, kWindowH-(kNavBarHeight+kJSHANGHEIGHT)-[self getTabBarHeight]) style:(UITableViewStylePlain)];
        _seachTableView.delegate = self;
        _seachTableView.dataSource = self;
        _seachTableView.hidden = YES;
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
    CGFloat jisuanKuai = kWindowW/(array.count+1);
    for (int i = 0; i < array.count+1; i++) {
        m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(jisuanKuai*i, 0, jisuanKuai, 43)];
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor grayColor];
        [m_mySegBtn[i] addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        if (i == 0) {
            [m_mySegBtn[i] setTitle:@"所有" forState:UIControlStateNormal];
        }else
        {
            [m_mySegBtn[i] setTitle:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(array[i-1], @"channel_name")] forState:UIControlStateNormal];
        }
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(102, 102, 102, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kNavBarColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        m_mySegBtn[i].titleLabel.font = DJSystemFont(KAddFont_6P(16.0));
        m_mySegBtn[i].tag = i+1;
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 43-1.5, jisuanKuai, 1.5)];
    bottomView.backgroundColor = kNavBarColor;
    m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake(0,kNavBarHeight+kJSHANGHEIGHT, kWindowW, 43) buttonArray:btns bottomView:bottomView];
    [self.view addSubview:m_segButtonsView];
    
    //底部表格
    for (int i = 0; i < array.count+1; i++) {
        main_dataArry[i] = [[NSMutableArray alloc]init];
        if (i == 0) {
            m_myTableView[i] = [[RTDragCellTableView alloc] initWithFrame:CGRectMake(kWindowW * i, 0, kWindowW, kWindowH-[self getTabBarHeight]-43-kNavBarHeight-kJSHANGHEIGHT) style:UITableViewStylePlain withTuoDong:NO];
        }else
        {
            m_myTableView[i] = [[RTDragCellTableView alloc] initWithFrame:CGRectMake(kWindowW * i, 0, kWindowW, kWindowH-[self getTabBarHeight]-43-kNavBarHeight-kJSHANGHEIGHT) style:UITableViewStylePlain withTuoDong:YES];
        }
        
        m_myTableView[i].delegate = self;
        m_myTableView[i].tag = i + 2000;
        m_myTableView[i].dataSource = self;
        [m_myTableView[i] registerClass:[TheWorkbenchCell class] forCellReuseIdentifier:@"Cell"];
        m_myTableView[i].backgroundColor = kColorWithRGB(246, 246, 246, 1.0);
        m_myTableView[i].tableFooterView = [[UIView alloc] init];
        m_myTableView[i].separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (i == 0) {
            m_myTableView[0].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        }else{
            m_myTableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData1)];
            m_myTableView[i].scrollEnabled = YES;
            m_myTableView[i].userInteractionEnabled = YES;
        }
    }
    
    m_myTableView[0].contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+43+kJSHANGHEIGHT, kWindowW, kWindowH-kNavBarHeight-43-[self getTabBarHeight]-kJSHANGHEIGHT)];
    m_moreTable.backgroundColor = [UIColor yellowColor];
    
    m_moreTable.myDelegate = self;
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count+1; i++) {
        [tableArray addObject:m_myTableView[i]];
    }
    [m_moreTable buildMainViewWithTabel:tableArray head:nil visibleHeight:40 isHaveDownRefresh:NO];
    m_moreTable.fatherScroll.scrollEnabled = NO;
//    m_moreTable.fatherScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:m_moreTable];
    
    [m_myTableView[0].mj_header beginRefreshing];
}
-(void)loadNewData0
{
    [self setNetworkListWithshuaxin:YES withIndex:0];
}
-(void)loadNewData1{
    [self setNetworkListWithshuaxin:YES withIndex:diJiYeIndex];
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
    [m_moreTable setFatherScrollToIndex:tag-1];
    
    [self tableChangedToIndex:tag-1];
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
    for (int i = 0; i < 3; i++) {
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
    }else if(tableView == self.seachTableView){
        return self.seachArray.count;
    }else{
        RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
        NSInteger indx = tabi.tag - 2000;
        
        if (tableView == m_myTableView[indx]) {
            return main_dataArry[indx].count;
        }else
        {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheWorkbenchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    TheWorkModel *model;
    
    if (tableView == m_myTableView[0]) {
        
        model = main_dataArry[0][indexPath.row];
        [cell refeleseWithModel:model WithShiFouKeShan:NO];
    }else if(tableView == self.seachTableView){
        model = self.seachArray[indexPath.row];
        [cell refeleseWithModel:model WithShiFouKeShan:NO];
    }else
    {
        
        RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
        NSInteger indx = tabi.tag - 2000;
//        NPrintLog(@"indx%ld",indx);
//        NPrintLog(@"indx%ld",indexPath.row);
        if (main_dataArry[indx].count<indexPath.row || main_dataArry[indx].count<=0) {
            return cell;
        }
        model = main_dataArry[indx][indexPath.row];
        
        [cell refeleseWithModel:model WithShiFouKeShan:YES];
        kWeakSelf(weakSelf)
        cell.biXianShiAnniuBlock = ^(TheWorkModel *zhuModel) {
//            for (int i = 0; i<main_dataArry[indx].count; i++) {
//                TheWorkModel *xiumodel = main_dataArry[indx][i];
//                if (xiumodel == zhuModel) {
//                    zhuModel.shanChuState = !zhuModel.shanChuState;
//                }else
//                {
//                    xiumodel.shanChuState = NO;
//                }
//            }
//            [m_myTableView[indx] reloadData];
        };
        
        cell.shanChuBlock = ^(TheWorkModel *zhuModel) {
            UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"确定删除吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alt.tag = 100;
            [alt show];
            
            weakSelf.shanChuModel = zhuModel;
            weakSelf.shanChuIndex = indx;
        };
    }
    
    return cell;
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            [self setShanChuDanTiaoDatawithOrdercodevarchar:self.shanChuModel withIndex:self.shanChuIndex];
        }
    }
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TheWorkModel *model;
    
    if (tableView == m_myTableView[0]) {
        model = main_dataArry[0][indexPath.row];
    }else if(tableView == self.seachTableView)
    {
        model = self.seachArray[indexPath.row];
    }else
    {
        
        RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
        NSInteger indx = tabi.tag - 2000;
        model = main_dataArry[indx][indexPath.row];
    }
    
    XiMeiDetailViewController *vc = [[XiMeiDetailViewController alloc]init];
    vc.chuanzhiModel = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)originalArrayDataForTableView:(RTDragCellTableView *)tableView{
    
    if (tableView == m_myTableView[0]) {
        return main_dataArry[0];
    }else{
        RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
        NSInteger indx = tabi.tag - 2000;
        
        if (tableView == m_myTableView[indx]) {
            return main_dataArry[indx];
        }else
        {
            return nil;
        }
    }
}


/**将修改重排后的数组传入，以便外部更新数据源*/
- (void)tableView:(RTDragCellTableView *)tableView newArrayDataForDataSource:(NSArray *)newArray
{
    RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
    NSInteger indx = tabi.tag - 2000;
    
    if (tableView == m_myTableView[indx]) {
        [main_dataArry[indx] removeAllObjects];
        for (int i = 0; i<newArray.count; i++) {
            [main_dataArry[indx] addObject:newArray[i]];
        }
        [m_myTableView[indx] reloadData];
    }
}


/**选中的cell准备好可以移动的时候*/
- (void)cellBecomeMovingInTableView:(RTDragCellTableView *)tableView
{
    RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
    NSInteger indx = tabi.tag - 2000;
    
    if (tableView == m_myTableView[indx]) {
        self.yuanDataArray = [[NSArray alloc]initWithArray:main_dataArry[indx]];
    }
}
/**选中的cell完成移动，手势已松开*/
- (void)cellDidEndMovingInTableView:(RTDragCellTableView *)tableView{
    RTDragCellTableView *tabi = (RTDragCellTableView *)tableView;
    NSInteger indx = tabi.tag - 2000;
    
    if (tableView == m_myTableView[indx]) {
        if (main_dataArry[indx].count != self.yuanDataArray.count) {
            return;
        }
        TheWorkModel *chuanModel1;
        TheWorkModel *chuanModel2;
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i = 0; i<self.yuanDataArray.count; i++) {
            TheWorkModel *model1 = main_dataArry[indx][i];
            TheWorkModel *model2 = self.yuanDataArray[i];
            if ([model1.ordercode isEqualToString:model2.ordercode]) {
            }else
            {
                [array addObject:main_dataArry[indx][i]];
            }
        }
        if (array.count>=2) {
            chuanModel1 = array[array.count-1];
            chuanModel2 = array[array.count-2];
        }
        
        if (chuanModel2 == nil || chuanModel1 == nil) {
            return;
        }
        [self rEQUEST_METHODsetShanChuDanTiaoDatawithBordercode:chuanModel1 withAordercode:chuanModel2 withIndex:indx];
    }
}



/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == m_myTableView[1]) {
        TheWorkModel *zhuModel =  main_dataArry[1][indexPath.row];
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"确定删除吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alt.tag = 100;
        [alt show];
        
        self.shanChuModel = zhuModel;
        self.shanChuIndex = 1;
    }
    if (tableView == m_myTableView[2]) {
        TheWorkModel *zhuModel =  main_dataArry[2][indexPath.row];
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"确定删除吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alt.tag = 100;
        [alt show];
        
        self.shanChuModel = zhuModel;
        self.shanChuIndex = 2;
    }
}
/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView!= m_myTableView[0]) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}


@end
