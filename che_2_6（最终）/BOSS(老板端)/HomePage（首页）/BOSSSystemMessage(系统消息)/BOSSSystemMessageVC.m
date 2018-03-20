//
//  BOSSSystemMessageVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSSystemMessageVC.h"
#import "MJChiBaoZiHeader.h"
#import "BOSSSystemWoDeCell.h"
#import "BOSSSystemKeChengCell.h"
#import "BOSSSystemXiTongCell.h"

@interface BOSSSystemMessageVC ()<UITableViewDelegate,UITableViewDataSource,DuplexTableDelegate>

@end

@implementation BOSSSystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"消息通知" withBackButton:YES];
    
    [self buildMainView];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kWoDeXiaoXi] != nil) {
        NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kWoDeXiaoXi];
        for (int i = 0; i<newArray.count; i++) {
            [date_dataArray[0] addObject:newArray[i]];
        }
        [m_myTableView[0] reloadData];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kKeChengXiaoXi] != nil) {
        NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kKeChengXiaoXi];
        for (int i = 0; i<newArray.count; i++) {
            [date_dataArray[1] addObject:newArray[i]];
        }
        [m_myTableView[1] reloadData];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kXiTongTongZhi] != nil) {
        NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kXiTongTongZhi];
        for (int i = 0; i<newArray.count; i++) {
            [date_dataArray[2] addObject:newArray[i]];
        }
        [m_myTableView[2] reloadData];
    }
    if(date_dataArray[0].count<=0)
    {
        UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, kWindowW, 50)];
        cLabel.text = @"暂无我的消息";
        cLabel.textAlignment = NSTextAlignmentCenter;
        cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
        cLabel.font = [UIFont boldSystemFontOfSize:20];
        cLabel.backgroundColor = [UIColor clearColor];
        [m_myTableView[0] addSubview:cLabel];
    }
    if(date_dataArray[1].count<=0)
    {
        UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, kWindowW, 50)];
        cLabel.text = @"暂无课程更新";
        cLabel.textAlignment = NSTextAlignmentCenter;
        cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
        cLabel.font = [UIFont boldSystemFontOfSize:20];
        cLabel.backgroundColor = [UIColor clearColor];
        [m_myTableView[1] addSubview:cLabel];
    }
    if(date_dataArray[2].count<=0)
    {
        UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, kWindowW, 50)];
        cLabel.text = @"暂无系统通知";
        cLabel.textAlignment = NSTextAlignmentCenter;
        cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
        cLabel.font = [UIFont boldSystemFontOfSize:20];
        cLabel.backgroundColor = [UIColor clearColor];
        [m_myTableView[2] addSubview:cLabel];
    }
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkkJieShouXiaoXiDangQianAITDidReceiveMessageBenDI:) name:kJieShouXiaoXiDangQianAIT object:nil];
}

-(void)networkkJieShouXiaoXiDangQianAITDidReceiveMessageBenDI:(NSNotification *)notification {
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kWoDeXiaoXi] != nil) {
        [date_dataArray[1] removeAllObjects];
        NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kWoDeXiaoXi];
        for (int i = 0; i<newArray.count; i++) {
            [date_dataArray[0] addObject:newArray[i]];
        }
        [m_myTableView[0] reloadData];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kKeChengXiaoXi] != nil) {
        [date_dataArray[0] removeAllObjects];
        NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kKeChengXiaoXi];
        for (int i = 0; i<newArray.count; i++) {
            [date_dataArray[1] addObject:newArray[i]];
        }
        [m_myTableView[1] reloadData];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kXiTongTongZhi] != nil) {
        [date_dataArray[2] removeAllObjects];
        NSArray *newArray = [[NSUserDefaults standardUserDefaults] objectForKey:kXiTongTongZhi];
        for (int i = 0; i<newArray.count; i++) {
            [date_dataArray[2] addObject:newArray[i]];
        }
        [m_myTableView[2] reloadData];
    }
}

#pragma mark 分栏
- (void)buildMainView
{
    float viewWidth = CGRectGetWidth(self.view.frame);
    //----------按钮-------------//
    NSMutableArray* btns = [[NSMutableArray alloc] init];
    NSArray *titleArray = @[@"我的消息",@"课程更新",@"系统通知"];
    for (int i = 0; i < 3; i++) {
        m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth/3.0*i, 0, viewWidth/3.0, 32)];
        [m_mySegBtn[i] setTitle:titleArray[i] forState:UIControlStateNormal];
        if (i == 0) {
            m_mySegBtn[i].selected = YES;
        }
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(74, 74, 74, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kBOSSZhuTiColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        m_mySegBtn[i].titleLabel.font = DJSystemFont(KAddFont_6P(16.0));
        m_mySegBtn[i].tag = i+1;
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 32-1.5, viewWidth/3.0, 1.5)];
    bottomView.backgroundColor = kBOSSZhuTiColor;
//    m_segButtonsView = [[SegmentButtonsView alloc]initWithFrame2:CGRectMake(0, kBOSSNavBarHeight, CGRectGetWidth(self.view.frame), 32) buttonArray:btns bottomView:bottomView];
    m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake(0, kBOSSNavBarHeight, CGRectGetWidth(self.view.frame), 32) buttonArray:btns bottomView:bottomView];
    [self.view addSubview:m_segButtonsView];

    //底部表格
    for (int i = 0; i < 3; i++) {
        date_dataArray[i] = [[NSMutableArray alloc]init];
        m_myTableView[i] = [[UITableView alloc] initWithFrame:CGRectMake(viewWidth * i, 0, viewWidth, kWindowH-kBOSSNavBarHeight-32) style:UITableViewStylePlain];
        m_myTableView[i].delegate = self;
        m_myTableView[i].dataSource = self;
        m_myTableView[i].tableFooterView = [[UIView alloc] init];
        m_myTableView[i].separatorStyle = UITableViewCellSeparatorStyleNone;

//        if (i == 0) {
//            m_myTableView[0].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
//        }
//        if (i == 1) {
//            m_myTableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData1)];
//        }
//        if (i == 2) {
//            m_myTableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData2)];
//        }
    }
    m_myTableView[0].contentInset = UIEdgeInsetsMake(0, 0, 30, 0);

    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kBOSSNavBarHeight+32, viewWidth, CGRectGetHeight(self.view.frame)-kBOSSNavBarHeight)];
    m_moreTable.backgroundColor = [UIColor  yellowColor];

    m_moreTable.myDelegate = self;
    [m_moreTable buildMainViewWithTabel:@[m_myTableView[0], m_myTableView[1], m_myTableView[2]] head:nil visibleHeight:32 isHaveDownRefresh:YES];
    [self.view addSubview:m_moreTable];

    [self.view bringSubviewToFront:m_baseTopView];

}

#pragma mark 切换

- (void)segmentButtonClick:(UIButton*)segBtn
{

    for (int i = 0; i < 3; i++) {
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
    [m_segButtonsView SGBscrollViewDidScroll3:scrollView];
}
- (void)scrollViewDidScroll3:(UIScrollView *)scrollView
{
    //表格滑动
    [m_moreTable tableViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == m_myTableView[0]) {
        return date_dataArray[0].count;
    }else if (tableView == m_myTableView[1])
    {
        return date_dataArray[1].count;
    }else if (tableView == m_myTableView[2])
    {
        return date_dataArray[2].count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == m_myTableView[0]) {
        static NSString *Identifier = @"Identifier";
        BOSSSystemWoDeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[BOSSSystemWoDeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refleshData:date_dataArray[0][indexPath.row]];
        return cell;
    }else if (tableView == m_myTableView[1])
    {
        static NSString *Identifier = @"Identifier2";
        BOSSSystemKeChengCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[BOSSSystemKeChengCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refleshData:date_dataArray[1][indexPath.row]];
        return cell;
    }else if (tableView == m_myTableView[2])
    {
        
        
        static NSString *Identifier = @"Identifier3";
        BOSSSystemXiTongCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[BOSSSystemXiTongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refleshData:date_dataArray[2][indexPath.row]];
        return cell;
    
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == m_myTableView[0]) {
        return 316/2;
    }else if (tableView == m_myTableView[1])
    {
        return 250/2-10;
    }else if (tableView == m_myTableView[2])
    {
        NSString *contentstr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(date_dataArray[2][indexPath.row], @"content")];
        CGSize wordSize = DAJIANG_MULTILINE_TEXTSIZE(contentstr, DJSystemFont(14), CGSizeMake(kWindowW-38, 200));
        return 60+wordSize.height;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == m_myTableView[0]) {
        
    }else if (tableView == m_myTableView[1])
    {
        
    }
    
}

@end
