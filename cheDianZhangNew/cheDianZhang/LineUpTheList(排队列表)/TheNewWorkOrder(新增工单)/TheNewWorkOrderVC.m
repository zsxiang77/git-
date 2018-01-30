//
//  TheNewWorkOrderVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheNewWorkOrderVC.h"
#import "TheNewWorkOrderCell.h"
#import "NewVehicleVC.h"
#import "AITProductInformationVC.h"

@interface TheNewWorkOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NumKeyboardDelegate>
@property(nonatomic,assign)BOOL shiFouYinCangXinZeng;


@end

@implementation TheNewWorkOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增工单" withBackButton:YES];
    
    if (self.chePaiStr.length>0) {
        UILabel *chepaiLa = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 40)];
        chepaiLa.font = [UIFont systemFontOfSize:14];
        chepaiLa.text = [NSString stringWithFormat:@"车牌号码   %@",self.chePaiStr];
        chepaiLa.textAlignment = NSTextAlignmentCenter;
        chepaiLa.textColor = [UIColor grayColor];
        [self.view addSubview:chepaiLa];
        
        self.main_tabelView.frame = CGRectMake(0, kNavBarHeight+40, kWindowW, kWindowH-kNavBarHeight-60-40);
        
    }else
    {
        self.main_tabelView.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-60);
    }
    self.xinZengModel = [[Users_carsModel alloc]init];
    self.shiFouZhuCe = NO;
    self.shiFouQiYe = NO;
    jiBenArray = [[NSMutableArray alloc]init];
    if (self.userInformetionDict) {
        NSDictionary *users_details = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
        NSDictionary *deliverer = KISDictionaryHaveKey(self.userInformetionDict, @"deliverer");
        if ([KISDictionaryHaveKey(users_details, @"is_unit") integerValue] == 1) {
            self.shiFouQiYe = YES;
        }else
        {
            self.shiFouQiYe = NO;
        }
        for (int i =0; i<5; i++) {
            TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
            dict.textName = @"";
            if (i==0) {
                dict.name = @"手机号码";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"mobile")];
            }else if (i==1) {
                dict.name = @"姓名";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"realname")];
            }else if (i==2) {
                dict.name = @"企业全称";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"unit_full_name")];
            }else  if (i==3) {
                dict.name = @"送修人电话";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(deliverer, @"mobile")];
            }else{
                dict.name = @"送修人姓名";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(deliverer, @"realname")];
            }
            [jiBenArray addObject:dict];
        }
    }else{
        for (int i =0; i<5; i++) {
            TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
            dict.textName = @"";
            if (i==0) {
                dict.name = @"手机号码";
            }else if (i==1) {
                dict.name = @"姓名";
            }else if (i==2) {
                dict.name = @"企业全称";
            }else  if (i==3) {
                dict.name = @"送修人电话";
            }else{
                dict.name = @"送修人姓名";
            }
            [jiBenArray addObject:dict];
        }
    }
    
    
    xinZengArray = [[NSMutableArray alloc]init];
    
    
    couponsArray = [[NSMutableArray alloc]init];
    if (self.userInformetionDict) {
        NSArray *cards_info = KISDictionaryHaveKey(self.userInformetionDict, @"cards_info");
        if (cards_info.count>0) {
            for (int i = 0; i<cards_info.count; i++) {
                [couponsArray addObject:cards_info[i]];
            }
            
            TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
            dict.textName = @"";
            dict.name = @"会员卡";
            [jiBenArray addObject:dict];
        }
        
        
        NSArray *users_cars = KISDictionaryHaveKey(self.userInformetionDict, @"users_cars");
        [xinZengArray removeAllObjects];
        self.shiFouYinCangXinZeng  = NO;
        if (users_cars.count>0) {
            for (int i = 0; i<users_cars.count; i++) {
                Users_carsModel *model = [[Users_carsModel alloc]init];
                self.shiFouYinCangXinZeng  = YES;
                [model setdataWithDict:users_cars[i]];
                model.shifouXuanZHong = YES;
                [xinZengArray addObject:model];
            }
        }
    }
    
    [self.main_tabelView reloadData];
    
    UIButton *xiYiBuBt = [[UIButton alloc]init];
    xiYiBuBt.backgroundColor = kZhuTiColor;
    [xiYiBuBt setTitle:@"下一步" forState:(UIControlStateNormal)];
    [xiYiBuBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [xiYiBuBt addTarget:self action:@selector(xiYiBuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [xiYiBuBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [xiYiBuBt.layer setCornerRadius:3];
    [self.view addSubview:xiYiBuBt];
    [xiYiBuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(94/2);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.shiFouTianJian == YES) {
        if (self.xinZengModel.shiFouXinZeng == YES) {
            BOOL youXuanZhong = NO;
            for (int i = 0; i<xinZengArray.count; i++) {
                Users_carsModel *model = xinZengArray[i];
                
                if (model.shifouXuanZHong == YES) {
                    youXuanZhong = YES;
                }
            }
            if (youXuanZhong == YES) {
                self.xinZengModel.shifouXuanZHong = NO;
            }
            [xinZengArray addObject:self.xinZengModel];
        }
    }
    self.shiFouTianJian = NO;
    
    [self.main_tabelView reloadData];
}
-(void)xiYiBuBtChick:(UIButton *)sender
{
    
    if (!((phoneTextField.text.length>10)&&(phoneTextField.text.length<13))) {
        [self showMessageWithContent:@"请输入正确的手机号" point:self.view.center afterDelay:2.0];
        return;
    }
    
    if (nameTextField.text.length<=0) {
        [self showMessageWithContent:@"请输入姓名" point:self.view.center afterDelay:2.0];
        return;
    }
    if (self.shiFouQiYe == YES) {
        if (qiyeTextField.text.length<=0) {
            [self showMessageWithContent:@"企业全称不能为空" point:self.view.center afterDelay:2.0];
            return;
        }
    }
    
    if (songPhoneTextField.text.length>0&&songPhoneTextField.text.length<10) {
        [self showMessageWithContent:@"送修人手机号不正确" point:self.view.center afterDelay:2.0];
        return;
    }
    
//    if (!((songPhoneTextField.text.length>9)&&(songPhoneTextField.text.length<13))) {
//        [self showMessageWithContent:@"送修人手机号有误" point:self.view.center afterDelay:2.0];
//        return;
//    }
//    if (songNameTextField.text.length<=0) {
//        [self showMessageWithContent:@"请输入送修人姓名" point:self.view.center afterDelay:2.0];
//        return;
//    }
    
    BOOL shiFouXuanZhong = NO;
    for (int i = 0; i<xinZengArray.count; i++) {
        Users_carsModel *model = xinZengArray[i];
        if (model.shifouXuanZHong == YES) {
            shiFouXuanZhong = YES;
        }
    }
    if (shiFouXuanZhong == NO) {
        [self showMessageWithContent:@"请选择车辆信息" point:self.view.center afterDelay:2.0];
        return;
    }
    
    self.zuiZhongModel = nil;
    
    self.zuiZhongModel = [[Car_zongModel alloc]init];
    
    if (self.shiFouQiYe == YES) {
        self.zuiZhongModel.is_unit = @"1";
        self.zuiZhongModel.unit_full_name = qiyeTextField.text;
    }else{
        self.zuiZhongModel.is_unit = @"0";
        self.zuiZhongModel.unit_full_name = @"";
    }
    
    self.zuiZhongModel.mobile = phoneTextField.text;
    self.zuiZhongModel.realname = nameTextField.text;
    
    self.zuiZhongModel.deliver_mobile = songPhoneTextField.text;
    self.zuiZhongModel.deliver_name = songNameTextField.text;
    
    [self postNetWorkOrder_user:phoneTextField.text WithName:nameTextField.text];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-50) style:UITableViewStylePlain];
        _main_tabelView.backgroundColor = [UIColor clearColor];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}

- (void)fieldChangeing:(NumberKeyboard*) numKeyboard
{
    if (numKeyboard.currentField == phoneTextField) {
        if (phoneTextField.text.length>=11) {
            if ([self.userInformetionDict isKindOfClass:[NSDictionary class]]) {
                NSArray *users_cars = KISDictionaryHaveKey(self.userInformetionDict, @"users_cars");
                if (users_cars.count>0) {
                }else{
                    [self postNetWorkPhone:phoneTextField.text];
                }
            }else{
                [self postNetWorkPhone:phoneTextField.text];
            }
        }else
        {
            for (int i = 0; i<jiBenArray.count; i++) {
                TheNewWorkOrderModel *dict = jiBenArray[i];
                if ([dict.name isEqualToString:@"手机号码"]) {
                    dict.textName = phoneTextField.text;
                }
            }
        }
    }else
    {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"送修人电话"]) {
                dict.textName = songPhoneTextField.text;
            }
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField == nameTextField) {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"姓名"]) {
                dict.textName = nameTextField.text;
                NPrintLog(@"12345 %@",dict.textName);
            }
            
            if ([dict.name isEqualToString:@"送修人姓名"])
            {
                if (dict.textName.length>0) {
                    
                }else{
                    dict.textName = nameTextField.text;
                    songNameTextField.text = dict.textName;
                }
            }
        }
    }
    
    if (textField == songNameTextField) {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"送修人姓名"]) {
                dict.textName = songNameTextField.text;
            }
        }
    }
    
    if (textField == qiyeTextField) {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"企业全称"]) {
                dict.textName = qiyeTextField.text;
            }
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == nameTextField) {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"姓名"]) {
                dict.textName = nameTextField.text;
                NPrintLog(@"12345 %@",dict.textName);
            }
        }
    }
    
    if (textField == songNameTextField) {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"送修人姓名"]) {
                dict.textName = songNameTextField.text;
            }
        }
    }
    
    if (textField == qiyeTextField) {
        for (int i = 0; i<jiBenArray.count; i++) {
            TheNewWorkOrderModel *dict = jiBenArray[i];
            if ([dict.name isEqualToString:@"企业全称"]) {
                dict.textName = qiyeTextField.text;
            }
        }
    }
    
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.shiFouQiYe == YES) {
            return jiBenArray.count;
        }else
        {
            return jiBenArray.count-1;
        }
        
    }else
    {
        return xinZengArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *myIdentifier = @"Cell";
        TheNewWorkOrderCell *cell = (TheNewWorkOrderCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[TheNewWorkOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.line.hidden = NO;
        cell.tiaozhuanImageView.hidden = YES;
        if (self.shiFouQiYe == YES) {
            TheNewWorkOrderModel *dict = jiBenArray[indexPath.row];
            cell.mainLabel.text = dict.name;
            cell.mainTextField.delegate = self;
            if (indexPath.row == 0) {
                
                cell.mainTextField.placeholder = @"请输入手机号";
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                cell.mainTextField.text = dict.textName;
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.mainTextField;
                cell.mainTextField.inputView = m_keyBoard2;
                phoneTextField = cell.mainTextField;
            }else if (indexPath.row == 1) {
                cell.mainTextField.placeholder = @"请输入姓名";
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                cell.mainTextField.inputView = nil;
                cell.mainTextField.text = dict.textName;
                nameTextField = cell.mainTextField;
            }else if (indexPath.row == 2) {
                cell.mainTextField.placeholder = @"请输入企业全称";
                cell.tiaozhuanImageView.hidden = NO;
                cell.tiaozhuanImageView.image = DJImageNamed(@"qiye");
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                cell.mainTextField.inputView = nil;
                cell.mainTextField.text = dict.textName;
                qiyeTextField = cell.mainTextField;
            }else if (indexPath.row == 3) {
                TheNewWorkOrderModel *dict = jiBenArray[indexPath.row];
                cell.mainLabel.text = dict.name;
                cell.mainTextField.text = dict.textName;
                
                
                cell.mainTextField.placeholder = @"请输入手机号";
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.mainTextField;
                cell.mainTextField.inputView = m_keyBoard2;
                songPhoneTextField = cell.mainTextField;
                
            }else if (indexPath.row == 4) {
                cell.mainTextField.placeholder = @"请输入送修人姓名";
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                cell.mainTextField.text = dict.textName;
                cell.mainTextField.inputView = nil;
                songNameTextField = cell.mainTextField;
            }else if (indexPath.row == 5) {
                cell.mainLabel.text = dict.name;
                cell.mainTextField.text = [NSString stringWithFormat:@"%ld",(unsigned long)couponsArray.count];
                cell.mainTextField.textColor = [UIColor blackColor];
                cell.mainTextField.userInteractionEnabled = NO;
                cell.tiaozhuanImageView.hidden = NO;
            }
        }else
        {
            
            cell.mainTextField.delegate = self;
            if (indexPath.row == 0) {
                TheNewWorkOrderModel *dict = jiBenArray[indexPath.row];
                cell.mainLabel.text = dict.name;
                cell.mainTextField.placeholder = @"请输入手机号";
                cell.mainTextField.text = dict.textName;
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.mainTextField;
                cell.mainTextField.inputView = m_keyBoard2;
                
                phoneTextField = cell.mainTextField;
            }else if (indexPath.row == 1) {
                TheNewWorkOrderModel *dict = jiBenArray[indexPath.row];
                cell.mainLabel.text = dict.name;
                cell.mainTextField.placeholder = @"请输入姓名";
                cell.mainTextField.text = dict.textName;
                cell.mainTextField.inputView = nil;
                nameTextField = cell.mainTextField;
            }else if (indexPath.row == 2) {
                TheNewWorkOrderModel *dict = jiBenArray[indexPath.row+1];
                cell.mainLabel.text = dict.name;
                cell.mainTextField.text = dict.textName;
                
                cell.mainTextField.placeholder = @"请输入手机号";
                cell.mainTextField.font = [UIFont systemFontOfSize:14];
                cell.mainTextField.clearButtonMode = UITextFieldViewModeAlways;
                
                NumberKeyboard *m_keyBoard2;
                m_keyBoard2 = [[NumberKeyboard alloc]init];
                m_keyBoard2.keyboardType = NumberKeyboardType_Normal;
                m_keyBoard2.maxLength = 11;
                m_keyBoard2.myDelegate = self;
                m_keyBoard2.currentField = cell.mainTextField;
                cell.mainTextField.inputView = m_keyBoard2;
                songPhoneTextField = cell.mainTextField;
            }else if (indexPath.row == 3) {
                TheNewWorkOrderModel *dict = jiBenArray[indexPath.row+1];
                cell.mainLabel.text = dict.name;
                cell.mainTextField.placeholder = @"请输入姓名";
                cell.mainTextField.text = dict.textName;
                cell.mainTextField.inputView = nil;
                songNameTextField = cell.mainTextField;
            }else if (indexPath.row == 4) {
                TheNewWorkOrderModel *dict = jiBenArray[indexPath.row+1];
                cell.mainLabel.text = dict.name;
                cell.mainTextField.text = [NSString stringWithFormat:@"%ld",(unsigned long)couponsArray.count];
                cell.mainTextField.textColor = [UIColor blackColor];
                cell.mainTextField.userInteractionEnabled = NO;
                cell.tiaozhuanImageView.hidden = NO;
            }
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *myIdentifier = @"Cell2";
        CarInformeTionCell *cell = (CarInformeTionCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[CarInformeTionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        
        Users_carsModel *model = xinZengArray[indexPath.row];
        
        if (model.shifouXuanZHong == YES) {
            cell.xuanZhongBt.image = DJImageNamed(@"cell_select");
            
            cell.xiaView.hidden = NO;
            if (model.ait == NO) {
                cell.xiaView.hidden = YES;
            }
        }else
        {
            cell.xuanZhongBt.image = DJImageNamed(@"cell_noselect");
            
            cell.xiaView.hidden = YES;
        }
        
        
        cell.chuLiModel = model;
        
        cell.carNumeberLabel.text = model.car_number;
        kWeakSelf(weakSelf)
        
        if (model.car_info.length>0) {
            cell.cheColorLabel.text = model.car_info;
        }else{
            cell.cheColorLabel.text = [NSString stringWithFormat:@"%@ %@",model.brands,model.trainSystem];
        }
        
        cell.colorLabel.text = model.car_body_color;
        if (model.shiFouXinZeng == NO) {
            [cell.shanChuButton setImage:DJImageNamed(@"car_tixing") forState:(UIControlStateNormal)];
        }else
        {
            [cell.shanChuButton setImage:DJImageNamed(@"car_delete") forState:(UIControlStateNormal)];
        }
        cell.shanChuButtonBlock = ^(Users_carsModel *chuLiModel) {
            if (chuLiModel.shiFouXinZeng == NO) {
                [weakSelf.car_TiShiView sheZhiDataWithDict:chuLiModel.tip];
                weakSelf.car_TiShiView.hidden = NO;
                [weakSelf.view bringSubviewToFront:weakSelf.car_TiShiView];
            }else
            {
                [xinZengArray removeObject:chuLiModel];
                weakSelf.xinZengModel = nil;
                weakSelf.xinZengModel = [[Users_carsModel alloc]init];
                [weakSelf.main_tabelView reloadData];
            }
        };
        
        cell.tiaoZhuanAitBlock = ^{
            AITProductInformationVC *xinvc = [[AITProductInformationVC alloc]init];
            [weakSelf.navigationController pushViewController:xinvc animated:YES];
        };
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}
-(Car_TiShiView *)car_TiShiView
{
    if (!_car_TiShiView) {
        _car_TiShiView  = [[Car_TiShiView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_car_TiShiView];
        [self.view bringSubviewToFront:_car_TiShiView];
    }
    return _car_TiShiView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else
    {
        Users_carsModel *model = xinZengArray[indexPath.row];
        if (model.shifouXuanZHong == YES) {
            if (model.ait == YES) {
                return 100;
            }else{
                return 70;
            }
        }
        return 70;
    }
    
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (self.shiFouQiYe == YES) {
            if (indexPath.row == 5) {
                CouponsCardVC *vc = [[CouponsCardVC alloc]init];
                vc.shangYeMianChuanZhi = couponsArray;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else
        {
            if (indexPath.row == 4) {
                CouponsCardVC *vc = [[CouponsCardVC alloc]init];
                vc.shangYeMianChuanZhi = couponsArray;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }else
    {
        for (int i = 0; i<xinZengArray.count; i++) {
            Users_carsModel *shamodel = xinZengArray[i];
            shamodel.shifouXuanZHong = NO;
        }
        
        Users_carsModel *model = xinZengArray[indexPath.row];
        model.shifouXuanZHong = YES;
        [self.main_tabelView reloadData];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = self.view.backgroundColor;
    UILabel *label = [[UILabel alloc]init];
    label.textColor = kRGBColor(155, 155, 155);
    label.font = [UIFont systemFontOfSize:14];
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.mas_equalTo(0);
    }];
    if (section == 1) {
        label.text = @"车辆信息";
    }else
    {
        label.text = @"企业用户";
        
        UISwitch *qiYeKaiGuan = [[UISwitch alloc]init];
        [qiYeKaiGuan addTarget:self action:@selector(qiYeKaiGuanChick:) forControlEvents:(UIControlEventTouchUpInside)];
        qiYeKaiGuan.transform = CGAffineTransformMakeScale( 0.8, 0.8);
        qiYeKaiGuan.on = self.shiFouQiYe;
        [backView addSubview:qiYeKaiGuan];
        [qiYeKaiGuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return backView;
}
-(void)qiYeKaiGuanChick:(UISwitch *)sender
{
    NPrintLog(@"%d",sender.on);
    self.shiFouQiYe = sender.on;
    [self.main_tabelView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }else
    {
        if (self.shiFouZhuCe == YES) {
            return 40;
        }else{
            return 0;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = self.view.backgroundColor;
    UIButton *xinZengBt = [[UIButton alloc]initWithFrame:CGRectMake((kWindowW-250)/2, 10, 250, 93/2)];
    xinZengBt.backgroundColor = [UIColor whiteColor];
    [xinZengBt.layer setMasksToBounds:YES];
    [xinZengBt.layer setCornerRadius:3];
    [xinZengBt setTitle:@"新增车辆" forState:UIControlStateNormal];
    xinZengBt.tag = 1001;
    if (self.xinZengModel.shiFouXinZeng == NO)  {
        xinZengBt.hidden = NO;
        [xinZengBt setTitleColor:kZhuTiColor forState:UIControlStateNormal];
    }else
    {
        xinZengBt.hidden = YES;
        [xinZengBt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    [xinZengBt addTarget:self action:@selector(xinZengBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [footView addSubview:xinZengBt];
    
    if (self.shiFouYinCangXinZeng == YES) {
        xinZengBt.hidden = YES;
    }
    
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 93/2+20;
    }
}



-(void)xinZengBtChick:(UIButton *)sender
{
    if (!((phoneTextField.text.length>10)&&(phoneTextField.text.length<13))) {
        [self showMessageWithContent:@"请输入正确的手机号" point:self.view.center afterDelay:2.0];
        return;
    }
    
    if (self.xinZengModel.shiFouXinZeng == YES) {
        return;
    }
    self.shiFouTianJian = YES;
    NewVehicleVC *vc = [[NewVehicleVC alloc]init];
    vc.chePaiStr = self.chePaiStr;
    vc.xinZengModel = self.xinZengModel;
    vc.superViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
