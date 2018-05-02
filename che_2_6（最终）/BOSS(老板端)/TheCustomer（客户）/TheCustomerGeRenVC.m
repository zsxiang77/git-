//
//  TheCustomerGeRenVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "TheCustomerGeRenVC.h"
#import "TheCustomerGeRenCell.h"
#import "BOSSchangeUserMidelViewController.h"
#import "BOSSChangeNameViewController.h"
#import "BOSSChangeAllNameViewController.h"
@interface TheCustomerGeRenVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *xiaoFeiMoneyLabel;

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *numberLaber;

@property(nonatomic,strong)UITableView *mainTableView;

@end

@implementation TheCustomerGeRenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 150)];
    [self.view addSubview:shangView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kRGBColor(88, 158, 254).CGColor,  (__bridge id)kRGBColor(50, 88, 225).CGColor];
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, kWindowW, 150);
    [shangView.layer addSublayer:gradientLayer];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_back_btn")];
    backImageView.frame = CGRectMake(10, (kBOSSNavBarHeight - 27)/2+10,13,21);
    [shangView addSubview:backImageView];
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shangView addSubview:backButton];
    
    UILabel *leiJILabel = [[UILabel alloc]init];
    leiJILabel.text = @"累计消费额";
    leiJILabel.font = [UIFont systemFontOfSize:17];
    leiJILabel.textColor = [UIColor whiteColor];
    [shangView addSubview:leiJILabel];
    [leiJILabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(75);
    }];
    
    self.xiaoFeiMoneyLabel = [[UILabel alloc]init];
    self.xiaoFeiMoneyLabel.font = [UIFont systemFontOfSize:26];
    self.xiaoFeiMoneyLabel.textColor = [UIColor whiteColor];
    [shangView addSubview:self.xiaoFeiMoneyLabel];
    [self.xiaoFeiMoneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(101);
    }];
    
    
    
    CGFloat jisuaHei = 150;
    
    for (int i = 0; i<2; i++) {
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, jisuaHei, kWindowW, 56)];
        vi.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:vi];
        jisuaHei += 56;
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [vi addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        if (i == 0) {
            self.nameLabel = [[UILabel alloc]init];
            self.nameLabel.font = [UIFont systemFontOfSize:20];
            self.nameLabel.textColor = [UIColor grayColor];
            [vi addSubview:self.nameLabel];
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-100);
                make.top.mas_equalTo(2);
            }];
            if ([self.chuanZhiModel.is_unit boolValue] == YES) {
                UILabel *zhiWeiLabel = [[UILabel alloc]init];
                zhiWeiLabel.text = @"企业";
                zhiWeiLabel.font = [UIFont systemFontOfSize:12];
                zhiWeiLabel.textColor = [UIColor whiteColor];
                [vi addSubview:zhiWeiLabel];
                [zhiWeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self.nameLabel.mas_left).mas_equalTo(-12);
                    make.centerY.mas_equalTo(self.nameLabel);
                }];
                
                UIView *zhiWeibackView = [[UIView alloc]init];
                zhiWeibackView.backgroundColor = kRGBColor(98, 172, 13);
                [zhiWeibackView.layer setMasksToBounds:YES];
                [zhiWeibackView.layer setCornerRadius:9];
                [vi addSubview:zhiWeibackView];
                [zhiWeibackView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(zhiWeiLabel);
                    make.left.mas_equalTo(zhiWeiLabel.mas_left).mas_equalTo(-5);
                    make.right.mas_equalTo(zhiWeiLabel.mas_right).mas_equalTo(5);
                    make.height.mas_equalTo(18);
                }];
                [vi bringSubviewToFront:zhiWeiLabel];
            }
            
        }else{
            UILabel *lae = [[UILabel alloc]init];
            lae.text = @"累计消费次数";
            lae.font = [UIFont systemFontOfSize:17];
            lae.textColor = kRGBColor(155, 155, 155);
            [vi addSubview:lae];
            [lae mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.centerY.mas_equalTo(vi);
            }];
            
            self.numberLaber = [[UILabel alloc]init];
            self.numberLaber.font = [UIFont systemFontOfSize:17];
            self.numberLaber.textColor = kRGBColor(74, 74, 74);
            [vi addSubview:self.numberLaber];
            [self.numberLaber mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.centerY.mas_equalTo(vi);
            }];
        }
    }
    
    
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, jisuaHei, kWindowW, kWindowH-jisuaHei) style:UITableViewStylePlain];
    _mainTableView.scrollEnabled = NO;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
    
    UIButton *modileBt = [[UIButton alloc]init];
    [modileBt setImage:DJImageNamed(@"boss_modile") forState:(UIControlStateNormal)];
    [modileBt addTarget:self action:@selector(modileBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:modileBt];
    [modileBt mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(72);
        make.top.mas_equalTo(111);
    }];
    [self.view bringSubviewToFront:modileBt];
    
}

-(void)backButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postData];
}

-(void)modileBtChick:(UIButton *)sender
{
    if (![self.mainDict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",KISDictionaryHaveKey(self.mainDict, @"mobile")]]];
}

-(void)postData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [mDict setObject:self.chuanZhiModel.user_id forKey:@"user_id"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParametersGET:mDict withUrl:@"user/ucenter/get_one_consume" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if (code == 200) {
            NSDictionary* dataDic = kParseData(responseObject);
            weakSelf.mainDict =  dataDic;
            
            weakSelf.xiaoFeiMoneyLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(weakSelf.mainDict, @"user_consume")];
            
            weakSelf.nameLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(weakSelf.mainDict, @"store_alias")];
            
            weakSelf.numberLaber.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(weakSelf.mainDict, @"year_num")];
            
            
            [weakSelf.mainTableView reloadData];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
    } failure:^(id error) {
        
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.chuanZhiModel.is_unit boolValue] == YES) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Identifier";
    TheCustomerGeRenCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[TheCustomerGeRenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.chuanZhiModel.is_unit boolValue] == YES) {
        if (indexPath.row == 0) {
            cell.shangZuoLabel.text = @"企业电话";
            cell.xiaZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"mobile")];
        }else if (indexPath.row == 1) {
            cell.shangZuoLabel.text = @"企业简称";
            cell.xiaZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"store_alias")];
        }else{
            cell.shangZuoLabel.text = @"企业全称";
            cell.xiaZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"unit_full_name")];
        }
    }else{
        if (indexPath.row == 0) {
            cell.shangZuoLabel.text = @"客户手机号";
            cell.xiaZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"mobile")];
        }else{
            cell.shangZuoLabel.text = @"客户名称";
            cell.xiaZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"store_alias")];
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.chuanZhiModel.is_unit boolValue]==YES){
        if(indexPath.row==0){
            BOSSchangeUserMidelViewController*vc=[[BOSSchangeUserMidelViewController alloc]init];
            vc.chuanZhidict = self.chuanZhiModel;
            vc.nameStr = @"企业电话";
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==1){
            BOSSChangeNameViewController*vc=[[BOSSChangeNameViewController alloc]init];
            vc.nameStr = @"企业简称";
            vc.nameKeHuStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"store_alias")];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BOSSChangeAllNameViewController*vc=[[BOSSChangeAllNameViewController alloc]init];
            vc.allName = @"企业全称";
            vc.qiyeallName =[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"unit_full_name")];
            vc.chuanZhidict = self.chuanZhiModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if(indexPath.row==0){
            BOSSchangeUserMidelViewController*vc=[[BOSSchangeUserMidelViewController alloc]init];
            vc.nameStr = @"客户手机号";
            vc.chuanZhidict = self.chuanZhiModel;
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==1){
            BOSSChangeNameViewController*vc=[[BOSSChangeNameViewController alloc]init];
            vc.nameStr = @"客户名称";
            vc.nameKeHuStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDict, @"store_alias")];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
@end
