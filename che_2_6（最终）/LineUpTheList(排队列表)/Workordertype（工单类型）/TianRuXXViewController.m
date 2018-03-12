//
//  TianRuXXViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TianRuXXViewController.h"
#import "DWSegmentedControl.h"
#import "TianRuXXCell.h"
#import "NumberKeyboard.h"
#import "kehuXuQiuViewController.h"
#import "WritePersonalViewController.h"
#import "ModelCarViewController.h"

@interface TianRuXXViewController ()<UITableViewDelegate,UITableViewDataSource,DWSegmentedControlDelegate,UITextFieldDelegate,NumKeyboardDelegate>
{
    NSString   *name;
    NSString   *mobile;
    NSString   *sende_name;
    NSString   *sende_mobile;
    NSString   *sende_id_card;
    NSString   *qiye_name;
    NSString   *qiye_jianCheng;
    NSString   *qiye_mobile;
    
    UITextField    *nameTextField;
    UITextField    *mobileTextField;
    UITextField    *sende_nameTextField;
    UITextField    *sende_mobileTextField;
    UITextField    *sende_id_cardTextField;
    UITextField    *qiye_nameTextField;
    UITextField    *qiye_jianChengTextField;
    UITextField    *qiye_mobileTextField;
}

@property(nonatomic,strong)UITableView *mainTabelView;

@property(nonatomic,strong)UIView *titleContentView;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)DWSegmentedControl *segmentedControl;
@property(nonatomic,assign)BOOL shiFouGeRen;

@end

@implementation TianRuXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shiFouGeRen = YES;
    [self setTopViewWithTitle:@"填入信息" withBackButton:YES];
    [self setupViews];
    
    name = @"";
    mobile = @"";
    sende_name = @"";
    sende_mobile = @"";
    sende_id_card = @"";
    qiye_name = @"";
    qiye_jianCheng = @"";
    qiye_mobile = @"";
    
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];
    [queDingBt.layer setCornerRadius:4];
    queDingBt.backgroundColor = kZhuTiColor;
    queDingBt.titleLabel.font = [UIFont systemFontOfSize:17];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:queDingBt];
    [queDingBt mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-13);
        make.height.mas_equalTo(47);
    }];
}
-(void)queDingBtChick:(UIButton *)sender
{
    if (self.shiFouWeiXiu == YES) {
        [self xiMeiHuoQuUserIdWithWeiXiu:YES];

    }else{
        [self xiMeiHuoQuUserIdWithWeiXiu:NO];
    }
}



-(void)xiMeiHuoQuUserIdWithWeiXiu:(BOOL)weiXiu
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    if (self.shiFouGeRen == YES) {
        [dataDic setValue:@"0" forKey:@"is_unit"];
    }else{
        [dataDic setValue:@"1" forKey:@"is_unit"];
    }
    
    [dataDic setValue:sende_name forKey:@"send_name"];
    [dataDic setValue:sende_mobile forKey:@"send_mobile"];
    [dataDic setValue:sende_id_card forKey:@"send_id_card"];
    
    if (self.shiFouGeRen == NO) {

        if (qiye_name.length<=0) {
            [self showMessageWindowWithTitle:@"请输入企业全称" point:self.view.center delay:1];
            return;
        }
        if (qiye_jianCheng.length<=0) {
            [self showMessageWindowWithTitle:@"请输入企业简称" point:self.view.center delay:1];
            return;
        }
        
        
        
        if (qiye_mobile.length < 6 ||
            qiye_mobile.length > 12) {
            [self showMessageWindowWithTitle:@"请检查企业电话是否正确" point:self.view.center delay:1];
            return;
        }
    }
    else {
        if (mobile.length<=0) {
            [self showMessageWindowWithTitle:@"请输入手机号" point:self.view.center delay:1];
            return;
        }
        
        if (name.length<=0) {
            [self showMessageWindowWithTitle:@"请输入客户姓名" point:self.view.center delay:1];
            return;
        }
    }
    [dataDic setValue:@"0" forKey:@"user_id"];
    if (self.shiFouGeRen == NO) {
        [dataDic setValue:qiye_name forKey:@"unit_full_name"];
        [dataDic setValue:qiye_jianCheng forKey:@"store_alias"];
        [dataDic setValue:qiye_mobile forKey:@"mobile"];
    }
    else {
        [dataDic setValue:mobile forKey:@"mobile"];
        [dataDic setValue:name forKey:@"store_alias"];
        [dataDic setValue:@"" forKey:@"id_card"];
    }
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:dataDic withUrl:@"order/new_order/add_new_user" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        NSDictionary *dataDict = kParseData(responseObject);
        if (code == 200) {
            [weakSelf showMessageWindowWithTitle:@"保存成功" point:self.view.center delay:1];
            if (weiXiu == YES) {
                kehuXuQiuViewController *kehuXuQiu = [kehuXuQiuViewController new];
                [UserInfo shareInstance].user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDict, @"user_id")];
                [self.navigationController pushViewController:kehuXuQiu animated:YES];
            }else{
                if (weakSelf.shiFouGeRen == YES) {
                    weakSelf.xiMeiZuiZhongModel.realname = name;
                    weakSelf.xiMeiZuiZhongModel.mobile = mobile;
                }else{
                    weakSelf.xiMeiZuiZhongModel.realname = qiye_name;
                    weakSelf.xiMeiZuiZhongModel.mobile = qiye_mobile;
                }
                
                
                weakSelf.xiMeiZuiZhongModel.send_mobile = sende_mobile;
                weakSelf.xiMeiZuiZhongModel.send_name = sende_name;
                weakSelf.xiMeiZuiZhongModel.send_id_card = sende_id_card;
                ModelCarViewController *vc = [[ModelCarViewController alloc]init];
                vc.xiMeiZuiZhongModel = weakSelf.xiMeiZuiZhongModel;
                weakSelf.xiMeiZuiZhongModel.shiFoNiMing = NO;
                weakSelf.xiMeiZuiZhongModel.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDict, @"user_id")];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }else{
            [weakSelf showAlertViewWithTitle:[responseObject objectForKey:@"msg"] Message:nil buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
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
        lb.textColor = UIColorHex(#FF383D);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [lb setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        lb.text = @"*客户类型";
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
    
    [self.mainTabelView reloadData];
    
    
    if (self.shiFouWeiXiu == NO) {
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
}

-(void)niMingXiaDanChick:(UIButton *)sender
{
    ModelCarViewController *vc = [[ModelCarViewController alloc]init];
    vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
    self.xiMeiZuiZhongModel.shiFoNiMing = YES;
    self.xiMeiZuiZhongModel.user_id = @"0";
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)mainTabelView
{
    if (!_mainTabelView) {
        _mainTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+48.5, kWindowW, kWindowH-(kNavBarHeight+48.5+70)) style:(UITableViewStylePlain)];
        _mainTabelView.delegate = self;
        _mainTabelView.dataSource = self;
        _mainTabelView.backgroundColor = self.view.backgroundColor;
        _mainTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTabelView];
    }
    return _mainTabelView;
}


-(void)dw_segmentedControl:(DWSegmentedControl *)control didSeletRow:(NSInteger)row
{
    if (row == 0) {
        self.shiFouGeRen = YES;
    }else{
        self.shiFouGeRen = NO;
    }
    [self.mainTabelView reloadData];
}

-(void)feeTextFildChange:(UITextField *)sender
{
    if (sender == nameTextField) {
        name = sender.text;
    }else if (sender == mobileTextField) {
        mobile = sender.text;
    }else if (sender == sende_nameTextField) {
        sende_name = sender.text;
    }else if (sender == sende_mobileTextField) {
        sende_mobile = sender.text;
    }else if (sender == sende_id_cardTextField) {
        sende_id_card = sender.text;
    }else if (sender == qiye_nameTextField) {
        qiye_name = sender.text;
    }else if (sender == qiye_jianChengTextField) {
        qiye_jianCheng = sender.text;
    }else if (sender == qiye_mobileTextField) {
        qiye_mobile = sender.text;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.shiFouGeRen == YES) {
        return 2;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    TianRuXXCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TianRuXXCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.youTextField addTarget:self action:@selector(feeTextFildChange:) forControlEvents:UIControlEventEditingChanged];
    cell.line.hidden = NO;
    cell.youTextField.returnKeyType = UIReturnKeyDone;
    
    if (self.shiFouGeRen == YES) {
        if (indexPath.section == 0) {
            cell.zuoLabel.textColor = kRGBColor(255, 56, 61);
            if (indexPath.row == 0) {
                cell.zuoLabel.text = @"*客户电话";
                cell.youTextField.text = mobile;
                cell.youTextField.placeholder = @"请输入手机号";
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.youTextField;
                cell.youTextField.inputView = m_keyBoard2;
                mobileTextField = cell.youTextField;
            }else{
                cell.zuoLabel.text = @"*客户姓名";
                cell.youTextField.text = name;
                cell.youTextField.placeholder = @"请输入姓名";
                cell.youTextField.delegate = self;
                nameTextField = cell.youTextField;
                cell.line.hidden = YES;
            }
        }else{
            cell.zuoLabel.textColor = kRGBColor(102, 102, 102);
            if (indexPath.row == 0) {
                cell.zuoLabel.text = @"送修人电话";
                cell.youTextField.text = sende_mobile;
                cell.youTextField.placeholder = @"请输入手机号";
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.youTextField;
                cell.youTextField.inputView = m_keyBoard2;
                sende_mobileTextField = cell.youTextField;
            }else{
                cell.zuoLabel.text = @"送修人姓名";
                cell.youTextField.text = sende_name;
                cell.youTextField.placeholder = @"请输入姓名";
                cell.youTextField.delegate = self;
                sende_nameTextField = cell.youTextField;
                cell.line.hidden = YES;
            }
        }
    }else{
        if (indexPath.section == 0) {
            cell.zuoLabel.textColor = kRGBColor(255, 56, 61);
            if (indexPath.row == 0) {
                cell.zuoLabel.text = @"*企业全称";
                cell.youTextField.text = qiye_name;
                cell.youTextField.placeholder = @"请输入企业全称";
                cell.youTextField.delegate = self;
                cell.youTextField.inputView = nil;
                qiye_nameTextField = cell.youTextField;
                
            }else if (indexPath.row == 1) {
                cell.zuoLabel.text = @"*企业简称";
                cell.youTextField.text = qiye_jianCheng;
                cell.youTextField.placeholder = @"请输入企业简称";
                cell.youTextField.delegate = self;
                qiye_jianChengTextField = cell.youTextField;
            }else{
                cell.zuoLabel.text = @"*企业电话";
                cell.youTextField.text = qiye_mobile;
                cell.youTextField.placeholder = @"请输入企业电话";
                cell.youTextField.delegate = self;
                qiye_mobileTextField = cell.youTextField;
                cell.line.hidden = YES;
            }
        }else{
            cell.zuoLabel.textColor = kRGBColor(102, 102, 102);
            if (indexPath.row == 0) {
                cell.zuoLabel.text = @"送修人电话";
                cell.youTextField.text = sende_mobile;
                cell.youTextField.placeholder = @"请输入手机号";
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.youTextField;
                cell.youTextField.inputView = m_keyBoard2;
                sende_mobileTextField = cell.youTextField;
            }else if (indexPath.row == 1) {
                cell.zuoLabel.text = @"送修人姓名";
                cell.youTextField.text = sende_name;
                cell.youTextField.delegate = self;
                sende_nameTextField = cell.youTextField;
            }else{
                cell.zuoLabel.text = @"送修人身份证";
                cell.youTextField.text = sende_id_card;
                cell.youTextField.delegate = self;
                sende_id_cardTextField = cell.youTextField;
                cell.line.hidden = YES;
            }
        }
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = self.view.backgroundColor;
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)fieldChangeing:(NumberKeyboard*) numKeyboard
{
    if (numKeyboard.currentField == mobileTextField) {
        sende_mobile = mobileTextField.text;
        sende_mobileTextField.text = mobileTextField.text;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == nameTextField) {
        sende_name = nameTextField.text;
        sende_nameTextField.text = nameTextField.text;
    }
    
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
