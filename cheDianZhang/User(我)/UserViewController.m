//
//  UserViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "UserViewController.h"
#import "UserMainCell.h"
#import "UserPersonalDataVC.h"
#import "PerformanceViewController.h"
#import "UIImageView+WebCache.h"


@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *main_tabelView;
@property(nonatomic,strong)UIView  *touView;


@property(nonatomic,strong)UIImageView *touImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *stateLabel;

@property(nonatomic,strong)NSDictionary *mainDataDict;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_mainTopTitle = @"我";
    self.touView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 80)];
    self.touView.backgroundColor = kNavBarColor;
    [self.view addSubview:self.touView];
    
    self.touImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
    [self.touImageView.layer setMasksToBounds:YES];
    [self.touImageView.layer setCornerRadius:50/2];
    [self.touImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
    [self.touView addSubview:self.touImageView];
    
    UIButton *touXiangBt = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 60, 60)];
    [touXiangBt addTarget:self action:@selector(touXiangBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.touView addSubview:touXiangBt];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 15, 80, 30)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text =  [UserInfo shareInstance].userReal_name;
    [self.touView addSubview:self.nameLabel];
    
    self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 45, 80, 20)];
    self.stateLabel.textColor = [UIColor whiteColor];
    self.stateLabel.text =  [UserInfo shareInstance].userRole;
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    [self.touView addSubview:self.stateLabel];
    [self.main_tabelView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postHuoQuModele];

}

-(void)postHuoQuModele
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"data_center/privateinfo/staff_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        weakSelf.mainDataDict = adData;
        [UserInfo shareInstance].userMobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"mobile")];
        [UserInfo saveUserName];
        
        [weakSelf.touImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
        weakSelf.nameLabel.text =  [UserInfo shareInstance].userReal_name;
        weakSelf.stateLabel.text =  [UserInfo shareInstance].userRole;
    } failure:^(id error) {
        
    }];
}

-(void)touXiangBtChick:(UIButton *)sender
{
    if (self.mainDataDict) {
        UserPersonalDataVC *vc = [[UserPersonalDataVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.chiZhiDict = self.mainDataDict;
        [self.navigationController  pushViewController:vc animated:YES];
    }
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, kWindowW, kWindowH-80-[self getTabBarHeight]) style:UITableViewStylePlain];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        [_main_tabelView registerClass:[UserMainCell class] forCellReuseIdentifier:@"Cell"];
//        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _main_tabelView.scrollEnabled = NO;
        [self.view addSubview:_main_tabelView];
        
    }
    return _main_tabelView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserMainCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.tiaozhuanImageView.hidden = NO;
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"昨日绩效";
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"今日绩效";
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"本周业绩";
    }else
    {
        cell.titleLabel.text = @"本月业绩";
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PerformanceViewController *vc = [[PerformanceViewController alloc]init];
    if (indexPath.row == 0) {
        vc.titleName = @"昨日绩效";
    }
    if (indexPath.row == 1) {
        vc.titleName = @"今日绩效";
    }
    if (indexPath.row == 2) {
        vc.titleName = @"本周业绩";
    }
    if (indexPath.row == 3) {
        vc.titleName = @"本月业绩";
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [footView addSubview:line];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end
