//
//  StoreTheDataViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreTheDataViewController.h"

@interface StoreTheDataViewController ()
{
    
}

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
        [weakSelf.view bringSubviewToFront:weakSelf.calendar];
        [weakSelf.calendar show];
    };
    [self.view addSubview:self.renwuView];
    self.shouruView = [[StoreShouRuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview: self.shouruView];
    self.peijianView = [[StorePeiJianView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview:self.peijianView];
    self.renyuanView= [[StoreRenYuanView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
    self.renyuanView.showRiLiBlock = ^{
        [weakSelf.view bringSubviewToFront:weakSelf.calendar];
        [weakSelf.calendar show];
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
    
    
    
    //日历
    HWCalendar *calendar = [[HWCalendar alloc] initWithFrame:CGRectMake(0, kWindowH, kWindowW, kWindowH)];
    calendar.delegate = self;
    calendar.showTimePicker = YES;
    [self.view addSubview:calendar];
    self.calendar = calendar;
     
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
//下拉刷新
-(void)loadNewData0{
    [self getrenyuan_list:YES];
}

#pragma mark - HWCalendarDelegate
- (void)calendar:(HWCalendar *)calendar didClickSureButtonWithDate:(NSString *)date
{
    
}
@end

