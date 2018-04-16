//
//  PerfectInfoViewController.m
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "PerfectInfoViewController.h"
#import "PerctInfoModel.h"
#import "PerctInfoCell.h"
#import "ScanDrivingLicenseViewController.h"
#import "InsuranceViewController.h"
#import "WritePersonalViewController.h"
#import "JieCheInformiTionVC.h"
#import "FunctionalCheckViewController.h"
#import "AccessoryEquipmentVC.h"
#import "CarInspectionViewController.h"

@interface PerfectInfoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PerctInfoModel *model;
@end

@implementation PerfectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善信息";
    
    [self setTopViewWithTitle:@"完善信息" withBackButton:YES];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [OrderInfoPushManager sharedOrderInfoPushManager].type = OrderInfoPushTypePerctInfo;
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestDatas];
}

- (void)setupView
{
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 4)];
    _progressView.top = m_baseTopView.bottom;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"B4EC51"].CGColor, (__bridge id)[UIColor colorWithHexString:@"39D1BD"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, 0, 4);
    _gradientLayer = gradientLayer;
    [_progressView.layer addSublayer:gradientLayer];
    [self.view addSubview:_progressView];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 65;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.progressView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)requestDatas
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_ordercode forKey:@"ordercode"];
    
    [NetWorkManager requestWithParameters:param.copy withUrl:@"order/repair_order/inspect_schedule" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        PerctInfoDataModel *model = [PerctInfoDataModel parseJSON:data];
        [self.model buildDataSourceWithModel:model];
        [self updateUI];
    } failure:^(id error) {
        
    }];
}

- (void)updateUI {
    if (_model.progress < 50) {
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"F5515F"].CGColor, (__bridge id)[UIColor colorWithHexString:@"FF9C55"].CGColor];
    }else{
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"A4D0FF"].CGColor, (__bridge id)[UIColor colorWithHexString:@"1786FF"].CGColor];
    }
    _progressView.width = kScreenWidth * _model.progress;
    _gradientLayer.width = kScreenWidth * _model.progress;
    
    
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
    PerctInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PerctInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _model.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithCellModel:_model.dataSource[indexPath.row]];
}

- (void)pushViewControllerWithCellModel:(PerctInfoCellModel *)cellModel
{
    NSString *key = cellModel.model.key;
    
    if ([key isEqualToString:@"car_info"] || [key isEqualToString:@"insurance_info"]) {
        // 提示完善
        if (_model.isNoUserID) {
            [self showMessage];
            return;
        }
    }
    
    if ([key isEqualToString:@"user_info"]) {
        WritePersonalViewController *vc = [[WritePersonalViewController alloc] init];
        vc.ordercode = _ordercode;
        vc.shiFouQieHuan = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([key isEqualToString:@"car_info"]) {
        ScanDrivingLicenseViewController *vc = [[ScanDrivingLicenseViewController alloc] init];
        vc.ordercode = _ordercode;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([key isEqualToString:@"insurance_info"]) {
        InsuranceViewController *vc = [[InsuranceViewController alloc] init];
        vc.ordercode = _ordercode;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([key isEqualToString:@"inspect_info"]) {
        CarInspectionViewController *vc = [[CarInspectionViewController alloc]init];
        vc.chuaOrdercode = self.ordercode;
        vc.shiFouFanHui = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([key isEqualToString:@"goods"]) {
        
        
        AccessoryEquipmentVC *vc = [[AccessoryEquipmentVC alloc]init];
        vc.chuaOrdercode = self.ordercode;
        vc.shiFouFanHui = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([key isEqualToString:@"functions"]) {
        FunctionalCheckViewController *vc = [[FunctionalCheckViewController alloc]init];
        vc.chuaOrdercode = self.ordercode;
        vc.shiFouFanHui = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([key isEqualToString:@"gas"]) {
        JieCheInformiTionVC *vc = [[JieCheInformiTionVC alloc]init];
        vc.chuaOrdercode = self.ordercode;
        vc.shiFouFanHui = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

- (void)showMessage
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请先完善客户信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    @weakify(self)
    UIAlertAction *commitAc = [UIAlertAction actionWithTitle:@"去完善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WritePersonalViewController *vc = [[WritePersonalViewController alloc] init];
        vc.ordercode = weak_self.ordercode;
        [weak_self.navigationController pushViewController:vc animated:YES];
    }];
    
    [cancelAc setValue:[UIColor colorWithHexString:@"4a4a4a"] forKey:@"_titleTextColor"];
    [commitAc setValue:[UIColor colorWithHexString:@"4A90E2"] forKey:@"_titleTextColor"];
    
    [ac addAction:cancelAc];
    [ac addAction:commitAc];
    
    [self presentViewController:ac animated:YES completion:nil];
}

- (PerctInfoModel *)model
{
    if (!_model) {
        _model = [[PerctInfoModel alloc] init];
    }
    return _model;
}

//#pragma mark -
//- (void)requestDatasCarInfoCompletion:(void (^)(BOOL isError))completion
//{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:_ordercode forKey:@"ordercode"];
//    
//    [NetWorkManager requestWithParameters:param.copy withUrl:@"order/new_order/get_license_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
//        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
//        !completion ?: completion(code == 203);
//    } failure:^(NSError *error) {
//        [self showMessageWindowWithTitle:error.localizedDescription point:self.view.center delay:1];
//    }];
//}
//
//- (void)requestDatasInsuranceInfoCompletion:(void (^)(BOOL isError))completion
//{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:_ordercode forKey:@"ordercode"];
//    
//    [NetWorkManager requestWithParameters:param withUrl:@"order/new_order/get_insurance" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
//        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
//        !completion ?: completion(code == 203);
//    } failure:^(NSError *error) {
//        [self showMessageWindowWithTitle:error.localizedDescription point:self.view.center delay:1];
//    }];
//}
@end
