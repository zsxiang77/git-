//
//  StoreTheDataViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreTheDataViewController.h"
#import "StoreRenYuanDeileVC.h"
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

    self.renwuView.hidden = NO;
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
//任务
-(StoreRenWuView *)renwuView
{
    if (!_renwuView) {
        _renwuView = [[StoreRenWuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
        kWeakSelf(weakSelf)
        _renwuView.headerView.showRiLiBlock = ^{
            [weakSelf.view bringSubviewToFront:weakSelf.calendar];
            [weakSelf.calendar show];
        };
         [self.view addSubview:_renwuView];
    }
    return _renwuView;
}
//人员
-(StoreRenYuanView *)renyuanView
{
    if(!_renyuanView){
        _renyuanView= [[StoreRenYuanView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
         kWeakSelf(weakSelf)
        _renyuanView.showRiLiBlock = ^{
            [weakSelf.view bringSubviewToFront:weakSelf.calendar];
            [weakSelf.calendar show];
        };
        _renyuanView.xuanzhonRowBlock = ^(listModel *mode, NSUInteger index) {
            StoreRenYuanDeileVC *vc = [[StoreRenYuanDeileVC alloc]init];
                        vc.chaunzhiStr = mode;
                        vc.yearStrzhi =  weakSelf.yearStr;
                        vc.monthStrzhi = weakSelf.mouchStr;
                        vc.index = index;
                        vc.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _renyuanView.mainTable.mj_header =[MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        
        [self.view addSubview:_renyuanView];
    }
    return _renyuanView;
}
//配件
-(StorePeiJianView *)peijianView
{
    if(!_peijianView){
        _peijianView = [[StorePeiJianView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
        [self.view addSubview:_peijianView];
    }
    return _peijianView;
}

//收入
-(StoreShouRuView *)shouruView
{
    if(!_shouruView){
        _shouruView= [[StoreShouRuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
        [self.view addSubview: _shouruView];
    }
    return _shouruView;
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

