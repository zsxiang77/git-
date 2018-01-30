//
//  TheCustomerViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TheCustomerViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ZJSegmentStyle.h"
#import "MJChiBaoZiHeader.h"
#import "UIImageView+WebCache.h"
#import "TheCustomerCell.h"
#import "TheCustomerSearchVC.h"
#import "TheCustomerGeRenVC.h"


@interface TheCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIView                        *shangView;
    
    UIImageView                   *touImaage;
}



@end

@implementation TheCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"客户" withBackButton:NO];
    
//    touImaage = [[UIImageView alloc]initWithFrame:CGRectMake(4, 20, 32, 32)];
//    [touImaage.layer setMasksToBounds:YES];
//    [touImaage.layer setCornerRadius:32/2];
//    touImaage.image = DJImageNamed(@"BOSS_tou");
//    [m_baseTopView addSubview:touImaage];
//    UIButton *toubt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [toubt addTarget:self action:@selector(toubtChick:) forControlEvents:(UIControlEventTouchUpInside)];
//    [m_baseTopView addSubview:toubt];
    
    shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, 86)];
    shangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shangView];
    UILabel *boline = [[UILabel alloc]init];
    boline.backgroundColor = kLineBgColor;
    [shangView addSubview:boline];
    [boline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *souSuoBt = [[UIButton alloc]initWithFrame:CGRectMake(19, 6, kWindowW-38, 32)];
    [souSuoBt addTarget:self action:@selector(souSuoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [souSuoBt.layer setMasksToBounds:YES];
    [souSuoBt setTitle:@"请输入关键词" forState:(UIControlStateNormal)];
    [souSuoBt setImage:DJImageNamed(@"BOOss_souSuo") forState:(UIControlStateNormal)];
    souSuoBt.imageEdgeInsets = UIEdgeInsetsMake(5, -5, 5, 5);
    [souSuoBt setTitleColor:kRGBColor(155, 155, 155) forState:(UIControlStateNormal)];
    [souSuoBt.layer setCornerRadius:32/2];
    souSuoBt.titleLabel.font = [UIFont systemFontOfSize:12];
    [souSuoBt.layer setBorderWidth:1];
    [souSuoBt.layer setBorderColor:kLineBgColor.CGColor];
    [shangView addSubview:souSuoBt];
    
    [self setPlayTitleWithDangQian:YES];
    
    [self postwork_boardwithShuaXin:YES];
}


-(void)souSuoBtChick:(UIButton *)sender
{
    TheCustomerSearchVC *vc = [[TheCustomerSearchVC alloc]init];
    vc.selelctIndex = m_scrollPageView.selectIndex;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [touImaage  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
}

-(NSMutableArray *)mainDataArray
{
    if (!_mainDataArray) {
        _mainDataArray = [[NSMutableArray alloc]init];
    }
    return _mainDataArray;
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight+86, kWindowW, kWindowH-[self getTabBarHeight]-(kBOSSNavBarHeight+86)) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
//        _mainTableView.allowsMultipleSelectionDuringEditing = YES;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(void)requestMatchInfoData
{
    [self postwork_boardwithShuaXin:YES];
}

-(void)setPlayTitleWithDangQian:(BOOL)qiehuan
{
    if(m_scrollPageView != nil){
        [m_scrollPageView removeFromSuperview];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    NSMutableArray *kebianArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        if (i == 0) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"all_count")];
            NSString *str2 = @"全部";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 1) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"A_count")];
            NSString *str2 = @"A类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 2) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"B_count")];
            NSString *str2 = @"B类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 3) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"C_count")];
            NSString *str2 = @"C类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else if (i == 4) {
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"D_count")];
            NSString *str2 = @"D类";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"loss_count")];
            NSString *str2 = @"流失";
            [dict setObject:str2 forKey:@"shang"];
            [dict setObject:str forKey:@"xia"];
        }
        
        [kebianArray addObject:dict];
    }
    
    NSArray *childVcs = kebianArray;

    NSInteger BetShow = 0;
    m_scrollPageView = [[BJDC_headerTitleView alloc] initWithFrame:CGRectMake(0, 30, kWindowW, 55) childVcs:childVcs withhasAppointmentBetShow:BetShow];
    kWeakSelf(weakSelf)
    m_scrollPageView.selectFanHui = ^(NSInteger index){
        [weakSelf postwork_boardwithShuaXin:YES];
        
    };
    [shangView addSubview:m_scrollPageView];
    [shangView sendSubviewToBack:m_scrollPageView];
}

-(void)toubtChick:(UIButton *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    TheCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[TheCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell refleshData:self.mainDataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TheCustomerGeRenVC *vc = [[TheCustomerGeRenVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chuanZhiModel = self.mainDataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}




- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(weakSelf)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"拨号" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        TheCustomerModel *mdeol = weakSelf.mainDataArray[indexPath.row];
        [weakSelf bodaDianHuaWithDianHua:mdeol.mobile];
    }];
    action.backgroundColor = kRGBColor(74, 144, 226);
    return @[action];
}

-(void)bodaDianHuaWithDianHua:(NSString *)str
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]];

}


@end
