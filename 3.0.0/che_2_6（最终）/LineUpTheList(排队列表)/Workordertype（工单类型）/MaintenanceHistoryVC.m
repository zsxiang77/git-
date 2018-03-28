//
//  MaintenanceHistoryVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "MaintenanceHistoryVC.h"
#import "MJChiBaoZiHeader.h"
#import "MaintenanceHistoryCell.h"

@interface MaintenanceHistoryVC ()<UITableViewDelegate,UITableViewDataSource,DuplexTableDelegate>

@end

@implementation MaintenanceHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.shiFouWeiXiu) {
        [self setTopViewWithTitle:@"历史维修记录" withBackButton:YES];
    }else{
        [self setTopViewWithTitle:@"历史洗美记录" withBackButton:YES];
    }
    
    [self buildMainViewWitharray];
    if (self.shiFouWeiXiu == YES) {
        [self postWeiXiuXiangMuQingQiuWithShuXin:YES];
    }else{
        [self postXiMeiXiangMuQingQiuWithShuXin:YES];
    }
}

#pragma mark 分栏
- (void)buildMainViewWitharray
{
    //----------按钮-------------//
    NSMutableArray* btns = [[NSMutableArray alloc] init];
    NSArray *array;
    if (self.shiFouWeiXiu == YES) {
        array = [NSArray arrayWithObjects:@"维修项目",@"配件信息", nil];
    }else{
        array = [NSArray arrayWithObjects:@"洗美项目",@"配件信息", nil];
    }
    
    CGFloat jisuanKuai = kWindowW/(array.count);
    for (int i = 0; i < array.count; i++) {
        m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(jisuanKuai*i, 0, jisuanKuai, 43)];
        [m_mySegBtn[i] setTitle:array[i] forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(102, 102, 102, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kZhuTiColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        m_mySegBtn[i].titleLabel.font = DJSystemFont(KAddFont_6P(16.0));
        m_mySegBtn[i].tag = i;
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 43-1.5, jisuanKuai, 1.5)];
    bottomView.backgroundColor = kZhuTiColor;
    m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake(0,kNavBarHeight, kWindowW, 43) buttonArray:btns bottomView:bottomView];
    [self.view addSubview:m_segButtonsView];
    
    for (int i = 0; i < array.count; i++) {
        m_dateArray[i] = [[NSMutableArray alloc]init];
        main_tableView[i] = [[UITableView alloc]initWithFrame:CGRectMake(kWindowW * i, 0, kWindowW, kWindowH-kNavBarHeight-43)];
        main_tableView[i].backgroundColor = self.view.backgroundColor;
        main_tableView[i].separatorStyle = UITableViewCellSeparatorStyleNone;
        main_tableView[i].delegate = self;
        main_tableView[i].dataSource = self;
        if (i == 0) {
            main_tableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        }else{
            main_tableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData1)];
        }
    }
    
    
    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+43, kWindowW, kWindowH-kNavBarHeight-43)];
    
    m_moreTable.myDelegate = self;
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count; i++) {
        [tableArray addObject:main_tableView[i]];
    }
    [m_moreTable buildMainViewWithTabel:tableArray head:nil visibleHeight:40 isHaveDownRefresh:NO];
    [self.view addSubview:m_moreTable];
}

-(void)loadNewData0
{
    [main_tableView[0].mj_header endRefreshing];
    if (self.shiFouWeiXiu == YES) {
        [self postWeiXiuXiangMuQingQiuWithShuXin:YES];
    }else{
        [self postXiMeiXiangMuQingQiuWithShuXin:YES];
    }
}
-(void)loadNewData1
{
    [main_tableView[1].mj_header endRefreshing];
    if (self.shiFouWeiXiu == YES) {
        [self postWeiXiuPeiJianQingQiuWithShuXin:YES];
    }else{
        [self postXiMeiPeiJianQiuWithShuXin:YES];
    }
}

#pragma mark 切换

- (void)segmentButtonClick:(UIButton*)segBtn
{
    for (int i = 0; i <2 ; i++) {
        if (segBtn != m_mySegBtn[i]) {
            m_mySegBtn[i].selected = NO;
        }
        else{
            m_mySegBtn[i].selected = YES;
        }
    }
    NSUInteger tag = segBtn.tag;
    [m_moreTable setFatherScrollToIndex:tag];
    
    [self tableChangedToIndex:tag];
}
- (void)tableChangedToIndex:(NSInteger)index
{
    [m_segButtonsView SGBscrollViewDidEndDecelerating:index];
    if (index == 0) {
        if (m_dateArray[0].count<=0) {
            if (self.shiFouWeiXiu == YES) {
                [self postWeiXiuXiangMuQingQiuWithShuXin:YES];
            }else{
                [self postXiMeiXiangMuQingQiuWithShuXin:YES];
            }
        }
    }else{
        if (m_dateArray[1].count<=0) {
            if (self.shiFouWeiXiu == YES) {
                [self postWeiXiuPeiJianQingQiuWithShuXin:YES];
            }else{
                [self postXiMeiPeiJianQiuWithShuXin:YES];
            }
        }
    }
}
- (void)fatherScrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    NSInteger index = offsetofScrollView.x/CGRectGetWidth(scrollView.frame);
    for (int i = 0; i < 2; i++) {
        if (i != index) {
            m_mySegBtn[i].selected = NO;
        }
        else{
            m_mySegBtn[i].selected = YES;
        }
    }
    [m_segButtonsView SGBscrollViewDidScroll2:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //表格滑动
    [m_moreTable tableViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == main_tableView[0]) {
        return m_dateArray[0].count;
    }else{
        return m_dateArray[1].count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myIdentifier = @"Cell";
    MaintenanceHistoryCell *cell = (MaintenanceHistoryCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[MaintenanceHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    if (tableView == main_tableView[0]) {
        [cell refeleseZongCell:self.shiFouWeiXiu withDict:m_dateArray[0][indexPath.row] withInder:indexPath.row withPeiJian:NO];
    }else{
        [cell refeleseZongCell:self.shiFouWeiXiu withDict:m_dateArray[1][indexPath.row] withInder:indexPath.row withPeiJian:YES];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shiFouWeiXiu == YES) {
        if (tableView == main_tableView[0]) {
            NSDictionary *jiSuanDict = m_dateArray[0][indexPath.row];
            NSArray *list = KISDictionaryHaveKey(jiSuanDict, @"list");
            return list.count*35+20+53/2;
        }else{
            NSDictionary *jiSuanDict = m_dateArray[1][indexPath.row];
            NSArray *list = KISDictionaryHaveKey(jiSuanDict, @"list");
            return list.count*35+20+53/2;
        }
    }else{
        if (tableView == main_tableView[0]) {
            return 35+20+53/2;
        }else{
            NSDictionary *jiSuanDict = m_dateArray[1][indexPath.row];
            NSArray *list = KISDictionaryHaveKey(jiSuanDict, @"list");
            return list.count*35+20+53/2;
        }
    }
}

@end
