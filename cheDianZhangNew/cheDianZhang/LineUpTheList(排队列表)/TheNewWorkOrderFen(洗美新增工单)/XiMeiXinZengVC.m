//
//  XiMeiXinZengVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiXinZengVC.h"
#import "TheNewWorkOrderCell.h"
#import "NewVehicleVC.h"
#import "AITProductInformationVC.h"

@interface XiMeiXinZengVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NumKeyboardDelegate>
@property(nonatomic,assign)BOOL shiFouYinCangXinZeng;
@end

@implementation XiMeiXinZengVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增工单" withBackButton:YES];
    
    self.zuiZongModel = [[XiMeiXinZengZuiZongModel alloc]init];
    
    
    if (self.chePaiStr.length>0) {
        UILabel *chepaiLa = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 40)];
        chepaiLa.font = [UIFont systemFontOfSize:14];
        chepaiLa.text = [NSString stringWithFormat:@"车牌号码   %@",self.chePaiStr];
        chepaiLa.textAlignment = NSTextAlignmentCenter;
        chepaiLa.textColor = [UIColor grayColor];
        [self.view addSubview:chepaiLa];
        
        self.main_tabelView.frame = CGRectMake(0, kNavBarHeight+40, kWindowW, kWindowH-kNavBarHeight-50-40);
        
    }else
    {
        self.main_tabelView.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-50);
    }
    
    self.shiFouZhuCe = NO;
    self.shiFouNiMing = NO;
    self.shiFouQiYe = NO;
    self.xinZengModel = [[Users_carsModel alloc]init];
    
    jiBenArray = [[NSMutableArray alloc]init];
    if (self.userInformetionDict) {
        NSDictionary *users_details = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
        for (int i =0; i<2; i++) {
            TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
            dict.textName = @"";
            if (i==0) {
                dict.name = @"手机号码";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"mobile")];
            }else if (i==1) {
                dict.name = @"姓名";
                dict.textName = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"realname")];
            }
            [jiBenArray addObject:dict];
        }
    }else
    {
        for (int i =0; i<2; i++) {
            TheNewWorkOrderModel *dict = [[TheNewWorkOrderModel alloc]init];
            dict.textName = @"";
            if (i==0) {
                dict.name = @"手机号码";
            }else if (i==1) {
                dict.name = @"姓名";
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
        self.shiFouYinCangXinZeng = NO;
        if (users_cars.count>0) {
            for (int i = 0; i<users_cars.count; i++) {
                Users_carsModel *model = [[Users_carsModel alloc]init];
                self.shiFouYinCangXinZeng = YES;
                [model setdataWithDict:users_cars[i]];
                model.shifouXuanZHong = YES;
                [xinZengArray addObject:model];
            }
        }
    }
    niMingxinZengArray = [[NSMutableArray alloc]init];
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
        make.height.mas_equalTo(40);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.shiFouTianJia == YES) {
        if (self.zuiZongModel.shiFoNiMing == YES) {
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
                [niMingxinZengArray addObject:self.xinZengModel];
            }
        }else
        {
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
    }
    self.shiFouTianJia = NO;
    
    [self.main_tabelView reloadData];

}
-(void)xiYiBuBtChick:(UIButton *)sender
{
    
    if (self.zuiZongModel.shiFoNiMing == NO) {
        if (!((phoneTextField.text.length>10)&&(phoneTextField.text.length<13))) {
            [self showMessageWithContent:@"请输入正确的手机号" point:self.view.center afterDelay:2.0];
            return;
        }
        
        if (nameTextField.text.length<=0) {
            [self showMessageWithContent:@"请输入姓名" point:self.view.center afterDelay:2.0];
            return;
        }
        
        self.zuiZongModel.mobile = phoneTextField.text;
        self.zuiZongModel.realname = nameTextField.text;
    }else
    {
        self.zuiZongModel.mobile = @"";
        self.zuiZongModel.realname = @"";
    }
    


    BOOL shiFouXuanZhong = NO;
    if (self.zuiZongModel.shiFoNiMing == NO) {
        for (int i = 0; i<xinZengArray.count; i++) {
            Users_carsModel *model = xinZengArray[i];
            if (model.shifouXuanZHong == YES) {
                shiFouXuanZhong = YES;
            }
        }
    }else
    {
        for (int i = 0; i<niMingxinZengArray.count; i++) {
            Users_carsModel *model = niMingxinZengArray[i];
            if (model.shifouXuanZHong == YES) {
                shiFouXuanZhong = YES;
            }
        }
    }
    
    if (shiFouXuanZhong == NO) {
        [self showMessageWithContent:@"请选择车辆信息" point:self.view.center afterDelay:2.0];
        return;
    }
    
    [self postNetWorkOrder_user:phoneTextField.text WithName:nameTextField.text];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-50) style:UITableViewStylePlain];
        _main_tabelView.backgroundColor = self.view.backgroundColor;
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
            }
        }
    }

    if ([string isEqualToString:@"\n"]) {
        [nameTextField resignFirstResponder];
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
    if (self.shiFouNiMing == NO) {
        if (section == 0) {
            return jiBenArray.count;
        }else
        {
            return xinZengArray.count;
        }
    }else
    {
        if (section == 0) {
            return 0;
        }else
        {
            return niMingxinZengArray.count;
        }
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
            cell.mainTextField.text = dict.textName;
            nameTextField = cell.mainTextField;
        }else{
            TheNewWorkOrderModel *dict = jiBenArray[indexPath.row];
            cell.mainLabel.text = dict.name;
            cell.mainTextField.text = [NSString stringWithFormat:@"%ld",(unsigned long)couponsArray.count];
            cell.mainTextField.textColor = [UIColor blackColor];
            cell.mainTextField.userInteractionEnabled = NO;
            cell.tiaozhuanImageView.hidden = NO;
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
        
        Users_carsModel *model;
        if (self.zuiZongModel.shiFoNiMing == YES) {
            model = niMingxinZengArray[indexPath.row];
        }else
        {
            model = xinZengArray[indexPath.row];
        }
        
        
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
            AITProductInformationVC *vuiVc = [[AITProductInformationVC alloc]init];
            [weakSelf.navigationController pushViewController:vuiVc animated:YES];
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
        Users_carsModel *model;
        if (self.zuiZongModel.shiFoNiMing == YES) {
            model = niMingxinZengArray[indexPath.row];
        }else
        {
            model = xinZengArray[indexPath.row];
        }
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
        if (indexPath.row == 2) {
            CouponsCardVC *vc = [[CouponsCardVC alloc]init];
            vc.shangYeMianChuanZhi = couponsArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else
    {
        for (int i = 0; i<xinZengArray.count; i++) {
            Users_carsModel *shamodel = xinZengArray[i];
            shamodel.shifouXuanZHong = NO;
        }
        Users_carsModel *model;
        if (self.zuiZongModel.shiFoNiMing == YES) {
            model = niMingxinZengArray[indexPath.row];
        }else
        {
            model = xinZengArray[indexPath.row];
        }
        model.shifouXuanZHong = YES;
        [self.main_tabelView reloadData];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = self.view.backgroundColor;
    if (section == 1) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor blackColor];
        label.text = @"车辆信息";
        label.textColor = kRGBColor(155, 155, 155);
        label.font = [UIFont systemFontOfSize:14];
        [backView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
    }else
    {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor blackColor];
        label.text = @"匿名下单";
        label.textColor = kRGBColor(155, 155, 155);
        label.font = [UIFont systemFontOfSize:14];
        [backView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        UISwitch *niMIngKaiGuan = [[UISwitch alloc]init];
        niMIngKaiGuan.on = self.shiFouNiMing;
        niMIngKaiGuan.transform = CGAffineTransformMakeScale( 0.8, 0.8);
        [niMIngKaiGuan addTarget:self action:@selector(niMIngKaiGuanChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:niMIngKaiGuan];
        [niMIngKaiGuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return backView;
}

-(void)niMIngKaiGuanChick:(UISwitch *)sender
{
    self.shiFouNiMing = sender.on;
    [self.main_tabelView reloadData];
    
    self.zuiZongModel.shiFoNiMing = self.shiFouNiMing;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }else
    {
        return 40;
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
    if (self.zuiZongModel.shiFoNiMing == NO) {
        if (!((phoneTextField.text.length>10)&&(phoneTextField.text.length<13))) {
            [self showMessageWithContent:@"请输入正确的手机号" point:self.view.center afterDelay:2.0];
            return;
        }
    }
    
    if (self.xinZengModel.shiFouXinZeng == YES) {
        return;
    }
    self.shiFouTianJia = YES;
    NewVehicleVC *vc = [[NewVehicleVC alloc]init];
    vc.chePaiStr = self.chePaiStr;
    vc.xinZengModel = self.xinZengModel;
    vc.superViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
