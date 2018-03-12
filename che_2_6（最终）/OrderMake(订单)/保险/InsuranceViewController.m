//
//  InsuranceViewController.m
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "InsuranceViewController.h"
#import "InsuranceModel.h"
#import "InsuranceCell.h"
#import "InsuranceHeaderView.h"
#import "PopInsuranceListView.h"
#import "PopInsuranceListModel.h"
#import "PopTimePickerView.h"
#import "CarCheckViewController.h"

@interface InsuranceViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) InsuranceModel *model;

@property (nonatomic, strong) PopTimePickerView *timePickerView;
@property (nonatomic, strong) PopInsuranceListView *popInsurView;
@property (nonatomic, strong) PopInsuranceListModel *popInsurModel;
@end

@implementation InsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保险";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopViewWithTitle:@"保险" withBackButton:YES];
    
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
    NSString *title = [OrderInfoPushManager sharedOrderInfoPushManager].type == OrderInfoPushTypePerctInfo ? @"确定" :@"下一步";
    [_commitBtn setTitle:title forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 45;
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_ordercode forKey:@"ordercode"];
    
    [NetWorkManager requestWithParameters:param withUrl:@"order/new_order/get_insurance" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        InsuranceDataInfoModel *info = [InsuranceDataInfoModel parseJSON:[data objectForKey:@"info"]];
        [self.model buildDatasWithModel:info];
        [self.tableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (void)requestSaveDataWithDataDic:(NSDictionary *)dataDic completion:(void (^)(void))completion
{
    [NetWorkManager requestWithParameters:dataDic withUrl:@"order/new_order/save_insurance" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            [self showMessageWindowWithTitle:@"保存成功" point:self.view.center delay:1];
            !completion ?: completion();
        }
    } failure:^(id error) {
        
    }];
}

- (void)requestInsurancePopDataCompletion:(void (^)(void))completion
{
    [NetWorkManager requestWithParameters:nil withUrl:@"order/repair_order/insurance_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        NSArray *models = [PopInsuranceDataModel parseJSON:data];
        [self.popInsurModel buildDataSourceWithModels:models];
        
        !completion ?: completion();
    } failure:^(id error) {
        
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _model.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.dataSource[section].lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    InsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[InsuranceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    InsuranceSectionModel *model = _model.dataSource[indexPath.section];
    cell.model = model.lists[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headerIdentifier";
    InsuranceHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!view) {
        view = [[InsuranceHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    view.model = _model.dataSource[section];
    return view;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InsuranceSectionModel *model = _model.dataSource[indexPath.section];
    InsuranceCellModel *cellModel = model.lists[indexPath.row];
    switch (cellModel.type) {
        case InsuranceDataTypeForceDate:
        case InsuranceDataTypeBusinessDate:
        case InsuranceDataTypeYearlyCheck:
            [self showTimePickerViewFromDate:cellModel.date cellModel:cellModel];
            break;
        case InsuranceDataTypeForceCompany:
        case InsuranceDataTypeBusinessCompany:
            [self showInsurancePopViewFromCellModel:cellModel];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (void)showTimePickerViewFromDate:(NSDate *)date cellModel:(InsuranceCellModel *)cellModel
{
    @weakify(self)
    NSInteger year = 2;
    if ([cellModel.key isEqualToString:@"valid_car_date"]) {
        year = 10;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];//设置最大时间为：当前时间推后十年
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [self.timePickerView.datePicker setMaximumDate:maxDate];
    
    [self.timePickerView showWithDate:date];
    self.timePickerView.didSecectedDataCallBack = ^(NSDate *date) {
        @strongify(self)
        cellModel.date = date;
        cellModel.isImageShow = NO;
        [self.tableView reloadData];
    };
}

- (void)showInsurancePopViewFromCellModel:(InsuranceCellModel *)model
{
    @weakify(self)
    self.popInsurView.didSecectedCallBack = ^(NSString *name, NSURL *imageURL) {
        @strongify(self)
        model.selectedContent = name;
        model.imageURL = imageURL;
        model.isImageShow = imageURL != nil;
        [self.tableView reloadData];
    };
    
    if (self.popInsurModel.dataSource.count < 1) {
        [self requestInsurancePopDataCompletion:^{
            [self.popInsurView showFromModel:self.popInsurModel];
        }];
        return;
    }
    
    [self.popInsurView showFromModel:self.popInsurModel];
}

#pragma mark - 下一步
- (void)clickCommitButton:(UIButton *)btn
{
    switch ([OrderInfoPushManager sharedOrderInfoPushManager].type) {
        case OrderInfoPushTypePerctInfo:{
            NSMutableDictionary *dic = [self.model getSaveData];
            [dic setValue:_ordercode forKey:@"ordercode"];
            [self requestSaveDataWithDataDic:dic completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } break;
        case OrderInfoPushTypeBuildOrder:{
            
            
            NSMutableDictionary *dic = [self.model getSaveData];
            [dic setValue:_ordercode forKey:@"ordercode"];
            [self requestSaveDataWithDataDic:dic completion:^{
                
                CarCheckViewController *vc = [[CarCheckViewController alloc] init];
                vc.ordercode = self.ordercode;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        } break;
        default:
            break;
    }
}


- (InsuranceModel *)model
{
    if (!_model) {
        _model = [[InsuranceModel alloc] init];
    }
    return _model;
}

- (PopInsuranceListModel *)popInsurModel
{
    if (!_popInsurModel) {
        _popInsurModel = [[PopInsuranceListModel alloc] init];
    }
    return _popInsurModel;
}

- (PopTimePickerView *)timePickerView
{
    if (!_timePickerView) {
        _timePickerView = [[PopTimePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40,  260)];
        //        _timePickerView.datePicker.maximumDate = [NSDate date];
    }
    return _timePickerView;
}

- (PopInsuranceListView *)popInsurView
{
    if (!_popInsurView) {
        _popInsurView = [[PopInsuranceListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, 350)];
    }
    return _popInsurView;
}
@end

