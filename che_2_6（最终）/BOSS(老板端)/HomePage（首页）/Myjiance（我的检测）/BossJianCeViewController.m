//
//  BossJianCeViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossJianCeViewController.h"
#import "MJChiBaoZiHeader.h"
#import "BossJianCeTableViewCell.h"
#import "WKWebViewViewController.h"
#import "BossJianCeZiCeViewController.h"

@interface BossJianCeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BossJianCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"我的检测" withBackButton:YES];
    main_dataArry = [[NSMutableArray alloc]init];
    
    [self postmy_videoDatawithShuaXin:YES];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(void)requestMatchInfoData
{
    [self postmy_videoDatawithShuaXin:YES];
}

-(void)postmy_videoDatawithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    
    [[self.mainTableView viewWithTag:3000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [mDict setObject:@"20" forKey:@"pagesize"];
    
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/my_exam" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [main_dataArry removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        if (order_list.count>=20) {
            weakSelf.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf postmy_videoDatawithShuaXin:NO];
            }];
        }else{
            weakSelf.mainTableView.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            BossJianceModel *model = [[BossJianceModel alloc]init];
            [model setDatashuJu:order_list[i]];
            [main_dataArry addObject:model];
        }
        
        if(main_dataArry.count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无收藏数据";
            cLabel.tag = 3000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [weakSelf.mainTableView addSubview:cLabel];
            
        }
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return main_dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    BossJianCeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[BossJianCeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refleshData:main_dataArry[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 496/2+20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //  BossJianceModel *model = main_dataArry[indexPath.row];
//    WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
//    vc.isNoShowNavBar = NO;
//    vc.webUrl = [NSString stringWithFormat:@"%@?a_id=%@&exam_id=1",model.url,model.a_id];
//    [self.navigationController pushViewController:vc animated:YES];
    BossJianCeZiCeViewController * vc = [[BossJianCeZiCeViewController alloc]init];
    vc.chuanZhiModel = main_dataArry[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
