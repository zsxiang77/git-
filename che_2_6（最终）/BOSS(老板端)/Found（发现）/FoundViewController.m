//
//  FoundViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundViewController.h"
#import<WebKit/WebKit.h>
#import "UIViewController+MMDrawerController.h"
#import "UIImageView+WebCache.h"
#import "MJChiBaoZiHeader.h"
#import "FoundCell.h"
#import "FoundDetailViewController.h"

@interface FoundViewController ()<UITableViewDelegate,UITableViewDataSource>
{
}

@end

@implementation FoundViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTopViewWithTitle:@"发现" withBackButton:NO];
    
    self.mainDataArray = [[NSMutableArray alloc]init];
    
//    touImaage = [[UIImageView alloc]initWithFrame:CGRectMake(4, 20, 32, 32)];
//    [touImaage.layer setMasksToBounds:YES];
//    [touImaage.layer setCornerRadius:32/2];
//    touImaage.image = DJImageNamed(@"BOSS_tou");
//    [m_baseTopView addSubview:touImaage];
//    UIButton *toubt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [toubt addTarget:self action:@selector(toubtChick:) forControlEvents:(UIControlEventTouchUpInside)];
//    [m_baseTopView addSubview:toubt];
    
    
    /**
     //关闭侧边栏
     */
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-[self getTabBarHeight]-kBOSSNavBarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}
-(void)requestMatchInfoData{
    [self postrequest_methodDatawithShuaXin:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [touImaage  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
    [self postrequest_methodDatawithShuaXin:YES];
}
-(void)toubtChick:(UIButton *)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    FoundCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[FoundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    kWeakSelf(weakSelf);
    cell.changePartst = ^(FoundModel *model) {
        if ([model.is_praise boolValue] == NO) {
            [weakSelf postdo_article_praise:model];
        }
        
    };
    [cell refleshData:self.mainDataArray[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 239;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoundDetailViewController *vc = [[FoundDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chuanZhiModel = self.mainDataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
