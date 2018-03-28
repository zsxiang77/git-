//
//  AITBaoGaoListVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "AITBaoGaoListVC.h"
#import "MJChiBaoZiHeader.h"
#import "AITBaoGaoListCell.h"

@interface AITBaoGaoListVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AITBaoGaoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"检测报告" withBackButton:YES];
    self.mainAit_list = [[NSMutableArray alloc]init];
    self.mainPad_list = [[NSMutableArray alloc]init];
    [self postget_report];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        _main_tabelView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}

-(void)loadNewData0
{
    [self postget_report];
}


-(void)postget_report
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.ordercode forKey:@"ordercode"];
    [mDict setObject:self.vin forKey:@"vin"];
    
    
    [self.main_tabelView.mj_header endRefreshing];

    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/new_order/get_report" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        weakSelf.mainDataDict = dataDic;
        NSArray *ait_list = KISDictionaryHaveKey(dataDic, @"ait_list");
        if (![ait_list isKindOfClass:[NSArray class]]) {
            return;
        }
        
        [weakSelf.mainAit_list removeAllObjects];
        
        for (int i = 0; i<ait_list.count; i++) {
            [weakSelf.mainAit_list addObject:ait_list[i]];
        }
        
        NSArray *pad_list = KISDictionaryHaveKey(dataDic, @"pad_list");
        [weakSelf.mainPad_list removeAllObjects];
        for (int i = 0; i<pad_list.count; i++) {
            [weakSelf.mainPad_list addObject:pad_list[i]];
        }
        
        [weakSelf.main_tabelView reloadData];
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.mainAit_list.count;
    }else{
        return self.mainPad_list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    AITBaoGaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AITBaoGaoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell refeleseWithModel:self.mainAit_list[indexPath.row] withStr:[NSString stringWithFormat:@"AIT检测报告 %ld",indexPath.row+1]];
    }else{
        [cell refeleseWithModel:self.mainPad_list[indexPath.row] withStr:[NSString stringWithFormat:@"诊断报告 %ld",indexPath.row+1]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *haecVIew = [[UIView alloc]init];
    haecVIew.backgroundColor = self.view.backgroundColor;
    UILabel *la = [[UILabel alloc]init];
    la.textColor = kRGBColor(74, 74, 74);
    la.font = [UIFont boldSystemFontOfSize:14];
    [haecVIew addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(haecVIew);
    }];
    if ([self.mainDataDict isKindOfClass:[NSDictionary class]]) {
        if (section == 0) {
            la.text = [NSString stringWithFormat:@"AIT检测报告（%@）",KISDictionaryHaveKey(self.mainDataDict, @"ait_count")];
        }else{
            la.text = [NSString stringWithFormat:@"诊断报告（%@）",KISDictionaryHaveKey(self.mainDataDict, @"pad_count")];
        }
    }
    return haecVIew;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 77/2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
    vc.isNoShowNavBar = YES;
    vc.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        vc.navTitle = @"AIT检测报告";
        vc.webUrl = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainAit_list[indexPath.row], @"url")];
    }else{
        vc.navTitle = @"诊断报告";
        vc.webUrl = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainPad_list[indexPath.row], @"url")];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
