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
#import "StoreDataHeaderView.h"
#import "StoreShouRuView.h"
#import "StoreRenWuView.h"
#import "StorePeiJianView.h"
#import "StoreRenYuanView.h"
#import "StoreHeaderView.h"
#import "MJRefresh.h"
#import "StoreRenyuanModel.h"
@interface StoreTheDataViewController ()
{
    
    UILabel * lineLable;
    CGFloat widths;
}
@property(nonatomic,strong) StoreRenWuView * renwuView;  //任务
@property(nonatomic,strong)  StoreRenYuanView * renyuanView;//人员
@property(nonatomic,strong) StorePeiJianView * peijianView;//配件
@property(nonatomic,strong) StoreShouRuView * shouruView; //收入
@end

@implementation StoreTheDataViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"门店数据"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"门店数据"];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titleArray =@[@"任务",@"人员",@"配件",@"收入"];
    NSArray * imgArray =@[@"renWu1",@"renYuan1",@"peiJian1",@"liRun1"];
    NSArray * selectArray =@[@"renWu2",@"renYuan2",@"peiJian2",@"liRun2"];
    StoreDataHeaderView * viewsTine = [[StoreDataHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kBOSSNavBarHeight) titleArray:titleArray imgArray:imgArray selectArray:selectArray];
    [self.view addSubview:viewsTine];
 
    self.renwuView = [[StoreRenWuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
    kWeakSelf(weakSelf)
    self.renwuView.headerView.showRiLiBlock = ^{
        weakSelf.storeViews.hidden= NO;
    };
    [self.view addSubview:self.renwuView];
    self.shouruView = [[StoreShouRuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview: self.shouruView];
    self.peijianView = [[StorePeiJianView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview:self.peijianView];
    self.renyuanView= [[StoreRenYuanView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
    self.renyuanView.showRiLiBlock = ^{
        weakSelf.storeViews.hidden= NO;
    };
    self.renyuanView.mainTable.mj_header =[MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
    
     [self.view addSubview:self.renyuanView];
    self.renwuView.hidden = NO;
    self.shouruView.hidden = YES;
    self.peijianView.hidden = YES;
    self.renyuanView.hidden = YES;
    viewsTine.viewQieHuan = ^(NSUInteger shifouxuanzhong) {
        self.renwuView.hidden = YES;
        self.shouruView.hidden = YES;
        self.peijianView.hidden = YES;
        self.renyuanView.hidden = YES;
        if(shifouxuanzhong ==400){
            NPrintLog(@"任务--1----%ld",shifouxuanzhong);
            self.renwuView.hidden = NO;
            
        }
        if(shifouxuanzhong ==401){
            NPrintLog(@"人员--2----%ld",shifouxuanzhong);
              self.renyuanView.hidden = NO;
             [self getrenyuan_list:YES];
        }
        if(shifouxuanzhong ==402){
            NPrintLog(@"配件--3----%ld",shifouxuanzhong);
              self.peijianView.hidden = NO;
        }
        if(shifouxuanzhong ==403){
            NPrintLog(@"收入--4----%ld",shifouxuanzhong);
             self.shouruView.hidden = NO;
        }
    };
       [self getTask_status];
     
}
-(StoreTheDataModel *)mainModel
{
    if (!_mainModel) {
        _mainModel = [[StoreTheDataModel alloc]init];
    }
    return _mainModel;
}
//任务数据
-(void)getTask_status
{
    self.timeStr = [NSString stringWithFormat:@"%@",@""];
    self.dateStr = [NSString stringWithFormat:@"%@",@"2"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.timeStr forKey:@"time"];
    [mDict setObject:self.dateStr forKey:@"date"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/task_status" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        [weakSelf.mainModel setdataDict:dataDic];
        self.renwuView.zhauModel = weakSelf.mainModel;
        
    } failure:^(id error) {
        
    }];
}
-(StoreRiLiView *)storeViews
{
    if(!_storeViews){
        _storeViews =[[StoreRiLiView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_storeViews];
    }
    return _storeViews;
}
//人员数据
-(void)getrenyuan_list:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    self.yearStr = [NSString stringWithFormat:@"%@",@""];
    self.mouchStr = [NSString stringWithFormat:@"%@",@""];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [mDict setObject:self.yearStr forKey:@"y"];
    [mDict setObject:self.mouchStr forKey:@"m"];
    [self.renyuanView.mainTable.mj_header endRefreshing];
    [self.renyuanView.mainTable.mj_footer endRefreshing];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/staff_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [weakSelf.renyuanView.zhuanzhiModel removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        
        if (order_list.count>=20) {
            weakSelf.renyuanView.mainTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf getrenyuan_list:NO];
            }];
        }else{
            weakSelf.renyuanView.mainTable.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            listModel *model = [[listModel alloc]init];
            [model setdataDict:order_list[i]];
            [weakSelf.renyuanView.zhuanzhiModel addObject:model];
        }
        [weakSelf.renyuanView.mainTable reloadData];
    } failure:^(id error) {
        
    }];
}
//下拉刷新
-(void)loadNewData0{
    [self getrenyuan_list:YES];
}
@end

