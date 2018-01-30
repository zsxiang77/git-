//
//  OrderDetailViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/4.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCell1.h"
#import "OrderDetailCell2.h"
#import "PreviewPictureViewController.h"
#import "CustomerInformationView.h"
#import "CarInformationViewController.h"
#import "SalesStaffViewController.h"
#import "NewOrderDetailTiJiaoView.h"
#import "AITHTMLViewController.h"
#import "AITProductInformationVC.h"





#define YULANTAG  (5000)
#define GUANBITAG  (6000)


@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>
{
}
@property(nonatomic,strong)NewOrderDetailTiJiaoView *orderDetailTiJiaoView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订单详情" withBackButton:YES];
//    self.chuanzhiModel.ordercode = @"0100100172544791";
    _xiangMuMingXiArray = [[NSMutableArray alloc]init];
    _peiJianMingXiArray = [[NSMutableArray alloc]init];
    _xiangMuMingXiArrayCun = [[NSMutableArray alloc]init];
    _peiJianMingXiArrayCun = [[NSMutableArray alloc]init];
    _xiangMuMingXiibool  = YES;
    _peiJianMingXibool  = YES;
    
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW-64, 20, 54, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"关闭" forState:(UIControlStateNormal)];
    [backButton setTitleColor:kRGBColor(54, 54, 54) forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonGuanBiClick:) forControlEvents:UIControlEventTouchUpInside];
    [m_baseTopView addSubview:backButton];
    
    
    self.mainTableView.hidden = NO;
    
    UIButton *wanChengBt = [[UIButton alloc]initWithFrame:CGRectMake(10, kWindowH-60, kWindowW-20, 40)];
    wanChengBt.backgroundColor = kZhuTiColor;
    [wanChengBt setTitle:@"施工完成" forState:(UIControlStateNormal)];
    [wanChengBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [wanChengBt addTarget:self action:@selector(wanChengBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [wanChengBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [wanChengBt.layer setCornerRadius:3];
    [self.view addSubview:wanChengBt];
    
//    if (self.shiFouKeXiugai == NO) {
//        wanChengBt.hidden = YES;
//        self.mainTableView.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight);
//    }
    
    
    [self setrequest_methodwithOrdercodevarchar:self.chuanzhiModel];
    [self postRequest_methodWithModel:self.chuanzhiModel];
    
    [self postpeiJianMingXiWithModel:self.chuanzhiModel withTiaoZhua:NO With:nil];
    [self postrequest_methodMingXiWithModel:self.chuanzhiModel withTiaoZhua:NO With:nil];
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:kJieShouXiaoXi object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setrequest_methodwithOrdercodevarchar:self.chuanzhiModel];
    [self postRequest_methodWithModel:self.chuanzhiModel];
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJieShouXiaoXi object:nil];
}

-(void)backButtonGuanBiClick:(UIButton *)sender
{
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:1];
        return;
    }
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"订单持有人" message:@"关闭后该订单不会显示在任何页面里了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"关闭", nil];
    alert.tag = 103;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 103) {
        if( alertView.cancelButtonIndex != buttonIndex){
            NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
            [mDict setObject:self.chuanzhiModel.ordercode forKey:@"ordercode"];
            
            kWeakSelf(weakSelf)
            [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/close_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
                //        NSArray* dataDic = kParseData(responseObject);
                //        if (![dataDic isKindOfClass:[NSArray class]]) {
                //            return;
                //        }
                
                if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
                    [defaultCenter postNotificationName:kShuaXinGuoZuoTai object:nil];
                }else
                {
                    [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                }
                
            } failure:^(id error) {
                
            }];
        }
    }
    
    if (alertView.tag == 200) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
            [mDict setObject:self.tiaoZhuanordercode forKey:@"ordercode"];
            
            kWeakSelf(weakSelf)
            [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_report" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
                
                if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
                    
                    AITHTMLViewController *vc = [[AITHTMLViewController alloc]init];
                    NSArray* dataDic = kParseData(responseObject);
                    if (![dataDic isKindOfClass:[NSArray class]]) {
                        return;
                    }
                    vc.chuanZhiArray = dataDic;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else
                {
                    [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                }
                
            } failure:^(id error) {
                
            }];
        }
    }
}
#pragma mark - 施工完成
-(void)wanChengBtChick:(UIButton *)sender
{
//    if (_shiFouKeXiugai == NO) {
//        [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//        return;
//    }
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:1];
        return;
    }
    
    if ([[UserInfo shareInstance].isExplod boolValue]) {
        NSString *real_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.zhuModel.seller, @"real_name")];
        if (!(real_name.length>0)) {
            [self showMessageWithContent:@"请选择销售人员" point:self.view.center afterDelay:0.5];
            return;
        }
        NSString *inspector_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.zhuModel.inspector, @"staff_name")];
        if (!(inspector_name.length>0)){
            [self showMessageWithContent:@"请选择检验人员" point:self.view.center afterDelay:0.5];
            return;
        }
        
    }
    
    if (_xiangMuMingXiArrayCun.count<=0) {
        [self showMessageWithContent:@"请选择项目" point:self.view.center afterDelay:0.5];
        return;
    }
    
    for (int i = 0; i<_xiangMuMingXiArrayCun.count; i++) {
        OrignalModel *model = _xiangMuMingXiArrayCun[i];
        if (model.operation.length<=0) {
            [self showMessageWithContent:@"有项目未选择施工人员" point:self.view.center afterDelay:0.5];
            return;
        }
    }
    
    [self postrequest_methodData];

}
#pragma mark - 接车信息
-(void)postrequest_methodData{
    
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuanzhiModel.ordercode forKey:@"ordercode"];
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/repair_order/inspect_info",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue]!=200) {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
        }else
        {
            NSDictionary *info = KISDictionaryHaveKey(adData, @"info");
            weakSelf.repairmileStr = KISDictionaryHaveKey(info, @"repairmile");
            
            weakSelf.orderDetailTiJiaoView.hidden = NO;
            if (weakSelf.repairmileStr) {
                weakSelf.orderDetailTiJiaoView.jinChangLabei.text =  [NSString stringWithFormat:@"%@",weakSelf.repairmileStr];
            }else
            {
                weakSelf.orderDetailTiJiaoView.jinChangLabei.text = @"";
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHideLoadView:NO];
    }];
    
}

-(NewOrderDetailTiJiaoView *)orderDetailTiJiaoView
{
    if (!_orderDetailTiJiaoView) {
        _orderDetailTiJiaoView = [[NewOrderDetailTiJiaoView alloc]init];
        _orderDetailTiJiaoView.superViewController = self;
        [self.view addSubview:_orderDetailTiJiaoView];
        [self.view bringSubviewToFront:_orderDetailTiJiaoView];
        
    }
    return _orderDetailTiJiaoView;
}

-(OrderDetailModel *)zhuModel
{
    if (!_zhuModel) {
        _zhuModel = [[OrderDetailModel alloc]init];
        
    }
    return _zhuModel;
}



-(OrderDetailHeaderView *)orderDetailHeaderView
{
    if (!_orderDetailHeaderView) {
        _orderDetailHeaderView = [[OrderDetailHeaderView alloc]initWithModel:self.chuanzhiModel];
        [_orderDetailHeaderView.suoDanSwitch addTarget:self action:@selector(suoDanSwitchChick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (_shiFouKeXiugai == NO) {
            [_orderDetailHeaderView.suoDanSwitch setUserInteractionEnabled:NO];
        }
        kWeakSelf(weakSelf)
        _orderDetailHeaderView.jieCheInformetionBtBlock = ^(NSInteger tag) {
            if (tag == 0) {
                CarInformationViewController *vc = [[CarInformationViewController alloc]init];
                vc.ordercode = weakSelf.chuanzhiModel.ordercode;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (tag == 2) {
                if ([KISDictionaryHaveKey(self.zhuModel.ait, @"num")integerValue]>0) {
                    
                    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
                    [mDict setObject:weakSelf.chuanzhiModel.ordercode forKey:@"ordercode"];
                    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_report" viewController:weakSelf withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
                        
                        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
                            AITHTMLViewController *vc = [[AITHTMLViewController alloc]init];
                            NSArray* dataDic = kParseData(responseObject);
                            if (![dataDic isKindOfClass:[NSArray class]]) {
                                return;
                            }
                            vc.chuanZhiArray = dataDic;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        }else
                        {
                            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                        }
                        
                    } failure:^(id error) {
                        
                    }];
                    
                }else{
                    AITProductInformationVC *vc = [[AITProductInformationVC alloc]init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            }else
            {
//                if (_shiFouKeXiugai == NO) {
//                    [weakSelf showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//                    return;
//                }
                
                if ([weakSelf.zhuModel.is_lock isEqualToString:@"1"] && [weakSelf.zhuModel.is_free intValue] == 0){
                    [weakSelf showMessageWithContent:@"已锁单" point:weakSelf.view.center afterDelay:2];
                    return;
                }
                SalesStaffViewController *vc = [[SalesStaffViewController alloc]init];
                if (tag == 1) {
                    vc.operLeiXin = tag;
                    NSString *sellerStr = KISDictionaryHaveKey(weakSelf.zhuModel.seller, @"real_name");
                    if ([sellerStr isKindOfClass:[NSString class]]) {
                        if (sellerStr.length>0) {
                            vc.chuanName = sellerStr;
                        }
                    }
                }else{
                    vc.operLeiXin = 2;
                    NSString *sellerStr = KISDictionaryHaveKey(weakSelf.zhuModel.inspector, @"staff_name");
                    if ([sellerStr isKindOfClass:[NSString class]]) {
                        if (sellerStr.length>0) {
                            vc.chuanName = sellerStr;
                        }
                    }
                }
                
                
                
                vc.ordercode = weakSelf.chuanzhiModel.ordercode;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        };
        _orderDetailHeaderView.erWeiMaButtonBlock = ^{
            Order_info *model = (Order_info *)weakSelf.zhuModel.order_info;
//            weakSelf.erWeiMaView.mainImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:130 red:0 green:0 blue:1];
            weakSelf.erWeiMaView.mainImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:180 red:0 green:0.658 blue:1];
            weakSelf.erWeiMaView.hidden = NO;
        };
    }
    return _orderDetailHeaderView;
}
-(ErWeiMaView *)erWeiMaView
{
    if (!_erWeiMaView) {
        _erWeiMaView = [[ErWeiMaView alloc]init];
        _erWeiMaView.hidden = YES;
        [self.view addSubview:_erWeiMaView];
        [self.view bringSubviewToFront:_erWeiMaView];
    }
    return _erWeiMaView;
}

#pragma mark - 解锁单
-(void)suoDanSwitchChick:(UISwitch *)sender
{
    
    if (sender.on == YES) {
//        if (_shiFouKeXiugai == NO) {
//            [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//            sender.on = NO;
//            return;
//        }
        [self postSuoDanWithModel:self.chuanzhiModel];
    }else
    {
        
//        if (_shiFouKeXiugai == NO) {
//            [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//            sender.on = YES;
//            return;
//        }
        if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
            [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:2];
            sender.on = YES;
            return;
        }
        
        [self postjieSuoWithModel:self.chuanzhiModel];
    }
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-60) style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.orderDetailHeaderView;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        [self.view addSubview:_mainTableView];
        
    }
    return _mainTableView;
}

-(void)loadNewData0
{
    [self.mainTableView.mj_header endRefreshing];
    [self setrequest_methodwithOrdercodevarchar:self.chuanzhiModel];
    [self postRequest_methodWithModel:self.chuanzhiModel];
    
    [self postpeiJianMingXiWithModel:self.chuanzhiModel withTiaoZhua:NO With:nil];
    [self postrequest_methodMingXiWithModel:self.chuanzhiModel withTiaoZhua:NO With:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 4;
    }else if(section == 0)
    {
        return _xiangMuMingXiArray.count;
    }else if(section == 1)
    {
        return _peiJianMingXiArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString *myIdentifier = @"Cell";
        OrderDetailCell1 *cell = (OrderDetailCell1 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.youImageView.hidden = YES;
        if (indexPath.row == 0) {
            cell.zuoLabel.text = @"最近修改";
            cell.youLabel.text = [NSString stringWithFormat:@"%@",self.zhuModel.pre_holder];
        }else if (indexPath.row == 1) {
            cell.zuoLabel.text = @"订单来源";
//            1线上下单 2 后台创建 3 app
            Order_info *model = (Order_info *)self.zhuModel.order_info;
            cell.youImageView.hidden = NO;
            if ([model.create_type isEqualToString:@"1"]) {
                cell.youLabel.text = @"线上下单";
                cell.youImageView.image = DJImageNamed(@"source_weixin");
            }else if([model.create_type isEqualToString:@"2"])
            {
                cell.youLabel.text = @"后台";
                cell.youImageView.image = DJImageNamed(@"source_pc");
            }else if([model.create_type isEqualToString:@"3"])
            {
                cell.youLabel.text = @"APP";
                cell.youImageView.image = DJImageNamed(@"source_app");
            }
            cell.youLabel.textColor = [UIColor blackColor];
        }else if (indexPath.row == 2) {
            cell.zuoLabel.text = @"订单持有人";
            cell.youLabel.text = @"查看";
            cell.youLabel.textColor = kZhuTiColor;
            
        }else if (indexPath.row == 3) {
            cell.zuoLabel.text = @"客户信息";
            cell.youLabel.text = @"查看";
            cell.youLabel.textColor = kZhuTiColor;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 0)
    {
        static NSString *myIdentifier = @"Cell2";
        OrderDetailCell2 *cell = (OrderDetailCell2 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:_xiangMuMingXiArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else  if(indexPath.section == 1)
    {
        static NSString *myIdentifier = @"Cell3";
        OrderDetailCell2 *cell = (OrderDetailCell2 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refelesePeiJianWithModel:_peiJianMingXiArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 40;
    }else
    {
        return 130;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 100;
    }else{
       return 95;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            UIAlertView *artView = [[UIAlertView alloc]initWithTitle:@"订单持有人" message:self.zhuModel.holder_info delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [artView show];
        }
        if (indexPath.row == 3) {
            CustomerInformationView *visq = [[CustomerInformationView alloc]init];
            [self.view addSubview:visq];
            [self.view bringSubviewToFront:visq];
            [visq setYeMianWithOrderDetailModel:self.zhuModel];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = kRGBColor(244, 245, 246);
    if (section == 0) {
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 37)];
        backV.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:backV];
//        backV.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
//        backV.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        backV.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//        backV.layer.cornerRadius = 3;
        
        UIImageView *zuoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"xiangmu_icon")];
        [backV addSubview:zuoImageView];
        [zuoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(20);
            make.centerY.mas_equalTo(backV);
        }];
        
        UILabel *shuomLa = [[UILabel alloc]init];
        shuomLa.font = [UIFont systemFontOfSize:14];
        shuomLa.text = @"项目明细";
        [backV addSubview:shuomLa];
        [shuomLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(backV);
        }];
        
        UIImageView *biaoJi = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_arrow_down")];
        [backV addSubview:biaoJi];
        [biaoJi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(10);
            make.centerY.mas_equalTo(backV);
        }];
        
        if (_xiangMuMingXiibool) {
            [UIView animateWithDuration:0.2 animations:^{
                biaoJi.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                biaoJi.transform = CGAffineTransformMakeRotation(0);
            } completion:^(BOOL finished) {
            }];
        }
        
        UIButton *xiangXiaZhanShibt = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, kWindowW-100, 38)];
        [xiangXiaZhanShibt addTarget:self action:@selector(xiangXiaZhanShibtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [backV addSubview:xiangXiaZhanShibt];
        
        
        
        UIButton *guanLibt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWindowW/2, 40)];
        [guanLibt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        guanLibt.backgroundColor = [UIColor whiteColor];
        guanLibt.titleLabel.font = [UIFont systemFontOfSize:14];
        [guanLibt setTitle:@"管理方案" forState:(UIControlStateNormal)];
        [guanLibt addTarget:self action:@selector(guanLibtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headerView addSubview:guanLibt];
        
        UIButton *guanLibt2 = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW/2, 0, kWindowW/2, 40)];
        [guanLibt2 setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        guanLibt2.backgroundColor = [UIColor whiteColor];
        [guanLibt2 setTitle:@"选择施工人员" forState:(UIControlStateNormal)];
        [guanLibt2 addTarget:self action:@selector(xuanZeShiGongBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        guanLibt2.titleLabel.font = [UIFont systemFontOfSize:14];
        [headerView addSubview:guanLibt2];
        
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 1)];
        line.backgroundColor = kLineBgColor;
        [headerView addSubview:line];
    }else if(section == 1){
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 37)];
        backV.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:backV];
//        backV.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
//        backV.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        backV.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//        backV.layer.cornerRadius = 3;
        
        UIImageView *zuoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"peijian_icon")];
        [backV addSubview:zuoImageView];
        [zuoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(20);
            make.centerY.mas_equalTo(backV);
        }];
        
        UILabel *shuomLa = [[UILabel alloc]init];
        shuomLa.font = [UIFont systemFontOfSize:14];
        shuomLa.text = @"配件明细";
        [backV addSubview:shuomLa];
        [shuomLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(zuoImageView.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(backV);
        }];
        
        UIImageView *biaoJi = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_arrow_down")];
        [backV addSubview:biaoJi];
        [biaoJi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(10);
            make.centerY.mas_equalTo(backV);
        }];
        if (_peiJianMingXibool) {
            [UIView animateWithDuration:0.2 animations:^{
                biaoJi.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                biaoJi.transform = CGAffineTransformMakeRotation(0);
            } completion:^(BOOL finished) {
            }];
        }
        
        UIButton *xiangXiaZhanShibt2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, kWindowW-100, 38)];
        [xiangXiaZhanShibt2 addTarget:self action:@selector(xiangXiaZhanShibt2Chick:) forControlEvents:(UIControlEventTouchUpInside)];
        [backV addSubview:xiangXiaZhanShibt2];
        
        
        
        UIButton *guanLibt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWindowW/2, 40)];
        [guanLibt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
        guanLibt.titleLabel.font = [UIFont systemFontOfSize:14];
        guanLibt.backgroundColor = [UIColor whiteColor];
        [guanLibt addTarget:self action:@selector(guanLiPeiJianbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [guanLibt setTitle:@"管理配件" forState:(UIControlStateNormal)];
        [headerView addSubview:guanLibt];
        
        UIView *buView = [[UIView alloc]initWithFrame:CGRectMake(kWindowW/2, 0, kWindowW/2, 40)];
        buView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:buView];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 1)];
        line.backgroundColor = kLineBgColor;
        [headerView addSubview:line];
    }else if(section == 2){
        UILabel *la = [[UILabel alloc]init];
        la.text = @"施工信息";
        la.font = [UIFont systemFontOfSize:14];
        la.textColor = [UIColor grayColor];
        [headerView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(25);
        }];
        
        self.zuoYouScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kWindowW, 70)];
        self.zuoYouScrollView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:self.zuoYouScrollView];
        
        [self zuoYouScrollViewBuju];
        
    }
    
    return headerView;
}

-(void)guanLiPeiJianbtChick:(UIButton *)sender
{
    if (_shiFouKeXiugai == NO) {
        [self showAlertViewWithTitle:nil Message:@"手动出库中" buttonTitle:@"确定"];
        return;
    }
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:1];
        return;
    }
    
    if (_peiJianMingXiArrayCun.count<=0) {
        
        [self postpeiJianMingXiWithModel:self.chuanzhiModel withTiaoZhua:YES With:nil];
    }else
    {
        PartsSubsidiaryViewController * vc = [[PartsSubsidiaryViewController alloc]init];
        vc.suerViewController = self;
        vc.ordercode = self.chuanzhiModel.ordercode;
        vc.chuanRuArray = _peiJianMingXiArrayCun;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)guanLibtChick:(UIButton *)sender
{
//    if (_shiFouKeXiugai == NO) {
//        [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//        return;
//    }
    
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:1];
        return;
    }
    
    if (_xiangMuMingXiArrayCun.count<=0) {
        
        [self postrequest_methodMingXiWithModel:self.chuanzhiModel withTiaoZhua:YES With:nil];
    }else
    {
        ProjectDetailsViewController * vc = [[ProjectDetailsViewController alloc]init];
        vc.suerViewController = self;
        vc.ordercode = self.chuanzhiModel.ordercode;
        vc.chuanRuArray = _xiangMuMingXiArrayCun;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)xuanZeShiGongBtChick:(UIButton *)sender
{
//    if (_shiFouKeXiugai == NO) {
//        [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//        return;
//    }
    
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0){
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:1];
        return;
    }
    
    if (_xiangMuMingXiArrayCun.count<=0) {
        
        ConstructionPersonnelViewController * vc = [[ConstructionPersonnelViewController alloc]init];
        [self postrequest_methodMingXiWithModel:self.chuanzhiModel withTiaoZhua:YES With:vc];
    }else
    {
        ConstructionPersonnelViewController * vc = [[ConstructionPersonnelViewController alloc]init];
        vc.suerViewController = self;
        vc.ordercode = self.chuanzhiModel.ordercode;
        if (_xiangMuMingXiArrayCun.count>0) {
            vc.chuanRuArray = _xiangMuMingXiArrayCun;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            [self showMessageWindowWithTitle:@"请先添加项目" point:self.view.center delay:1];
        }
        
    }
}

-(void)zuoYouScrollViewBuju
{
    while ([self.zuoYouScrollView.subviews lastObject] != nil)
    {
        [(UIView*)[self.zuoYouScrollView.subviews lastObject] removeFromSuperview];
    }
    
    
    UIView *shangDingVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    [self.zuoYouScrollView addSubview:shangDingVIew];
    
    UIButton *tianJianbt = [[UIButton alloc]init];
    [tianJianbt setImage:DJImageNamed(@"add_new_photo") forState:(UIControlStateNormal)];
    [shangDingVIew addSubview:tianJianbt];
    [tianJianbt addTarget:self action:@selector(tianJianbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [tianJianbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(5);
        make.bottom.right.mas_equalTo(-5);
    }];
    
    for (int i = 1; i<self.zhuModel.media_images.count+1;i++ ) {
        NSString *modelStr = self.zhuModel.media_images[i-1];
        UIView *diangWeiViwe = [[UIView alloc]initWithFrame:CGRectMake(70*i+5, 5, 65, 60)];
//        diangWeiViwe.backgroundColor = [UIColor blackColor];
        [self.zuoYouScrollView addSubview:diangWeiViwe];
        
        UIImageView *zhuIm = [[UIImageView alloc]init];
        zhuIm.contentMode = UIViewContentModeScaleAspectFit;
        [diangWeiViwe addSubview:zhuIm];
        [zhuIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
//        if (model.url) {
//            UIImageView *playImageVeiw = [[UIImageView alloc]initWithImage:DJImageNamed(@"play")];
//            [diangWeiViwe addSubview:playImageVeiw];
//            [playImageVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.top.mas_equalTo(10);
//                make.bottom.right.mas_equalTo(-10);
//            }];
//            
//            zhuIm.image = [UIImage imageWithVieo:model.url];
//        }else
//        {
//            zhuIm.image = model.cunImage;
//        }
        if (self.bengDiArray.count>=1) {
            if ([self.bengDiArray[i-1] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *newDict = self.bengDiArray[i-1];
                zhuIm.image = KISDictionaryHaveKey(newDict, @"benDiTuPian");
            }else{
                [zhuIm  sd_setImageWithURL:[NSURL URLWithString:modelStr] placeholderImage:DJImageNamed(@"jiaZaiZhong")];
            }
        }else{
            [zhuIm  sd_setImageWithURL:[NSURL URLWithString:modelStr] placeholderImage:DJImageNamed(@"jiaZaiZhong")];
        }
        
        
        
        UIImageView *guanBiIm = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_clear_image_normal")];
        [diangWeiViwe addSubview:guanBiIm];
        [guanBiIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.height.mas_equalTo(20);
        }];
        
        UIButton *tuPianYLbt = [[UIButton alloc]init];
        tuPianYLbt.tag = YULANTAG + i-1;
        [diangWeiViwe addSubview:tuPianYLbt];
        [tuPianYLbt addTarget:self action:@selector(tuPianYLbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [tuPianYLbt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UIButton *guanbiBt = [[UIButton alloc]init];
        [diangWeiViwe addSubview:guanbiBt];
        guanbiBt.tag = GUANBITAG  + i-1;
        [guanbiBt addTarget:self action:@selector(guanbiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [guanbiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
    }
    self.zuoYouScrollView.contentSize = CGSizeMake((self.zhuModel.media_images.count+1)*70, 70);
    
    
}

-(void)tianJianbtChick:(UIButton *)sender
{
//    if (_shiFouKeXiugai == NO) {
//        [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//        return;
//    }
    
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:2];
        return;
    }
    
    
    if (self.zhuModel.media_images.count>8) {
        [self showMessageWithContent:@"最多8张" point:self.view.center afterDelay:2.0];
        return;
    }
    
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"小视频" otherButtonTitles:@"拍照", nil];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:nil];
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0) {
//        [self selectImageFromCameraWithVideo:YES];
//    }
//    if (buttonIndex == 1) {
//        [self selectImageFromCameraWithVideo:NO];
//    }
    if (buttonIndex == 0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"未获取到权限" message:@"请前往手机设置－车店长－相机－打开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            alert.tag = 103;
            [alert show];
            return;
        }
        [self selectImageFromCameraWithVideo:NO];
    }
}
#pragma mark - 图片预览
-(void)tuPianYLbtChick:(UIButton *)sender
{
    NSInteger index = sender.tag - YULANTAG;
//    CarInspectionModel *model = self.wenTiArray[index];
//    if (model.url) {
//        MPMoviePlayerViewController*play = [[MPMoviePlayerViewController alloc]initWithContentURL:model.url];
//        [self presentViewController:play animated:YES completion:nil];
//    }else
//    {
//        PreviewPictureViewController *vc = [[PreviewPictureViewController alloc]init];
//        vc.shiFouZhanShi = YES;
//        vc.chuRuMoel = self.wenTiArray[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    PreviewPictureViewController *vc = [[PreviewPictureViewController alloc]init];
    vc.shiFouZhanShi = YES;
    CarInspectionModel *model = [[CarInspectionModel alloc]init];
    model.urlDiZhi = self.zhuModel.media_images[index];
//    vc.chuRuMoel = model;
    vc.tuPianArray = self.zhuModel.media_images;
    vc.index = index;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)guanbiBtChick:(UIButton *)sender
{
//    if (_shiFouKeXiugai == NO) {
//        [self showAlertViewWithTitle:nil Message:@"该用户不能操作此单" buttonTitle:@"确定"];
//        return;
//    }
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:1];
        return;
    }
    
    
    NSInteger index = sender.tag - GUANBITAG;
    NSString *shanImage = @"";
    for (int i = 0; i<self.zhuModel.media_images.count; i++) {
        if (![self.zhuModel.media_images[i] isEqualToString:self.zhuModel.media_images[index]]) {
            if (shanImage.length>0) {
                shanImage = [NSString stringWithFormat:@"%@,%@",shanImage,self.zhuModel.media_images[i]];
            }else
            {
                shanImage = self.zhuModel.media_images[i];
            }
        }
    }
    [self shanChuShiGongTuPian:self.chuanzhiModel withImage:shanImage];
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCameraWithVideo:(BOOL)video
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if (video == YES) {
        if ([UIImagePickerController
             isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSArray *availableMediaTypes = [UIImagePickerController
                                            availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            if ([availableMediaTypes containsObject:(NSString *)kUTTypeMovie]) {
                // 支持视频录制
                imagePickerController.delegate = self;
                imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
            }else
            {
                return;
            }
        }
        
    }else{
        
        imagePickerController.delegate = self;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else if([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie])
    {
        // 如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        // 获取视频总时长
        CGFloat lengthTime = [self getVideoLength:url];
        if (lengthTime >15.0f) {
            [self showAlertViewWithTitle:nil Message:@"只能上传15s内的视频" buttonTitle:@"确定"];
            return;
        }
        
        NSLog(@"%f",lengthTime);
        // 保存视频至相册 (异步线程)
        NSString *urlStr = [url path];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                
                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
            
        });
        
        AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
        NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
        
        if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality])
            
        {
            
            AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetPassthrough];
            NSString *exportPath = [NSString stringWithFormat:@"%@/%@.mp4",
                                    [NSHomeDirectory() stringByAppendingString:@"/tmp"],
                                    @"1"];
            exportSession.outputURL = [NSURL fileURLWithPath:exportPath];
            NSLog(@"%@", exportPath);
            exportSession.outputFileType = AVFileTypeMPEG4;
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                
                switch ([exportSession status]) {
                    case AVAssetExportSessionStatusFailed:
                        NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                        break;
                    case AVAssetExportSessionStatusCancelled:
                        NSLog(@"Export canceled");
                        break;
                    case AVAssetExportSessionStatusCompleted:
                        NSLog(@"转换成功");
                        break;
                    default:
                        break;
                }
            }];
        }
        
        //压缩视频
        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //视频上传
        [self shangChuanVideos:videoData withUrl:url];
        
    }
}

-(NSMutableArray *)bengDiArray
{
    if (!_bengDiArray) {
        _bengDiArray = [[NSMutableArray alloc]init];
    }
    return _bengDiArray;
}

-(void)image:(UIImage *)imaeg didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary *)info
{
    [self.bengDiArray removeAllObjects];
    if (self.zhuModel.media_images.count>0) {
        for (int i = 0; i<self.zhuModel.media_images.count; i++) {
            [self.bengDiArray addObject:self.zhuModel.media_images[i]];
        }
    }
    NSMutableDictionary  *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:imaeg forKey:@"benDiTuPian"];
    [self.bengDiArray addObject:dict];
    
    NSArray *array = @[imaeg];
    
    [self shangtuPian:array withImage:imaeg];
}
#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextIn {
    if (error) {
        NPrintLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NPrintLog(@"视频保存成功.");
        [self showMessageWindowWithTitle:@"视频保存成功" point:self.view.center delay:1];
    }
}


#pragma mark -  项目明细按钮
/**
 项目明细按钮

 @param sender 按钮
 */
-(void)xiangXiaZhanShibtChick:(UIButton *)sender
{

    _xiangMuMingXiibool = !_xiangMuMingXiibool;
    
    if (_xiangMuMingXiibool) {
        if (_xiangMuMingXiArrayCun.count<=0) {
            [self postrequest_methodMingXiWithModel:self.chuanzhiModel withTiaoZhua:NO With:nil];
        }else
        {
            [_xiangMuMingXiArray removeAllObjects];
            for (int i = 0; i<_xiangMuMingXiArrayCun.count; i++) {
                [_xiangMuMingXiArray addObject:_xiangMuMingXiArrayCun[i]];
            }
            [self.mainTableView reloadData];
        }
    }else
    {
        [_xiangMuMingXiArray removeAllObjects];
        [self.mainTableView reloadData];
    }
    
}

-(void)xiangXiaZhanShibt2Chick:(UIButton *)sender
{

    
    _peiJianMingXibool = !_peiJianMingXibool;
    
    if (_peiJianMingXibool) {
        if (_peiJianMingXiArrayCun.count<=0) {
            [self postpeiJianMingXiWithModel:self.chuanzhiModel withTiaoZhua:NO With:nil];
        }else
        {
            [_peiJianMingXiArray removeAllObjects];
            for (int i = 0; i<_peiJianMingXiArrayCun.count; i++) {
                [_peiJianMingXiArray addObject:_peiJianMingXiArrayCun[i]];
            }
            [self.mainTableView reloadData];
        }
    }else
    {
        [_peiJianMingXiArray removeAllObjects];
        [self.mainTableView reloadData];
    }
}


#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
   
    NPrintLog(@"notification上不去%@",notification);
//    NSDictionary * userInfo2 = (NSDictionary *)notification;
//    userInfo2 = [notification userInfo];
    NSDictionary * userInfo = [notification userInfo];
    NPrintLog(@"%@",userInfo);
    
    NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
    
    if (![extras isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([KISDictionaryHaveKey(extras, @"is_ait") boolValue] == YES) {
        if ([self.chuanzhiModel.ordercode isEqualToString:KISDictionaryHaveKey(extras, @"ordercode")]) {
            UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
            artView.tag = 200;
            [artView show];
            self.tiaoZhuanordercode = KISDictionaryHaveKey(extras, @"ordercode");
        }
    }
    
}

@end
