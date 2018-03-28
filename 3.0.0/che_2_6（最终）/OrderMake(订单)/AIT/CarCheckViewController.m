//
//  CarCheckViewController.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//  

#import "CarCheckViewController.h"
#import "CarCheckModel.h"
#import "CarCheckCell.h"
#import "AITCheckViewController.h"
#import "CarInspectionViewController.h"

@interface CarCheckViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) CarCheckModel *model;
@end

@implementation CarCheckViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接车检查";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopViewWithTitle:@"接车检查" withBackButton:YES];
    
    [self setupView];
    [self requestDatas];
}

- (void)setupView
{
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47 + 13);
        make.bottom.mas_equalTo(0);
    }];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(47);
    }];
    [_commitBtn setTitle:@"开  始" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 130;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (void)requestDatas
{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:_ordercode forKey:@"ordercode"];
    
    [NetWorkManager requestWithParameters:nil withUrl:@"order/repair_order/inspect_flow" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        CarCheckDataModel *model = [CarCheckDataModel parseJSON:data];
        [self.model buildDataSourceWithModel:model];
        [self.tableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CarCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CarCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CarCheckCellModel *model = _model.dataSource[indexPath.row];
    model.index = @(indexPath.row + 1).stringValue;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)clickCommitButton:(UIButton *)btn
{
    if (_model.hasBrainpower) {
        
        AITCheckViewController *vc = [[AITCheckViewController alloc] init];
        vc.ordercode = _ordercode;
        vc.carCheckDataModel = _model.model;
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    // 外观检查
    CarInspectionViewController *vc = [[CarInspectionViewController alloc] init];
    vc.chuaOrdercode = _ordercode;
    [self.navigationController pushViewController:vc animated:YES];
}


- (CarCheckModel *)model
{
    if (!_model) {
        _model = [[CarCheckModel alloc] init];
    }
    return _model;
}
@end
