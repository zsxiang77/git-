//
//  ScanDrivingLicenseViewController.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "ScanDrivingLicenseViewController.h"
#import "ScanDrivingLicenseModel.h"
#import "ScanDrivingLicenseTFCell.h"
#import "ScanDrivingLicenseDateCell.h"
#import "ScanDrivingLicenseBtnCell.h"
#import "PopTimePickerView.h"
#import "CarInfoViewController.h"
#import "IDCardCameraViewController.h"
#import "ScanDrivingLicenseVinCell.h"
#import "KLCPopup.h"

@interface ScanDrivingLicenseViewController ()
<
UITableViewDelegate,
UITableViewDataSource
,QMUITextFieldDelegate>
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UIImageView *licenseIv;
@property (nonatomic, strong) UIView *paddingLine;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) PopTimePickerView *timePickerView;
@property (nonatomic, strong) ScanDrivingLicenseModel *model;

@property(nonatomic,strong)QMUITextField *vINTextField;
///注册时间
@property (nonatomic, strong) NSDate *registerDate;
///发证时间
@property (nonatomic, strong) NSDate *licensingDate;

@property (nonatomic, assign) CGFloat btnMinWidth;
@property (nonatomic, assign) CGFloat btnMaxWidth;

@property (nonatomic, assign) BOOL isCameraVCBack;

@end

@implementation ScanDrivingLicenseViewController
static NSString *const ScanDrivingLicenseTFCellIdf = @"ScanDrivingLicenseTFCell";
static NSString *const ScanDrivingLicenseDateCellIdf = @"ScanDrivingLicenseDateCell";
static NSString *const ScanDrivingLicenseBtnCellIdf = @"ScanDrivingLicenseBtnCell";
static NSString *const ScanDrivingLicenseVinCellIdf = @"ScanDrivingLicenseVinCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    self.title = @"扫描行驶证";
    self.isCameraVCBack = NO;
    [self setTopViewWithTitle:@"扫描行驶证" withBackButton:YES];

    
    _btnMinWidth = (kScreenWidth - 20 - 29) * 0.5;
    _btnMaxWidth = kScreenWidth - 20;
    
    [self setupViews];
    [self requestDatas];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isCameraVCBack) {
        self.isCameraVCBack = NO;
        return;
    }
    
}

- (void)setupViews
{
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47 + 11 + 11);
        make.bottom.mas_equalTo(0);
    }];
    
    _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_scanBtn];
    [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(11);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(_btnMinWidth);
        make.height.mas_equalTo(47);
    }];
    [_scanBtn setTitle:@"重新扫描" forState:UIControlStateNormal];
    [_scanBtn setTitleColor:[UIColor colorWithHexString:@"4A90E2"] forState:UIControlStateNormal];
    [_scanBtn setImage:[[UIImage imageNamed:@"car_info_sacn_btn_nor"] imageByResizeToSize:CGSizeMake(19, 19) contentMode:UIViewContentModeScaleAspectFit] forState:UIControlStateNormal];
    _scanBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_scanBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    _scanBtn.layer.cornerRadius = 4;
    _scanBtn.layer.masksToBounds = YES;
    _scanBtn.layer.borderWidth = CGFloatFromPixel(1);
    _scanBtn.layer.borderColor = [UIColor colorWithHexString:@"4A90E2"].CGColor;
    [_scanBtn addTarget:self action:@selector(clickScanButton:) forControlEvents:UIControlEventTouchUpInside];
    _scanBtn.hidden = YES;
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scanBtn.mas_top);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(_btnMaxWidth);
        make.height.mas_equalTo(47);
    }];
    [_commitBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    _tableView.tableHeaderView = [self tableViewHeaderView];
    [_tableView registerClass:[ScanDrivingLicenseTFCell class] forCellReuseIdentifier:ScanDrivingLicenseTFCellIdf];
    [_tableView registerClass:[ScanDrivingLicenseBtnCell class] forCellReuseIdentifier:ScanDrivingLicenseBtnCellIdf];
    [_tableView registerClass:[ScanDrivingLicenseDateCell class] forCellReuseIdentifier:ScanDrivingLicenseDateCellIdf];
    [_tableView registerClass:[ScanDrivingLicenseVinCell class] forCellReuseIdentifier:ScanDrivingLicenseVinCellIdf];
}

- (UIView *)tableViewHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.size = CGSizeMake(kScreenWidth, 216);
    headerView.backgroundColor = [UIColor whiteColor];
    
    _chooseBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(89, 89));
            make.top.mas_equalTo(40);
            make.centerX.mas_equalTo(btn.superview);
        }];
        
        UIImageView *iv = [[UIImageView alloc] init];
        [btn addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(btn);
            make.size.mas_equalTo(CGSizeMake(89, 59));
        }];
        iv.image = [UIImage imageNamed:@"car_info_choose_img"];
        
        UILabel *lb = [[UILabel alloc] init];
        [btn addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(lb.superview);
            make.top.mas_equalTo(iv.mas_bottom).mas_offset(5);
        }];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor colorWithHexString:@"858488"];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.text = @"点击扫描行驶证";
        
        [btn addTarget:self action:@selector(clickChooseButton:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _licenseIv = ({
        UIImageView *iv = [[UIImageView alloc] init];
        [headerView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 40, 10, 40));
        }];
        iv;
    });
    
    _paddingLine = ({
        UIView *vi = [[UIView alloc] init];
        [headerView addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        vi.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        vi;
    });
    
    return headerView;
}

- (void)requestDatas
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_ordercode forKey:@"ordercode"];
    
    [NetWorkManager requestWithParameters:param.copy withUrl:@"order/new_order/get_license_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            ScanDrivingLicenseDataModel *model = [ScanDrivingLicenseDataModel parseJSON:data];
            self.model.model = model;
            self.model.oldCarvin = model.carvin;
            [self.tableView reloadData];
            [self updateHeaderView];
        }
        
    } failure:^(id error) {
    
    }];
}

- (void)updateHeaderView
{
    if (_model.model.isLocalImage) {
        UIImage *image = [UIImage imageWithContentsOfFile:_model.model.imagesLocal];
        _licenseIv.image = image;
        if ([_model.model.imagesLocal isEmptyOrWhitespace]) {
            _licenseIv.hidden = YES;
            _chooseBtn.hidden = NO;
        }
        else {
            _licenseIv.hidden = NO;
            _chooseBtn.hidden = YES;
        }
    }
    else {
        [_licenseIv setImageWithURL:[NSURL URLWithString:_model.model.images] options:YYWebImageOptionSetImageWithFadeAnimation];
        if ([_model.model.images isEmptyOrWhitespace]) {
            _licenseIv.hidden = YES;
            _chooseBtn.hidden = NO;
        }
        else {
            _licenseIv.hidden = NO;
            _chooseBtn.hidden = YES;
        }
    }
    
//    if ([_model.model.images isEmptyOrWhitespace]) {
//        _licenseIv.hidden = YES;
//        _chooseBtn.hidden = NO;
//        if (_model.model.isLocalImage) {
//            UIImage *image = [UIImage imageWithContentsOfFile:_model.model.imagesLocal];
//            _licenseIv.image = image;
//        }else{
//            [_licenseIv setImageWithURL:[NSURL URLWithString:_model.model.images] options:YYWebImageOptionSetImageWithFadeAnimation];
//        }
//    }
//    else {
//        _licenseIv.hidden = NO;
//        _chooseBtn.hidden = YES;
//        if (_model.model.isLocalImage) {
//            UIImage *image = [UIImage imageWithContentsOfFile:_model.model.imagesLocal];
//            _licenseIv.image = image;
//        }else{
//            [_licenseIv setImageWithURL:[NSURL URLWithString:_model.model.images] options:YYWebImageOptionSetImageWithFadeAnimation];
//        }
//    }
    
    [self updateButtonView];
}

- (void)updateButtonView
{
    if (LC_isStrEmpty(_model.model.images)) {
        _scanBtn.hidden = YES;
        [_commitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_btnMaxWidth);
        }];
    } else {
        _scanBtn.hidden = NO;
        [_commitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_btnMinWidth);
        }];
    }
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 54;
    }
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    @weakify(self)
    switch (indexPath.row) {
        case 0:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseTFCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseTFCell *)cell).titleLb.text = @"车牌号：";
            ((ScanDrivingLicenseTFCell *)cell).titleLb.textColor = [UIColor colorWithHexString:@"666666"];
            ((ScanDrivingLicenseTFCell *)cell).textField.text = _model.model.car_number;
            ((ScanDrivingLicenseTFCell *)cell).textField.maximumTextLength = 8;
            ((ScanDrivingLicenseTFCell *)cell).isHiddenLine = NO;
            ((ScanDrivingLicenseTFCell *)cell).textFieldTextChangeBlock = ^(NSString *text) {
                weak_self.model.model.car_number = text;
            };

            self.chePaiTextField = ((ScanDrivingLicenseTFCell *)cell).textField;
        } break;
        case 1:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseTFCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseTFCell *)cell).titleLb.text = @"所有人：";
            ((ScanDrivingLicenseTFCell *)cell).titleLb.textColor = [UIColor colorWithHexString:@"666666"];
            ((ScanDrivingLicenseTFCell *)cell).textField.text = _model.model.owner;
            ((ScanDrivingLicenseTFCell *)cell).textField.maximumTextLength = NSUIntegerMax;
            ((ScanDrivingLicenseTFCell *)cell).isHiddenLine = NO;
            ((ScanDrivingLicenseTFCell *)cell).textFieldTextChangeBlock = ^(NSString *text) {
                weak_self.model.model.owner = text;
            };

        } break;
        case 2:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseVinCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseVinCell *)cell).titleLb.text = @"*车辆识别代码：";
            ((ScanDrivingLicenseVinCell *)cell).titleLb.textColor = [UIColor colorWithHexString:@"ff383d"];
            ((ScanDrivingLicenseVinCell *)cell).textField.text = _model.model.carvin;
            ((ScanDrivingLicenseVinCell *)cell).textField.maximumTextLength = 17;
            ((ScanDrivingLicenseVinCell *)cell).textField.delegate = self;
            self.vINTextField = ((ScanDrivingLicenseVinCell *)cell).textField;
            ((ScanDrivingLicenseVinCell *)cell).textField.keyboardType = UIKeyboardTypeASCIICapable;
            ((ScanDrivingLicenseVinCell *)cell).isHiddenLine = NO;
            ((ScanDrivingLicenseVinCell *)cell).textFieldTextChangeBlock = ^(NSString *text) {
                weak_self.model.model.carvin = text;
                if (text.length > 17) {
                    [self showTipViewWithMessage:@"车牌识别代码（VIN）超过17位\n请重新输入"];
                }else if (text.length < 17){
                    [self showTipViewWithMessage:@"车牌识别代码（VIN）未满17位\n请重新输入"];
                }
            };
            
        } break;
        case 3:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseTFCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseTFCell *)cell).titleLb.text = @"发动机号：";
            ((ScanDrivingLicenseTFCell *)cell).titleLb.textColor = [UIColor colorWithHexString:@"666666"];
            ((ScanDrivingLicenseTFCell *)cell).textField.text = _model.model.engine_number;
            ((ScanDrivingLicenseTFCell *)cell).textField.maximumTextLength = 17;
            ((ScanDrivingLicenseTFCell *)cell).isHiddenLine = NO;
            ((ScanDrivingLicenseTFCell *)cell).textFieldTextChangeBlock = ^(NSString *text) {
                weak_self.model.model.engine_number = text;
            };
            
        } break;
        case 4:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseTFCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseTFCell *)cell).titleLb.text = @"品牌型号：";
            ((ScanDrivingLicenseTFCell *)cell).titleLb.textColor = [UIColor colorWithHexString:@"666666"];
            ((ScanDrivingLicenseTFCell *)cell).textField.text = _model.model.model;
            ((ScanDrivingLicenseTFCell *)cell).textField.maximumTextLength = NSUIntegerMax;
            ((ScanDrivingLicenseTFCell *)cell).isHiddenLine = NO;
            ((ScanDrivingLicenseTFCell *)cell).textFieldTextChangeBlock = ^(NSString *text) {
                weak_self.model.model.model = text;
            };
            
        } break;
        case 5:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseBtnCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseBtnCell *)cell).titleLb.text = @"使用性质：";
            ((ScanDrivingLicenseBtnCell *)cell).isOperate = [_model.model.use_character isEqualToString:@"营运"];
            _model.model.use_character = [_model.model.use_character isEqualToString:@"营运"] ? @"非营运" : @"非营运";
            ((ScanDrivingLicenseBtnCell *)cell).valueChangeBlock = ^(NSString *operate) {
                weak_self.model.model.use_character = operate;
            };

        } break;
        case 6:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseDateCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseDateCell *)cell).titleLb.text = @"注册日期：";
            ((ScanDrivingLicenseDateCell *)cell).contentLb.text = _model.model.register_date;
            
        } break;
        case 7:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseDateCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseDateCell *)cell).titleLb.text = @"发证日期：";
            ((ScanDrivingLicenseDateCell *)cell).contentLb.text = _model.model.issue_date;
        } break;
        case 8:{
            cell = [tableView dequeueReusableCellWithIdentifier:ScanDrivingLicenseTFCellIdf forIndexPath:indexPath];
            ((ScanDrivingLicenseTFCell *)cell).titleLb.text = @"地址：";
            ((ScanDrivingLicenseTFCell *)cell).titleLb.textColor = [UIColor colorWithHexString:@"666666"];
            ((ScanDrivingLicenseTFCell *)cell).textField.text = _model.model.address;
            ((ScanDrivingLicenseTFCell *)cell).textField.maximumTextLength = NSUIntegerMax;
            ((ScanDrivingLicenseTFCell *)cell).isHiddenLine = YES;
            ((ScanDrivingLicenseTFCell *)cell).textFieldTextChangeBlock = ^(NSString *text) {
                weak_self.model.model.address = text;
            };
            
        } break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 6:{
            [self showTimePickerViewFromDate:_registerDate indexPath:indexPath];
        } break;
        case 7:{
            [self showTimePickerViewFromDate:_licensingDate indexPath:indexPath];
        } break;
        default:
            break;
    }
}

#pragma mark -
-(ScanDrivingView *)scanDrivingView
{
    if (!_scanDrivingView) {
        _scanDrivingView = [[ScanDrivingView alloc]init];
        kWeakSelf(weakSelf)
        _scanDrivingView.leftBtnChcickBlock = ^(NSString *leftStr) {
            weakSelf.model.model.car_number = leftStr;
            [weakSelf.tableView reloadData];
            [weakSelf updateHeaderView];
        };
        _scanDrivingView.rightBtnChcickBlock = ^(NSString *rightStr) {
            weakSelf.model.model.car_number = rightStr;
            [weakSelf.tableView reloadData];
            [weakSelf updateHeaderView];
        };
        _scanDrivingView.shoDongChickBlock = ^(NSString *shoDongStr) {
            [weakSelf.chePaiTextField becomeFirstResponder];
        };
        [self.view addSubview:_scanDrivingView];
    }
    return _scanDrivingView;
}

#pragma mark - Action
/// 点击扫描
- (void)clickChooseButton:(UIButton *)btn
{
    [self.view endEditing:YES];
    //IDCardCameraViewController适配了iPad、iPhone，支持程序旋转
    IDCardCameraViewController *cameraVC = [[IDCardCameraViewController alloc] init];
    cameraVC.recogType = 6;
    cameraVC.typeName = @"中国行驶证";
    cameraVC.recogOrientation = 0;
    kWeakSelf(weakSelf)
    cameraVC.saoMiaoXSZHuiBlcok = ^(XinShiZheng_carsModel *model) {
        NSString *puanDuanStr = [NSString stringWithFormat:@"%@",weakSelf.model.model.car_number];
        
        [weakSelf.model.model buildModelWithScanDrivingLicenseDataModel:model];
        
        [weakSelf.tableView reloadData];
        [weakSelf updateHeaderView];
        
        
        if (puanDuanStr.length>0) {
            if (![puanDuanStr isEqualToString:model.carno]) {
                [weakSelf.scanDrivingView displayViewWithChePai:puanDuanStr withChePai2:model.carno];
                return ;
            }
        }
        
        if (model.carvin.length != 17) {
            [weakSelf showTipViewWithMessage:@"车辆识别代码（VIN）不是17位\n请重新扫描或手动修改"];
        }
    };
//    [self.navigationController pushViewController:cameraVC animated:YES];
    [self presentViewController:cameraVC animated:YES completion:^{
        self.isCameraVCBack = NO;
    }];
}
/// 确定
- (void)clickCommitButton:(UIButton *)btn
{
    [self.view endEditing:YES];
    if (_model.model.carvin.length > 17) {
        [self showTipViewWithMessage:@"车牌识别代码（VIN）超过17位\n请重新输入"];
        return;
    }else if (_model.model.carvin.length < 17){
        [self showTipViewWithMessage:@"车牌识别代码（VIN）未满17位\n请重新输入"];
        return;
    }
    
    if (_model.model.car_number.length < 7 || _model.model.car_number.length > 8) {
        [self showTipViewWithMessage:@"请输入正确的车牌号"];
        return;
    }
    
//    if ([_model.model.car_number isEmptyOrWhitespace]) {
//        [self showMessageWindowWithTitle:@"请输入车牌号" point:self.view.center delay:1];
//        return;
//    }
    
    CarInfoViewController *vc = [[CarInfoViewController alloc] init];
    vc.ordercode = _ordercode;
    vc.isNeedRequestVinData = ![_model.model.carvin isEqualToString:_model.oldCarvin];
    vc.vin = _model.model.carvin;
    vc.licenseDataModel = _model.model;
    [self.navigationController pushViewController:vc animated:YES];
}
/// 重新扫描
- (void)clickScanButton:(UIButton *)btn
{
    [self.view endEditing:YES];
    [self clickChooseButton:nil];
    
}

#pragma mark -
- (void)showTimePickerViewFromDate:(NSDate *)date indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7) {
        if (!_registerDate) {
            [self showTipViewWithMessage:@"请先选择行驶证注册日期"];
            return;
        }
        self.timePickerView.datePicker.minimumDate = self.registerDate;
    }
    @weakify(self)
    [self.timePickerView showWithDate:date];
    self.timePickerView.didSecectedDataCallBack = ^(NSDate *date) {
        @strongify(self)
        switch (indexPath.row) {
            case 6:
                self.registerDate = date;
                self.model.model.register_date = [NSDate stringFromDate:self.registerDate withFormat:@"yyyy-MM-dd"];
                break;
            case 7:
                self.licensingDate = date;
                self.model.model.issue_date = [NSDate stringFromDate:self.licensingDate withFormat:@"yyyy-MM-dd"];
                break;
            default:
                break;
        }
        [self.tableView reloadData];
    };
}

- (PopTimePickerView *)timePickerView
{
    if (!_timePickerView) {
        _timePickerView = [[PopTimePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 40,  260)];
        _timePickerView.datePicker.maximumDate = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:-50];//设置最小时间为：当前时间前推50年
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        _timePickerView.datePicker.minimumDate = minDate;
    }
    return _timePickerView;
}

- (ScanDrivingLicenseModel *)model
{
    if (!_model) {
        _model = [[ScanDrivingLicenseModel alloc] init];
    }
    return _model;
}

#pragma mark -
- (void)showTipViewWithMessage:(NSString *)message
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-60, 160)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 6;
    backView.layer.masksToBounds = YES;
    
    KLCPopup *popup = [KLCPopup popupWithContentView:backView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
    
    UIButton *queDingBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [backView addSubview:bt];
        [bt setTitle:@"确定" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
        [bt setTitleColor:kBOSSZhuTiColor forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            
            [popup dismiss:YES];
//            [self.backView removeAllSubviews];
//            [self.backView removeFromSuperview];
        }];
        bt;
    });
    UILabel *titleLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [backView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:18];
        lb.textColor = UIColorHex(#666666);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.numberOfLines = 0;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(9);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(queDingBT.mas_top).mas_equalTo(0);
        }];
        lb;
    });
    UIView *lineVeiw = ({
        UIView *v = [[UIView alloc]init];
        [titleLB addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        v;
    });
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
    titleLB.attributedText = attributedString;
    titleLB.textAlignment = NSTextAlignmentCenter;
    
    [popup show];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.vINTextField) {
        if (string.length == 0 ){return YES;}
        char commitChar = [string characterAtIndex:0];
        if (commitChar > 96 && commitChar < 123){
            NSString * uppercaseString = string.uppercaseString;
            NSString * str1 = [textField.text substringToIndex:range.location];
            NSString * str2 = [textField.text substringFromIndex:range.location];
            textField.text = [NSString stringWithFormat:@"%@%@%@",str1,uppercaseString,str2].uppercaseString;
            return NO;
        }else{
            NSCharacterSet *cs;
            cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
            BOOL canChange = [string isEqualToString:filtered];
            return canChange;
        }
    }
    return YES;
    
}
@end
