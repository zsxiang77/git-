//
//  WritePersonalViewController.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "WritePersonalViewController.h"
#import "UIButton+ImageTitleStyle.h"
#import "DWSegmentedControl.h"
#import "WritePersonalModel.h"
#import "ScanDrivingLicenseViewController.h"
#import "WritePersonalUnitInfoView.h"
#import "WritePersonalPersonInfoView.h"
#import "NewVehicleVC.h"
#import "ModelCarViewController.h"
#import "SaoMiaoSFZViewController.h"
#import "PopTimePickerView.h"

@interface WritePersonalViewController () <DWSegmentedControlDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIView *titleContentView;
@property (nonatomic, strong) WritePersonalPersonInfoView *personView;
@property (nonatomic, strong) WritePersonalUnitInfoView *unitView;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) DWSegmentedControl *segmentedControl;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) WritePersonalModel *model;

@property(nonatomic,strong)UIScrollView *mianScrollView;
@end

@implementation WritePersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#FAFAFA);
    [self setTopViewWithTitle:@"客户信息" withBackButton:YES];
    
    [self setupViews];
    [self setupInfoView];
    [self setupButtomView];
    
    [self configurAction];
    
    [_segmentedControl setSelectedRow:0];
    
    
    
    if (self.shiFouXiMei == YES) {
        UIButton *ziDingYiBt = [[UIButton alloc]init];
        ziDingYiBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [ziDingYiBt setTitle:@"匿名下单" forState:(UIControlStateNormal)];
        [ziDingYiBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        [ziDingYiBt addTarget:self action:@selector(niMingXiaDanChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [m_baseTopView addSubview:ziDingYiBt];
        [ziDingYiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
    }
    
    if (self.user_id.length>0) {
        [self requestData2];
    }else{
        if (self.ordercode.length>0) {
            [self requestData];
        }
    }
    
}

-(void)niMingXiaDanChick:(UIButton *)sender
{
    ModelCarViewController *vc = [[ModelCarViewController alloc]init];
    vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
    self.xiMeiZuiZhongModel.shiFoNiMing = YES;
    self.xiMeiZuiZhongModel.user_id = @"0";
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self postNetWorkOrder_user:phoneTextField.text WithName:nameTextField.text];
}

- (void)setupViews
{
    _titleContentView = ({
        UIView *vi = [[UIView alloc] init];
        [self.view addSubview:vi];
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(m_baseTopView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(48.5);
        }];
        vi;
    });
    
    _titleLb = ({
        UILabel *lb = [[UILabel alloc]init];
        [_titleContentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
        lb.textColor = kRGBColor(74,74 , 74);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [lb setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        lb.text = @"客户类型";
        lb;
    });
    
    _segmentedControl = ({
        DWSegmentedControl *sc = [[DWSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 85, 30)];
        sc.backgroundColor = [UIColor clearColor];
        sc.selectedViewColor = [UIColor colorWithHexString:@"4A90E2"];
        sc.normalLabelColor = [UIColor colorWithHexString:@"4a4a4a"];
        sc.delegate = self;
        sc.titles = @[@"个人",@"企业"];
        [_titleContentView addSubview:sc];
        [sc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(sc.superview);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(85, 30));
        }];
        sc;
    });
    if (self.shiFouQieHuan == NO) {
        UIView *gaiZhuView = [[UIView alloc]init];
        gaiZhuView.backgroundColor = self.view.backgroundColor;
        [_titleContentView addSubview:gaiZhuView];
        [gaiZhuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(gaiZhuView.superview);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(85, 30));
        }];
        [_titleContentView bringSubviewToFront:gaiZhuView];
    }
}

- (void)setupInfoView
{
    self.mianScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45.8+kNavBarHeight, kWindowW, kWindowH-(45.8+kNavBarHeight)-60)];
    [self.view addSubview:self.mianScrollView];
    self.mianScrollView.contentSize = CGSizeMake(kWindowW, 45 * 7 + 10 + 45 * 7+48);
    
    _personView = ({
        WritePersonalPersonInfoView *vi = [[WritePersonalPersonInfoView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 45 * 7 + 10 + 45 * 7+48)];
        [self.mianScrollView addSubview:vi];
        vi;
    });
    kWeakSelf(weakSelf)
    _personView.birth_tfChickBack = ^{
        NSDate *date = [NSDate new];
        [weakSelf showTimePickerViewFromDate:date shiFouSende:NO];
    };
    _personView.sendInfoView.birth_tfChickBack = ^{
        NSDate *date = [NSDate new];
        [weakSelf showTimePickerViewFromDate:date shiFouSende:YES];
    };
    _personView.sex_tfChickBack = ^{
        weakSelf.shiFouKeHu = YES;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        [actionSheet addButtonWithTitle:@"男"];
        [actionSheet addButtonWithTitle:@"女"];
        [actionSheet addButtonWithTitle:@"取消"];
        actionSheet.cancelButtonIndex = 2;
        actionSheet.delegate = weakSelf;
        [actionSheet showInView:weakSelf.view];
    };
    _personView.sendInfoView.sex_tfChickBack = ^{
        weakSelf.shiFouKeHu = NO;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        [actionSheet addButtonWithTitle:@"男"];
        [actionSheet addButtonWithTitle:@"女"];
        [actionSheet addButtonWithTitle:@"取消"];
        actionSheet.cancelButtonIndex = 2;
        actionSheet.delegate = weakSelf;
        [actionSheet showInView:weakSelf.view];
    };
    
    
    _unitView = ({
        WritePersonalUnitInfoView *vi = [[WritePersonalUnitInfoView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 45 * 7 + 10 + 45 * 7+48)];
        [self.mianScrollView addSubview:vi];
        vi;
    });
    _unitView.sendInfoView.birth_tfChickBack = ^{
        NSDate *date = [NSDate new];
        [weakSelf showTimePickerViewFromDate:date shiFouSende:YES];
    };
    _unitView.sendInfoView.sex_tfChickBack = ^{
        weakSelf.shiFouKeHu = NO;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        [actionSheet addButtonWithTitle:@"男"];
        [actionSheet addButtonWithTitle:@"女"];
        [actionSheet addButtonWithTitle:@"取消"];
        actionSheet.cancelButtonIndex = 2;
        actionSheet.delegate = weakSelf;
        [actionSheet showInView:weakSelf.view];
    };
    
    _personView.viewController = self;
    _unitView.viewController = self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    if (buttonIndex == 0) {
        if (self.shiFouKeHu) {
            self.model.model.sex = @"男";
        }else{
            self.model.model.send_sex = @"男";
        }
        
        [self updateUI];
    }else if (buttonIndex == 1) {
        if (self.shiFouKeHu) {
            self.model.model.sex = @"女";
        }else{
            self.model.model.send_sex = @"女";
        }
        [self updateUI];
    }
}

#pragma mark -
- (void)showTimePickerViewFromDate:(NSDate *)date shiFouSende:(BOOL)sende
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    date = [NSDate date];
    @weakify(self)
    [self.timePickerView showWithDate:date];
    self.timePickerView.didSecectedDataCallBack = ^(NSDate *date) {
        @strongify(self)
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *currentTimeString = [formatter stringFromDate:date];
        
        if (sende == YES) {
            self.model.model.send_birth = currentTimeString;
        }else{
            self.model.model.birthday = currentTimeString;
        }
        
        [self updateUI];
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

- (void)setupButtomView
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
    [_commitBtn setTitle:@"确  定" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)requestData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:_ordercode forKey:@"ordercode"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:param withUrl:@"order/new_order/get_customer_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        WritePersonalDataModel *dataModel = [WritePersonalDataModel parseJSON:data];
        weakSelf.model.model = dataModel;
        [weakSelf updateUI];
    } failure:^(id error) {
        
    }];
}

- (void)requestData2
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:self.user_id forKey:@"user_id"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:param withUrl:@"order/order_query/user_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        WritePersonalDataModel *dataModel = [WritePersonalDataModel parseJSON:data];
        weakSelf.model.model = dataModel;
        [weakSelf updateUI];
    } failure:^(id error) {
        
    }];
}

- (void)requestUserInfoWithMobile:(NSString *)mobile
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:mobile forKey:@"mobile"];
    
    NSString *modelUser_id = @"0";
    if (self.model.model) {
        if (self.model.model.user_id.length>0) {
            modelUser_id = [NSString stringWithFormat:@"%@",self.model.model.user_id];
        }
        
    }
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:param withUrl:@"order/order_query/mobile" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        if (data.count < 1){
            return;
        }
        WritePersonalDataModel *dataModel = [WritePersonalDataModel parseJSON:data];
        weakSelf.model.model = dataModel;
        weakSelf.model.model.user_id = modelUser_id;
        [weakSelf updateUI];
    } failure:^(id error) {
        
    }];
}

- (void)requestSaveDataWithDataDic:(NSDictionary *)dataDic completion:(void(^)(void))completion
{
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:dataDic withUrl:@"order/new_order/add_new_user" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            [weakSelf showMessageWindowWithTitle:@"保存成功" point:self.view.center delay:1];
            if (weakSelf.user_id.length>0) {
                if (weakSelf.xiMeiZuiZhongModel) {
                    weakSelf.xiMeiZuiZhongModel.realname = weakSelf.model.model.store_alias;
                    weakSelf.xiMeiZuiZhongModel.mobile = weakSelf.model.model.mobile;
                }else{
                    weakSelf.zuiZhongModel.realname = weakSelf.model.model.store_alias;
                    weakSelf.zuiZhongModel.mobile = weakSelf.model.model.mobile;
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                !completion ?: completion();
            }
            
        }else{
            [weakSelf showAlertViewWithTitle:[responseObject objectForKey:@"msg"] Message:nil buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
}

- (void)updateUI {
    BOOL isUnit = [_model.model.is_unit isEqualToString:@"1"];
    _unitView.hidden = YES;
    _personView.hidden = YES;
    if (isUnit) {
        _unitView.hidden = NO;
        _unitView.unit_full_name = _model.model.unit_full_name;
        _unitView.store_alias = _model.model.store_alias;
        _unitView.mobile = _model.model.mobile;
        
        _unitView.sendInfoView.send_name = _model.model.send_name;
        _unitView.sendInfoView.send_mobile = _model.model.send_mobile;
        _unitView.sendInfoView.send_id_card = _model.model.send_id_card;
        
        _unitView.sendInfoView.send_sex = _model.model.send_sex;
        _unitView.sendInfoView.send_nation = _model.model.send_nation;
        _unitView.sendInfoView.send_birth = _model.model.send_birth;
        _unitView.sendInfoView.send_addr = _model.model.send_addr;
    }
    else {
        _personView.hidden = NO;
        _personView.mobile = _model.model.mobile;
        _personView.store_alias = _model.model.store_alias;
        _personView.id_car = _model.model.id_card;
        _personView.sendInfoView.send_id_card = _model.model.send_id_card;
        
        _personView.sex = _model.model.sex;
        _personView.nation = _model.model.nation;
        _personView.birth = _model.model.birthday;
        _personView.addr = _model.model.address;

        
        _personView.sendInfoView.send_name = _model.model.send_name;
        _personView.sendInfoView.send_mobile = _model.model.send_mobile;
        _personView.sendInfoView.send_sex = _model.model.send_sex;
        _personView.sendInfoView.send_nation = _model.model.send_nation;
        _personView.sendInfoView.send_birth = _model.model.send_birth;
        _personView.sendInfoView.send_addr = _model.model.send_addr;
    }
    
    [_segmentedControl setSelectedRow:isUnit ? 1 : 0];
}

- (void)syncSendUserInfo
{
    _personView.sendInfoView.send_mobile = _personView.mobile;
    _personView.sendInfoView.send_name = _personView.store_alias;
    _personView.sendInfoView.send_id_card = _personView.id_car;
    
    _personView.sendInfoView.send_sex = _personView.sex;
    _personView.sendInfoView.send_nation = _personView.nation;
    _personView.sendInfoView.send_birth = _personView.birth;
    _personView.sendInfoView.send_addr = _personView.addr;
}

- (void)syncUnitInfoToSendUserInfo
{
    _unitView.sendInfoView.send_mobile = _unitView.mobile;
    _unitView.sendInfoView.send_name = _unitView.store_alias;
}

- (void)dw_segmentedControl:(DWSegmentedControl *)control didSeletRow:(NSInteger)row
{
    BOOL isUnit = row == 1;
    _personView.hidden = isUnit;
    _unitView.hidden = !isUnit;
    
    _model.model.is_unit = @(row).stringValue;
    
//    [self updateUI];
}

- (void)saveDataToServerCompletion:(void(^)(void))completon
{
    BOOL isUnit = [_model.model.is_unit isEqualToString:@"1"];
    
    if (isUnit) {
        _model.model.unit_full_name = _unitView.unit_full_name;
        _model.model.store_alias = _unitView.store_alias;
        _model.model.mobile = _unitView.mobile;
        
        _model.model.send_name = _unitView.sendInfoView.send_name;
        _model.model.send_mobile = _unitView.sendInfoView.send_mobile;
        _model.model.send_id_card = _unitView.sendInfoView.send_id_card;
        
        _model.model.send_sex = _unitView.sendInfoView.send_sex;
        _model.model.send_nation = _unitView.sendInfoView.send_nation;
        _model.model.send_addr = _unitView.sendInfoView.send_addr;
        _model.model.send_birth = _unitView.sendInfoView.send_birth;
        
        if ([_model.model.unit_full_name isEmptyOrWhitespace]) {
            [self showMessageWindowWithTitle:@"请输入企业简称" point:self.view.center delay:1];
            return;
        }
        
        if ([_model.model.store_alias isEmptyOrWhitespace]) {
            [self showMessageWindowWithTitle:@"请输入企业全称" point:self.view.center delay:1];
            return;
        }
        
        if (_model.model.mobile.length < 6 ||
            _model.model.mobile.length > 12) {
            [self showMessageWindowWithTitle:@"请检查企业电话是否正确" point:self.view.center delay:1];
            return;
        }
    }
    else {
        _model.model.mobile = _personView.mobile;
        _model.model.store_alias = _personView.store_alias;
        _model.model.id_card = _personView.id_car;
        _model.model.sex = _personView.sex;
        _model.model.address = _personView.addr;
        _model.model.nation = _personView.nation;
        _model.model.birthday = _personView.birth;
        
        _model.model.send_name = _personView.sendInfoView.send_name;
        _model.model.send_mobile = _personView.sendInfoView.send_mobile;
        _model.model.send_id_card = _personView.sendInfoView.send_id_card;
        
        if ([_model.model.mobile isEmptyOrWhitespace]) {
            [self showMessageWindowWithTitle:@"请输入手机号" point:self.view.center delay:1];
            return;
        }
        
        if (!isUnit && [_model.model.store_alias isEmptyOrWhitespace]) {
            [self showMessageWindowWithTitle:@"请输入客户姓名" point:self.view.center delay:1];
            return;
        }
    }
    
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//    if (self.xiMeiZuiZhongModel) {
//        [dataDic setValue:self.xiMeiZuiZhongModel.user_id forKey:@"user_id"];
//    }else if(self.zuiZhongModel) {
//        [dataDic setValue:self.xiMeiZuiZhongModel.user_id forKey:@"user_id"];
//    }
    [dataDic setValue:_ordercode forKey:@"ordercode"];
    [dataDic setValue:_model.model.is_unit forKey:@"is_unit"];
    [dataDic setValue:_model.model.send_name forKey:@"send_name"];
    [dataDic setValue:_model.model.send_mobile forKey:@"send_mobile"];
    [dataDic setValue:_model.model.send_id_card forKey:@"send_id_card"];
    
    [dataDic setValue:_model.model.send_addr forKey:@"send_addr"];
    [dataDic setValue:_model.model.send_birth forKey:@"send_birth"];
    [dataDic setValue:_model.model.send_nation forKey:@"send_nation"];
    [dataDic setValue:_model.model.send_sex forKey:@"send_sex"];
    
    if (isUnit) {
        [dataDic setValue:_model.model.unit_full_name forKey:@"unit_full_name"];
        [dataDic setValue:_model.model.store_alias forKey:@"store_alias"];
        [dataDic setValue:_model.model.mobile forKey:@"mobile"];
    }
    else {
        [dataDic setValue:_model.model.mobile forKey:@"mobile"];
        [dataDic setValue:_model.model.store_alias forKey:@"store_alias"];
        [dataDic setValue:_model.model.id_card forKey:@"id_card"];
        [dataDic setValue:_model.model.address forKey:@"address"];
        [dataDic setValue:_model.model.birthday forKey:@"birthday"];
        [dataDic setValue:_model.model.nation forKey:@"nation"];
        [dataDic setValue:_model.model.sex forKey:@"sex"];
    }
    if (self.user_id.length>0) {
        [dataDic setValue:self.user_id forKey:@"user_id"];
    }
    
    [self requestSaveDataWithDataDic:dataDic.copy completion:completon];
}

-(void)xiMeiHuoQuUserId
{
    BOOL isUnit = [_model.model.is_unit isEqualToString:@"1"];
    if(!_model){
        _model = [[WritePersonalModel alloc]init];
    }
    
    if (isUnit) {
        _model.model.unit_full_name = _unitView.unit_full_name;
        _model.model.store_alias = _unitView.store_alias;
        _model.model.mobile = _unitView.mobile;
        
        _model.model.send_name = _unitView.sendInfoView.send_name;
        _model.model.send_mobile = _unitView.sendInfoView.send_mobile;
        _model.model.send_id_card = _unitView.sendInfoView.send_id_card;
        
        _model.model.send_sex = _unitView.sendInfoView.send_sex;
        _model.model.send_nation = _unitView.sendInfoView.send_nation;
        _model.model.send_addr = _unitView.sendInfoView.send_addr;
        _model.model.send_birth = _unitView.sendInfoView.send_birth;
        
        
        if ([_model.model.unit_full_name isEmptyOrWhitespace]||!_model.model.unit_full_name) {
            [self showMessageWindowWithTitle:@"请输入企业简称" point:self.view.center delay:1];
            return;
        }
        
        if ([_model.model.store_alias isEmptyOrWhitespace]||!_model.model.store_alias) {
            [self showMessageWindowWithTitle:@"请输入企业全称" point:self.view.center delay:1];
            return;
        }
        
        if (_model.model.mobile.length < 6 ||
            _model.model.mobile.length > 12  ||!_model.model.mobile) {
            [self showMessageWindowWithTitle:@"请检查企业电话是否正确" point:self.view.center delay:1];
            return;
        }
    }
    else {
        _model.model.mobile = _personView.mobile;
        _model.model.store_alias = _personView.store_alias;
        _model.model.id_card = _personView.id_car;
        _model.model.sex = _personView.sex;
        _model.model.address = _personView.addr;
        _model.model.nation = _personView.nation;
        _model.model.birthday = _personView.birth;
        
        _model.model.send_name = _personView.sendInfoView.send_name;
        _model.model.send_mobile = _personView.sendInfoView.send_mobile;
        _model.model.send_id_card = _personView.sendInfoView.send_id_card;
        _model.model.send_sex = _personView.sendInfoView.send_sex;
        _model.model.send_nation = _personView.sendInfoView.send_nation;
        _model.model.send_addr = _personView.sendInfoView.send_addr;
        _model.model.send_birth = _personView.sendInfoView.send_birth;
        
        
        
        if ([_model.model.mobile isEmptyOrWhitespace] || !_model.model.mobile) {
            [self showMessageWindowWithTitle:@"请输入手机号" point:self.view.center delay:1];
            return;
        }
        
        if (!isUnit && ([_model.model.store_alias isEmptyOrWhitespace] || !_model.model.store_alias)) {
            [self showMessageWindowWithTitle:@"请输入客户姓名" point:self.view.center delay:1];
            return;
        }
        
        if (_model.model.mobile.length < 6 ||
            _model.model.mobile.length > 12  ||!_model.model.mobile) {
            [self showMessageWindowWithTitle:@"请检查电话是否正确" point:self.view.center delay:1];
            return;
        }
    }
    
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:_ordercode forKey:@"ordercode"];
    
    [dataDic setValue:_model.model.is_unit forKey:@"is_unit"];
    [dataDic setValue:_model.model.send_name forKey:@"send_name"];
    [dataDic setValue:_model.model.send_mobile forKey:@"send_mobile"];
    [dataDic setValue:_model.model.send_id_card forKey:@"send_id_card"];
    [dataDic setValue:_model.model.send_addr forKey:@"send_addr"];
    [dataDic setValue:_model.model.send_birth forKey:@"send_birth"];
    [dataDic setValue:_model.model.send_nation forKey:@"send_nation"];
    [dataDic setValue:_model.model.send_sex forKey:@"send_sex"];
    
    [dataDic setValue:self.xiMeiZuiZhongModel.user_id forKey:@"user_id"];
    if (isUnit) {
        [dataDic setValue:_model.model.unit_full_name forKey:@"unit_full_name"];
        [dataDic setValue:_model.model.store_alias forKey:@"store_alias"];
        [dataDic setValue:_model.model.mobile forKey:@"mobile"];
    }
    else {
        [dataDic setValue:_model.model.mobile forKey:@"mobile"];
        [dataDic setValue:_model.model.store_alias forKey:@"store_alias"];
        [dataDic setValue:_model.model.id_card forKey:@"id_card"];
        [dataDic setValue:_model.model.address forKey:@"address"];
        [dataDic setValue:_model.model.birthday forKey:@"birthday"];
        [dataDic setValue:_model.model.nation forKey:@"nation"];
        [dataDic setValue:_model.model.sex forKey:@"sex"];
    }
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:dataDic withUrl:@"order/new_order/add_new_user" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        NSDictionary *dataDict = kParseData(responseObject);
        if (code == 200) {
            [weakSelf showMessageWindowWithTitle:@"保存成功" point:self.view.center delay:1];
            weakSelf.xiMeiZuiZhongModel.realname = weakSelf.model.model.store_alias;
            weakSelf.xiMeiZuiZhongModel.mobile = weakSelf.model.model.mobile;
            weakSelf.xiMeiZuiZhongModel.send_mobile = weakSelf.model.model.send_mobile;
            weakSelf.xiMeiZuiZhongModel.send_name = weakSelf.model.model.send_name;
            weakSelf.xiMeiZuiZhongModel.send_id_card = weakSelf.model.model.send_id_card;
            ModelCarViewController *vc = [[ModelCarViewController alloc]init];
            vc.xiMeiZuiZhongModel = weakSelf.xiMeiZuiZhongModel;
            weakSelf.xiMeiZuiZhongModel.shiFoNiMing = NO;
            weakSelf.xiMeiZuiZhongModel.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDict, @"user_id")];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
            [weakSelf showAlertViewWithTitle:[responseObject objectForKey:@"msg"] Message:nil buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
}
#pragma mark - 下一步
- (void)clickCommitButton:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    if (self.xiMeiZuiZhongModel && (self.user_id.length<=0||!self.user_id)) {
        [self xiMeiHuoQuUserId];
        return;
    }
    
    switch ([OrderInfoPushManager sharedOrderInfoPushManager].type) {
        case OrderInfoPushTypePerctInfo: {
            [self saveDataToServerCompletion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } break;
        case OrderInfoPushTypeBuildOrder: {
            [self saveDataToServerCompletion:^{
                ScanDrivingLicenseViewController *vc = [[ScanDrivingLicenseViewController alloc] init];
                vc.ordercode = _ordercode;
                [self.navigationController pushViewController:vc animated:YES];
            }];
        } break;
            
        default:
            break;
    }
}

/**
 *  监听属性值发生改变时回调
 */
- (void)personMobileChangeTextField:(UITextField *)textField
{
    if ([WritePersonalViewController LC_CheckTelNumber:textField.text]) {
//        [textField resignFirstResponder];
        [self requestUserInfoWithMobile:textField.text];
    }
}

#pragma mark - 扫描
- (void)configurAction
{
    @weakify(self)
             
     [_personView.mobile_tf.textField addTarget:self action:@selector(personMobileChangeTextField:) forControlEvents:UIControlEventEditingChanged];
    
    
    // 把个人信息同步到 送修人
    _personView.userInfoChangeCallBack = ^{
        @strongify(self)
        [self syncSendUserInfo];
    };
    
    _unitView.userInfoChangeCallBack = ^{
        @strongify(self)
        [self syncUnitInfoToSendUserInfo];
    };
    
    
    // 扫描个人信息
    _personView.scanIDCard = ^{
        @strongify(self)
        
        SaoMiaoSFZViewController *cameraVC = [[SaoMiaoSFZViewController alloc] init];
        cameraVC.recogType = 2;
        cameraVC.typeName = @"身份证";
        cameraVC.recogOrientation = 0;
        cameraVC.chuanSanGeZhiBlock = ^(NSString *store_alias, NSString *id_card, NSString *address, NSString *birthday, NSString *nation, NSString *sex) {
            self.model.model.store_alias = store_alias;
            self.model.model.id_card = id_card;
            
            self.model.model.address = address;
            self.model.model.nation = nation;
            self.model.model.sex = sex;
            self.model.model.birthday = birthday;
            
            [self.view endEditing:YES];
            [self updateUI];
        };
        
        [self presentViewController:cameraVC animated:YES completion:nil];

        
    };
    
    // 扫描个人 => 送修人信息
    _personView.sendInfoView.scanIDCard = ^{
        @strongify(self)
        
        SaoMiaoSFZViewController *cameraVC = [[SaoMiaoSFZViewController alloc] init];
        cameraVC.recogType = 2;
        cameraVC.typeName = @"身份证";
        cameraVC.recogOrientation = 0;
        cameraVC.chuanSanGeZhiBlock = ^(NSString *store_alias, NSString *id_card, NSString *address, NSString *birthday, NSString *nation, NSString *sex) {
            self.model.model.send_name = store_alias;
            self.model.model.send_id_card = id_card;
            
            self.model.model.send_addr = address;
            self.model.model.send_nation = nation;
            self.model.model.send_sex = sex;
            self.model.model.send_birth = birthday;
            
            [self.view endEditing:YES];
            [self updateUI];
        };
        [self presentViewController:cameraVC animated:YES completion:nil];
        
    };
    
    // 扫描企业 => 送修人信息
    _unitView.sendInfoView.scanIDCard = ^{
        @strongify(self)
        
        SaoMiaoSFZViewController *cameraVC = [[SaoMiaoSFZViewController alloc] init];
        cameraVC.recogType = 2;
        cameraVC.typeName = @"身份证";
        cameraVC.recogOrientation = 0;
        cameraVC.chuanSanGeZhiBlock = ^(NSString *store_alias, NSString *id_card, NSString *address, NSString *birthday, NSString *nation, NSString *sex) {
            self.model.model.send_name = store_alias;
            self.model.model.send_id_card = id_card;
            
            self.model.model.send_addr = address;
            self.model.model.send_nation = nation;
            self.model.model.send_sex = sex;
            self.model.model.send_birth = birthday;
            
            [self.view endEditing:YES];
            [self updateUI];
        };
        [self presentViewController:cameraVC animated:YES completion:nil];
    };
}

- (WritePersonalModel *)model
{
    if (!_model) {
        _model = [[WritePersonalModel alloc] init];
    }
    return _model;
}

#pragma mark - 座机号
+ (BOOL)isTelPhoneNumber:(NSString *)mobileNum{
    //验证输入的固话中带 "-"符号
    NSString * strNum = @"^(0\\d{2,3}-?\\d{7,8}$)";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    BOOL isPhene = [checktest evaluateWithObject:mobileNum];
    NSString * strNum1 = @"^(\\d{7,8}$)";
    NSPredicate *checktest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum1];
    BOOL isPhene1 = [checktest1 evaluateWithObject:mobileNum];
    if (isPhene || isPhene1) {
        return YES;
    }
    return NO;
}
#pragma 正则匹配手机号
+ (BOOL)LC_CheckTelNumber:(NSString *)telNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,183,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:telNumber] == YES)
        || ([regextestcm evaluateWithObject:telNumber] == YES)
        || ([regextestct evaluateWithObject:telNumber] == YES)
        || ([regextestcu evaluateWithObject:telNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
