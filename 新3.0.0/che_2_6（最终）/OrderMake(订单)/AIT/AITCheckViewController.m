//
//  AITCheckViewController.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "AITCheckViewController.h"
#import "AITCheckModel.h"
#import "AITCheckCell.h"
#import "AITCheckIconView.h"
#import "AITCheckPreviewViewController.h"

@interface AITCheckViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) AITCheckIconView *AITView;
@property (nonatomic, strong) UILabel *numberLb;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) AITCheckModel *model;
@end

@implementation AITCheckViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AIT智能检测";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self setTopViewWithTitle:@"AIT智能检测" withBackButton:YES];
    
    [self setupView];
    [self requestDatas];
}

- (void)setupView
{
    _AITView = [[AITCheckIconView alloc] init];
    [self.view addSubview:_AITView];
    [_AITView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(m_baseTopView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(300);
    }];
    
    _numberLb = [[UILabel alloc] init];
    [self.view addSubview:_numberLb];
    [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.AITView.mas_bottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    _numberLb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
    _numberLb.textColor = [UIColor colorWithHexString:@"4a4a4a"];
    _numberLb.text = @"请选择AIT序列";
    
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
    [_commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLb.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (void)requestDatas
{
    [self.model buildDataSourceWithModel:_carCheckDataModel];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    AITCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AITCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _model.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (AITCheckCellModel *cm in _model.dataSource) {
        cm.isSelected = NO;
    }
    AITCheckCellModel *model = _model.dataSource[indexPath.row];
    model.isSelected = YES;
    [tableView reloadData];
}

- (void)clickCommitButton:(UIButton *)btn
{
    AITCheckCellModel *model = nil;
    for (AITCheckCellModel *m in _model.dataSource) {
        if (m.isSelected) {
            model = m;
            break;
        }
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_ordercode forKey:@"ordercode"];
    [param setValue:model.title forKey:@"serial_number"];
    
    [NetWorkManager requestWithParameters:param withUrl:@"order/repair_order/save_ait" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            AITCheckPreviewViewController *vc = [[AITCheckPreviewViewController alloc] init];
            vc.ordercode = _ordercode;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [self showAlertViewWithTitle:[responseObject objectForKey:@"msg"] Message:nil buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
    
    
}

- (AITCheckModel *)model
{
    if (!_model) {
        _model = [[AITCheckModel alloc] init];
    }
    return _model;
}

@end
