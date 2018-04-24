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
@interface StoreTheDataViewController ()
{
    
    UILabel * lineLable;
    CGFloat widths;
    StoreRenWuView * renwuView;  //任务
    StoreRenYuanView * renyuanView;//人员
    StorePeiJianView * peijianView;//配件
    StoreShouRuView * shouruView; //收入
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
 
    renwuView = [[StoreRenWuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
    kWeakSelf(weakSelf)
    renwuView.headerView.showRiLiBlock = ^{
        weakSelf.storeViews.hidden= NO;
    };
    [self.view addSubview:renwuView];
    shouruView = [[StoreShouRuView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview:shouruView];
    peijianView = [[StorePeiJianView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview:peijianView];
    renyuanView = [[StoreRenYuanView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
     [self.view addSubview:renyuanView];
    renwuView.hidden = NO;
    shouruView.hidden = YES;
    peijianView.hidden = YES;
    renyuanView.hidden = YES;
    viewsTine.viewQieHuan = ^(NSUInteger shifouxuanzhong) {
        renwuView.hidden = YES;
        shouruView.hidden = YES;
        peijianView.hidden = YES;
        renyuanView.hidden = YES;
        if(shifouxuanzhong ==400){
            NPrintLog(@"任务--1----%ld",shifouxuanzhong);
            renwuView.hidden = NO;
            
        }
        if(shifouxuanzhong ==401){
            NPrintLog(@"人员--2----%ld",shifouxuanzhong);
              renyuanView.hidden = NO;
        }
        if(shifouxuanzhong ==402){
            NPrintLog(@"配件--3----%ld",shifouxuanzhong);
              peijianView.hidden = NO;
        }
        if(shifouxuanzhong ==403){
            NPrintLog(@"收入--4----%ld",shifouxuanzhong);
             shouruView.hidden = NO;
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
//数据
-(void)getTask_status
{
    self.timeStr = [NSString stringWithFormat:@"%@",@""];
    self.timeStr = [NSString stringWithFormat:@"%@",@"2"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.timeStr forKey:@"time"];
    [mDict setObject:self.timeStr forKey:@"date"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/task_status" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        [weakSelf.mainModel setdataDict:dataDic];
        renwuView.zhauModel = weakSelf.mainModel;
        
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
@end

