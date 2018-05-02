//
//  StoreRenYuanDeileVC.m
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenYuanDeileVC.h"
#import "StoreRenYuanNengLiCell.h"

@interface StoreRenYuanDeileVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation StoreRenYuanDeileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"员工能力" withBackButton:YES];
    
    self.headerview = [[StoreCellHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 894/2)];
    
    
    
    self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStyleGrouped];
    self.mainTable.backgroundColor = [UIColor whiteColor];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.tableHeaderView = self.headerview;
    self.mainTable.mj_header =[MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
    [self.view addSubview:self.mainTable];
    [self getXiangqing_staff_ability];
}
#pragma mark- cell 数据
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *Identifier = @"Identifier";
    StoreRenYuanNengLiCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[StoreRenYuanNengLiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refleshData:self.chaunzhiModel.achievement dieIndex:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(StoreDetliModel *)chaunzhiModel
{
    if (!_chaunzhiModel) {
        _chaunzhiModel = [[StoreDetliModel alloc]init];
    }
    return _chaunzhiModel;
}
-(void)loadNewData0{
    [self getXiangqing_staff_ability];
    
}
//人员详情
-(void)getXiangqing_staff_ability
{
    self.yearStrzhi = [NSString stringWithFormat:@"%@",@""];
    self.monthStrzhi = [NSString stringWithFormat:@"%@",@"2"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.yearStrzhi forKey:@"y"];
    [mDict setObject:self.monthStrzhi forKey:@"m"];
    [mDict setObject:self.chaunzhiStr.staff_id forKey:@"staff_id"];
    [self.mainTable.mj_header endRefreshing];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/staff_ability" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
      
        [weakSelf.chaunzhiModel setdataDict:dataDic];
        weakSelf.headerview.dataModel = weakSelf.chaunzhiModel;
        weakSelf.headerview.modes = weakSelf.chaunzhiStr;
        weakSelf.headerview.indexRow = weakSelf.index;
        [weakSelf.mainTable reloadData];
        [weakSelf.headerview reloadData];
       
    } failure:^(id error) {
        
    }];
}
@end
