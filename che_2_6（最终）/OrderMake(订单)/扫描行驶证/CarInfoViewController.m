//
//  CarInfoViewController.m
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CarInfoViewController.h"
#import "CarInfoChooseView.h"
#import "CarInfoColorView.h"
#import "CarInfoTypeView.h"
#import "CarInfoChooseViewCell.h"
#import "CarInfoModel.h"
#import "EnvironmentModel.h"
#import "EnvironmentViewController.h"
#import "InsuranceViewController.h"
#import "ModelCarViewController.h"
#import "CarCheckViewController.h"

//#define kNavBarHeight (self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height)


@interface CarInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CarInfoChooseView *chooseView;
@property (nonatomic, strong) CarInfoColorView *colorView;
@property (nonatomic, strong) CarInfoTypeView *typeView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) CarInfoModel *model;

@property (nonatomic, strong) CarInfoDataAdaptCarsModel *selectedCarsModel;
@end

@implementation CarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"扫描行驶证";
    [self setTopViewWithTitle:@"扫描行驶证" withBackButton:YES];
    
    [self setupViews];
    [self configurDefault];
    [self requestDatas];
    
    @weakify(self)
    _chooseView.didChooseCarButtonCallBack = ^{
        @strongify(self)
        [self didSelectedCarType];
    };
}

- (void)setupViews
{
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47 + 11);
        make.bottom.mas_equalTo(0);
    }];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    _chooseView = [[CarInfoChooseView alloc] init];
    _chooseView.style = CarInfoChooseViewStyleNoData;
    [_scrollView addSubview:_chooseView];
    [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(_chooseView.currHeight);
    }];
    _chooseView.tableView.delegate = self;
    _chooseView.tableView.dataSource = self;
    
    UIView *line1 = [self getLineView];
    [_scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.chooseView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    _colorView = [[CarInfoColorView alloc] init];
    [_scrollView addSubview:_colorView];
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(line1.mas_bottom);
        make.height.mas_equalTo(133);
    }];
    
    UIView *line2 = [self getLineView];
    [_scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.colorView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    _typeView = [[CarInfoTypeView alloc] init];
    [_scrollView addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(line2.mas_bottom);
        make.height.mas_equalTo(110);
        make.bottom.mas_equalTo(0);
    }];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(47);
    }];
    [_commitBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configurDefault
{
    [_colorView setSelectedColorWithColorText:@"黑色"];
    [_typeView setSelectedCarWithCatTypeInt:1];
}
- (void)requestDatas
{
    if (_vin.length != 17) {
        return;
    }
    
    if (!_isNeedRequestVinData) {
        if (_licenseDataModel.adapt_cars.count > 0) {
            CarInfoDataAdaptCarsModel *carsModel = _licenseDataModel.adapt_cars.lastObject;
            [self sendCarInfoWithModel:carsModel];
        }else{
            self.chooseView.style = CarInfoChooseViewStyleNoData;
            [self.chooseView.tableView reloadData];
        }
        [self updateUI];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_vin forKey:@"query"];
    
    [NetWorkManager requestWithParameters:param.copy withUrl:@"order/order_query/user_vin" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        CarInfoDataModel *model = [CarInfoDataModel parseJSON:data];
        [self.model buildDataSourceWithModel:model];
        if (self.model.dataSource.count < 1) {
            self.chooseView.style = CarInfoChooseViewStyleNoData;
            if (LC_isStrEmpty(_licenseDataModel.car_body_color)) {
                [_colorView setSelectedColorWithColorText:@"黑色"];
            }else{
                [_colorView setSelectedColorWithColorText:_licenseDataModel.car_body_color];
            }
            switch (_licenseDataModel.cartype) {
                case 1:
                case 2:
                case 3:
                case 9:
                    [_typeView setSelectedCarWithCatTypeInt:_licenseDataModel.cartype];
                    break;
                default:
                    [_typeView setSelectedCarWithCatTypeInt:1];
                    break;
            }
            [self.chooseView.tableView reloadData];
        }
        else if (self.model.dataSource.count == 1) {
            CarInfoCellModel *lastCM = self.model.dataSource.lastObject;
            [self sendCarInfoWithModel:lastCM.model];
        }
        else {
            self.chooseView.style = CarInfoChooseViewStyleList;
            [self updateUI];
            [self.chooseView.tableView reloadData];
        }
        
    } failure:^(id error) {
        
    }];
}

- (void)updateUI
{
    [_colorView setSelectedColorWithColorText:_licenseDataModel.car_body_color];
    [_typeView setSelectedCarWithCatTypeInt:_licenseDataModel.cartype];
}

- (void)requestSaveDataWithDataDic:(NSDictionary *)dataDic completion:(void (^)(void))completion
{
    [NetWorkManager requestWithParameters:dataDic withUrl:@"order/new_order/save_license_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            [self showMessageWindowWithTitle:@"保存成功" point:self.view.center delay:1];
            !completion ?: completion();
        }
    } failure:^(id error) {
        
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CarInfoChooseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CarInfoChooseViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _model.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (CarInfoCellModel *cm in _model.dataSource) {
        cm.isSelected = NO;
    }
    CarInfoCellModel *model = _model.dataSource[indexPath.row];
    model.isSelected = YES;
    [tableView reloadData];
}

#pragma mark - Action
- (void)didSelectedCarType
{
    ModelCarViewController *vc = [[ModelCarViewController alloc]init];
    vc.superViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendCarInfoWithModel:(CarInfoDataAdaptCarsModel *)model
{
    self.chooseView.style = CarInfoChooseViewStyleManual;
    self.selectedCarsModel = model;
    CarInfoCellModel *cellModel = [[CarInfoCellModel alloc] initWithModel:model];
    self.chooseView.manualChooseText = cellModel.title;
    [self.chooseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_chooseView.currHeight);
    }];
}

- (void)clickCommitButton:(UIButton *)btn
{
    NSDictionary *infoDic = [self buildSaveData];
    NSString *infoJson = [infoDic objectForKey:@"infoJson"];
    NSString *errorMsg = [infoDic objectForKey:@"errorMessage"];
    
    if ([infoJson isEmptyOrWhitespace]) {
        [self showMessageWindowWithTitle:errorMsg point:self.view.center delay:1];
        return;
    }
    [self requestSaveDataWithDataDic:@{@"info":infoJson} completion:^{
        
        switch ([OrderInfoPushManager sharedOrderInfoPushManager].type) {
            case OrderInfoPushTypePerctInfo:{
                [self.navigationController popToBeforeViewControllerWithNum:2 animated:YES];
            } break;
            case OrderInfoPushTypeBuildOrder:{
                //环保检测
                [self requestEnvironmentCheckData];
                
            } break;
            default:
                break;
        }
    }];
}

- (void)clickScanButton:(UIButton *)btn
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestEnvironmentCheckData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_licenseDataModel.car_number forKey:@"car_number"];
    [param setValue:_vin forKey:@"vin"];

    [NetWorkManager requestWithParameters:param.copy withUrl:@"order/repair_order/monitor" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            EnvironmentDataModel *dataModel = [EnvironmentDataModel parseJSON:data];
            
            EnvironmentViewController *vc = [[EnvironmentViewController alloc] init];
            vc.ordercode = _ordercode;
            vc.environmentDataModel = dataModel;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (code == 203) {
            [self pushInsuranceViewController];
        }
        
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

#pragma mark -
/**
 key:infoJson, key:errorMessage
 */
- (NSDictionary *)buildSaveData
{
    CarInfoDataAdaptCarsModel *carsModle = [self getSelectedCarsModel];
    if ([carsModle.type isEmptyOrWhitespace]) {
        return @{@"infoJson":@"", @"errorMessage":@"请选择车型"};
    }
    if ([carsModle.brand isEmptyOrWhitespace]) {
        return @{@"infoJson":@"", @"errorMessage":@"请选择车型"};
    }
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:_ordercode forKey:@"ordercode"];
    [dataDic setValue:carsModle.brand forKey:@"car_brand"];
    [dataDic setValue:carsModle.type forKey:@"car_type"];
    [dataDic setValue:carsModle.spec forKey:@"cars_spec"];
    [dataDic setValue:carsModle.spec_id forKey:@"spec_id"];
    [dataDic setValue:_colorView.selectedColor forKey:@"car_body_color"];
    [dataDic setValue:_licenseDataModel.owner forKey:@"owner"];
    [dataDic setValue:_licenseDataModel.carvin forKey:@"carvin"];
    [dataDic setValue:_licenseDataModel.use_character forKey:@"use_character"];
    [dataDic setValue:_licenseDataModel.register_date forKey:@"register_date"];
    [dataDic setValue:_licenseDataModel.model forKey:@"model"];
    [dataDic setValue:_licenseDataModel.issue_date forKey:@"issue_date"];
    [dataDic setValue:_licenseDataModel.address forKey:@"address"];
    [dataDic setValue:[_typeView getSelectedCarParam] forKey:@"cartype"];
    [dataDic setValue:_licenseDataModel.car_number forKey:@"carno"];
    [dataDic setValue:_licenseDataModel.images forKey:@"images"];
    [dataDic setValue:_licenseDataModel.engine_number forKey:@"engine_number"];

    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:[dataDic jsonStringEncoded] forKey:@"infoJson"];
    [data setValue:@"" forKey:@"errorMessage"];
    return data.copy;
}

- (CarInfoDataAdaptCarsModel *)getSelectedCarsModel
{
    switch (_chooseView.style) {
        case CarInfoChooseViewStyleList:
            for (CarInfoCellModel *cellM in _model.dataSource) {
                if (cellM.isSelected) {
                    self.selectedCarsModel = cellM.model;
                    break;
                }
            }
            return self.selectedCarsModel;
        case CarInfoChooseViewStyleManual:
            return self.selectedCarsModel;
        case CarInfoChooseViewStyleNoData:
            
            return [CarInfoDataAdaptCarsModel new];
    }
}

- (UIView *)getLineView
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    return line;
}

- (CarInfoModel *)model
{
    if (!_model) {
        _model = [[CarInfoModel alloc] init];
    }
    return _model;
}

- (CarInfoDataAdaptCarsModel *)selectedCarsModel
{
    if (!_selectedCarsModel) {
        _selectedCarsModel = [[CarInfoDataAdaptCarsModel alloc] init];
    }
    return _selectedCarsModel;
}

@end
