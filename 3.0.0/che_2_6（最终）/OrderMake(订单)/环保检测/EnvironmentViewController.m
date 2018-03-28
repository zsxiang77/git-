//
//  EnvironmentViewController.m
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "EnvironmentViewController.h"
#import "EnvironmentModel.h"
#import "EnvironmentHeaderView.h"
#import "EnvironmentCell.h"
#import "InsuranceViewController.h"
#import "CarCheckViewController.h"

@interface EnvironmentViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) EnvironmentModel *model;
@end

@implementation EnvironmentViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"环保检测";
    self.view.backgroundColor = [UIColor colorWithHexString:@"EFF1F3"];
    [self setTopViewWithTitle:@"环保检测" withBackButton:YES];
    
    [self setupView];
    [self requestDatas];
}

- (void)setupView
{
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47 + 16);
        make.bottom.mas_equalTo(0);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = self.headerView;
    
    
    CGFloat btnW = (kScreenWidth - 20 - 28) * 0.5;
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(47);
    }];
    [_cancelBtn setTitle:@"不修理" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"4A90E2"] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    _cancelBtn.layer.cornerRadius = 4;
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.borderWidth = CGFloatFromPixel(1);
    _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"4A90E2"].CGColor;
    [_cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(47);
    }];
    [_commitBtn setTitle:@"去修理" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)requestDatas
{
    [self.model buildDataSourceWithModel:_environmentDataModel];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _model.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    EnvironmentSectionModel *model = _model.dataSource[section];
    return model.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    EnvironmentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[EnvironmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    EnvironmentSectionModel *model = _model.dataSource[indexPath.section];
    cell.model = model.rows[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdf = @"header";
    EnvironmentHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdf];
    if (!view) {
        view = [[EnvironmentHeaderView alloc] initWithReuseIdentifier:headerIdf];
    }
    view.model = _model.dataSource[section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnvironmentCellModel *model = _model.dataSource[indexPath.section].rows[indexPath.row];
    return model.isIdleSpeed ? 35 : 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

#pragma mark - Action
- (void)clickCommitButton:(UIButton *)btn
{
    [self requestSaveDataIsCommit:YES];
}

- (void)clickCancelButton:(UIButton *)btn
{
    [self requestSaveDataIsCommit:NO];
}

- (void)requestSaveDataIsCommit:(BOOL)isCommit
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_ordercode forKey:@"ordercode"];
    [param setValue:isCommit ? @"1" : @"0" forKey:@"is_repair"];

    [NetWorkManager requestWithParameters:param withUrl:@"order/repair_order/monitor_save" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        [self pushInsuranceViewController];
        
    } failure:^(NSError *error) {
        [self showMessageWindowWithTitle:error.localizedDescription point:self.view.center delay:1];
    }];
}

/// 保险
- (void)pushInsuranceViewController
{
    
    BOOL isBaoXian = [CreatOrderFlowChartManager defaultOrderFlowChartManager].accidentCar.isBaoXian;
    
    if (isBaoXian) {
        InsuranceViewController *vc = [[InsuranceViewController alloc] init];
        vc.ordercode = _ordercode;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        CarCheckViewController *vc = [[CarCheckViewController alloc] init];
        vc.ordercode = _ordercode;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 680.0 / 1498 * kScreenWidth)];
        _headerView.image = [UIImage imageNamed:@"environment_check_out"];
        
        UIView *line = [UIView new];
        [_headerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(CGFloatFromPixel(1));
        }];
        line.backgroundColor = [UIColor colorWithHexString:@"979797"];
    }
    return _headerView;
}
- (EnvironmentModel *)model
{
    if (!_model) {
        _model = [[EnvironmentModel alloc] init];
    }
    return _model;
}

@end
