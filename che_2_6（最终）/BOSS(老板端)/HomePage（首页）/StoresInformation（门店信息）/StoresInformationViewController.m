//
//  StoresInformationViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoresInformationViewController.h"
#import "StoresInformationCell.h"
#import "StoresInforDateViewController.h"

#import "BOSSForTochangeMailViewController.h"
#import "BOSSForTochangeNameViewController.h"
#import "BOSSForTochangeaddreeViewController.h"
#import "BOSSForTochangeMildelViewController.h"
#import "BOSSForTochangelianxirenViewController.h"

@interface StoresInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSDictionary *mainData;

@end

@implementation StoresInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"门店信息" withBackButton:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self huoquMenDianData];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate  = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}
-(void)huoquMenDianData
{
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@user/ucenter/store_info",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 404) {
            NPrintLog(@"msg:%@",KISDictionaryHaveKey(parserDict, @"msg"));
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            weakSelf.mainData = adData;
            [weakSelf.mainTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NPrintLog(@"task是%@",task);
        [weakSelf showOrHideLoadView:NO];
    }];
    
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    StoresInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[StoresInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        [cell shuaXingCellWithZuo:@"门店名称" withRight:KISDictionaryHaveKey(self.mainData,@"store_name") shiFouErwei:NO];
    }else if (indexPath.row == 1) {
        [cell shuaXingCellWithZuo:@"门店地址" withRight:KISDictionaryHaveKey(self.mainData,@"address") shiFouErwei:NO];
    }else if (indexPath.row == 2) {
        [cell shuaXingCellWithZuo:@"联系人" withRight:KISDictionaryHaveKey(self.mainData,@"contact") shiFouErwei:NO];
    }else if (indexPath.row == 3) {
        [cell shuaXingCellWithZuo:@"门店电话" withRight:KISDictionaryHaveKey(self.mainData,@"phone") shiFouErwei:NO];
    }else if (indexPath.row == 4) {
        [cell shuaXingCellWithZuo:@"邮箱" withRight:KISDictionaryHaveKey(self.mainData,@"email") shiFouErwei:NO];
    }else if (indexPath.row == 5) {
        [cell shuaXingCellWithZuo:@"营业时间" withRight:KISDictionaryHaveKey(self.mainData,@"yytime") shiFouErwei:NO];
    }else{
        [cell shuaXingCellWithZuo:@"门店二维码" withRight:@"" shiFouErwei:YES];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0){
 BOSSForTochangeNameViewController*vc=[[BOSSForTochangeNameViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        vc.chaunzhiMdisn=self.mainData;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if(indexPath.row==1){
        BOSSForTochangeaddreeViewController*vc=[[BOSSForTochangeaddreeViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
          vc.chaunzhiMdisn=self.mainData;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row==2){
        BOSSForTochangelianxirenViewController*vc=[[BOSSForTochangelianxirenViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
          vc.chaunzhiMdisn=self.mainData;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row==3){
        BOSSForTochangeMildelViewController*vc=[[BOSSForTochangeMildelViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
          vc.chaunzhiMdisn=self.mainData;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row==4){
        BOSSForTochangeMailViewController*vc=[[BOSSForTochangeMailViewController alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        vc.chaunzhiMdisn=self.mainData;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
