//
//  JobBoardViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "MJChiBaoZiHeader.h"
#import <objc/runtime.h>
#import "JobBoardCell.h"
#import "JobBoardScreeningVC.h"

#import "CPHFWeiViewController.h"
#import "YCGDViewController.h"
#import "BYDQViewController.h"
#import "BXDQViewController.h"
#import "XJZZViewController.h"
#import "YYGJViewController.h"
#import "NJTXViewController.h"
#import "KHLSViewController.h"
#import "GDHFViewController.h"
#import "SRGHViewController.h"
@interface JobBoardViewController ()<UITableViewDelegate,UITableViewDataSource,DuplexTableDelegate,JobBoardMenuViewDelegate,UIGestureRecognizerDelegate>
{
    
}

@end

@implementation JobBoardViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [m_headerView.touImaage sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
-(NSMutableArray *)mainDataArray
{
    if (!_mainDataArray) {
        _mainDataArray = [[NSMutableArray alloc]init];
    }
    return _mainDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildMainView];
    
    [self postwork_boardwithShuaXin:YES];
    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
//                                                    initWithTarget:self
//                                                    action:@selector(dissMissView)];
//    tapGestureRecognizer.delegate = self;
//    [self.view addGestureRecognizer:tapGestureRecognizer];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
////    if ([touch.view isKindOfClass:[UIButton class]]) {
////        return NO;
////    }
//    return YES;
//}
//-(void)dissMissView
//{
//
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


-(void)sheZhicaiDanView//菜单View
{
    if(m_menuView.hidden == YES)
    {
        [m_menuView displayView];
    }
    else{
        [m_menuView selfViewTouch:nil];
    }
}
-(void)tiaoJiuGongGe
{
    JobBoardScreeningVC *vc = [[JobBoardScreeningVC alloc]init];
    kWeakSelf(weakSelf)
    vc.dianJiChcickBlaock = ^(NSDictionary *dict) {
        weakSelf.jiuGongHuiDiaoDict = dict;
        [m_headerView setTitleDiYiwithStr:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")]];
        [weakSelf postwork_boardwithShuaXin:YES];
    };
    vc.status = m_menuView.selectTag;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)buildMainView
{
    float viewWidth = CGRectGetWidth(self.view.frame);
    
    m_headerView = [[JobBoardHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*320/750+53)];
    kWeakSelf(weakSelf)
    m_headerView.touXiangDianJiBlock = ^{
        [weakSelf.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    };
    m_headerView.playTypeClickBlock = ^{
        [weakSelf sheZhicaiDanView];
    };
    m_headerView.selectBtMeunChickBlock = ^{
        [weakSelf tiaoJiuGongGe];
    };
    m_headerView.zhongQieHUanBlock = ^{
        [weakSelf postwork_boardwithShuaXin:YES];
    };
    
    float groupH = CGRectGetHeight(m_headerView.frame);//30 按钮
    
    //底部表格
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, groupH)];
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-[self getTabBarHeight]) style:UITableViewStylePlain];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.tableHeaderView = tableHeaderView;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
    
    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, CGRectGetHeight(self.view.frame)-[self getTabBarHeight])];
    m_moreTable.myDelegate = self;
    [m_moreTable buildMainViewWithTabel:@[_mainTableView] head:m_headerView visibleHeight:83 isHaveDownRefresh:NO];
    m_moreTable.fatherScroll.scrollEnabled = NO;
    [self.view addSubview:m_moreTable];
    
    [self.view addSubview:m_headerView];
    
    
    m_menuView = [[JobBoardMenuView alloc] initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH - kBOSSNavBarHeight-[self getTabBarHeight])];
    m_menuView.selectTag = 0;//下标从0开始
    m_menuView.myDelegate = self;
    [m_menuView setMainViewWithArray:@[@"未处理",@"已处理",@"过期"]];
    [self.view addSubview:m_menuView];
    [self.view bringSubviewToFront:m_menuView];
    
}
-(void)requestMatchInfoData
{
    [self.mainTableView.mj_header endRefreshing];
    [self postwork_boardwithShuaXin:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resetTableSectionHeader:scrollView];
    //表格滑动
    [m_moreTable tableViewDidScroll:scrollView];
    [m_headerView scrollViewDidScroll:scrollView.contentOffset.y];
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    scrollView.contentInset = UIEdgeInsetsZero;
    return YES;
}
//table section header悬停位置设置
- (void)resetTableSectionHeader:(UIScrollView*)scrollView
{
    CGFloat sectionHeaderHeight = CGRectGetHeight(m_headerView.frame)-104;//104最后header可见高＝64+40
    NPrintLog(@"nei%f",sectionHeaderHeight);
    if ([scrollView isKindOfClass:[UITableView class]] && scrollView.contentSize.height > CGRectGetHeight(scrollView.frame)+sectionHeaderHeight) {
        if (scrollView.contentOffset.y>=sectionHeaderHeight)  {
            NPrintLog(@"1");
            scrollView.contentInset = UIEdgeInsetsMake(104, 0, 0, 0);
        }else{
            NPrintLog(@"2");
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
    else if([scrollView isKindOfClass:[UITableView class]] && ![self isTableRefreshing])// 防止正在下拉刷新
        scrollView.contentInset = UIEdgeInsetsZero;
}
- (BOOL)isTableRefreshing
{
    for (int i = 0; i < 6; i++) {
        if([self.mainTableView.mj_header isRefreshing])
            return YES;
    }
    return NO;
}


- (void)playTypeSelectWithTag:(NSInteger)buttonTag view:(JobBoardMenuView *)selfView
{
    if (selfView.selectTag == 0) {
        [m_headerView.topTitleButton setTitle:@"未处理" forState:(UIControlStateNormal)];
    }else if (selfView.selectTag == 1) {
        [m_headerView.topTitleButton setTitle:@"已处理" forState:(UIControlStateNormal)];
    }else{
        [m_headerView.topTitleButton setTitle:@"过期" forState:(UIControlStateNormal)];
    }
    [self postwork_boardwithShuaXin:YES];
}

- (void)playTypeCancel:(JobBoardMenuView*)selfView
{
    
}
    
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    JobBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[JobBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refleshData:self.mainDataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(weakSelf)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"催办" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        JobBoardModel *mdeol = weakSelf.mainDataArray[indexPath.row];
        [weakSelf postCuiBan:mdeol];
    }];
    action.backgroundColor = kRGBColor(74, 144, 226);
    return @[action];
}

/**
 task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
 9:工单回访 10:全部任务
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobBoardModel *mdeol = self.mainDataArray[indexPath.row];
    if ([mdeol.task_type integerValue] == 0){
      //  if (m_menuView.selectTag == 0){
        KHLSViewController*vc=[[KHLSViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
       // }
    }else if([mdeol.task_type integerValue]==1){
        YCGDViewController *vc=[[YCGDViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==2){
        CPHFWeiViewController *vc = [[CPHFWeiViewController alloc]init];
        vc.chuanZhiModel = mdeol;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==3){
        YYGJViewController*vc=[[YYGJViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==4){
        BYDQViewController*vc=[[BYDQViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==5){
        BXDQViewController*vc=[[BXDQViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==6){
        NJTXViewController*vc=[[NJTXViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==7){
        SRGHViewController*vc=[[SRGHViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==8){
        XJZZViewController*vc=[[XJZZViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([mdeol.task_type integerValue]==9){
        GDHFViewController*vc=[[GDHFViewController alloc]init];
        vc.chuanZhiModel=mdeol;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




@end
