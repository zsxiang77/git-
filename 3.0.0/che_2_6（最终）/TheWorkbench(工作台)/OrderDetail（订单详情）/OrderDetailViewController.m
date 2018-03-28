//
//  OrderDetailViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "MJChiBaoZiHeader.h"
#import "OrderDetailErWeiView.h"
#import "UIImage+Video.h"
#import "OrderDetailProjectVC.h"
#import "AITIntroduceViewController.h"
#import "AITBaoGaoListVC.h"
#import "OrderDetailGuZhangCell.h"
#import "OrderDetailGuZhangQiTaCell.h"
#import "AITIntroduceViewController.h"

#import "CarInspectionViewController.h"
#import "AccessoryEquipmentVC.h"
#import "FunctionalCheckViewController.h"
#import "PerfectInfoViewController.h"
#import "CarCheckModel.h"
#import "AITCheckViewController.h"
#import "AccessoriesViewController.h"
#import "ViewPerfectInformationVC.h"


@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)OrderDetailErWeiView *orderDetailErWeiView;
@property(nonatomic,assign)BOOL    shiFouGuZhangZhan;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"工单详情" withBackButton:YES];
    
    self.shiFouGuZhangZhan = YES;
    
    self.mainDataArray = [[NSMutableArray alloc]init];
    
    UIButton *erweiBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-35, 24, 25, 25)];
    [erweiBt addTarget:self action:@selector(erweiBtChcik:) forControlEvents:(UIControlEventTouchUpInside )];
    [erweiBt setBackgroundImage:DJImageNamed(@"Detail_erWeiMa") forState:(UIControlStateNormal)];
    [m_baseTopView addSubview:erweiBt];
    
    UIButton *okButton = [[UIButton alloc]init];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [okButton.layer setCornerRadius:3];
    [okButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [okButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-13);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *tianJianBt = [[UIButton alloc]init];
    [tianJianBt setBackgroundImage:DJImageNamed(@"order_xiangMu_add") forState:(UIControlStateNormal)];
    [tianJianBt addTarget:self action:@selector(tianJianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:tianJianBt];
    [tianJianBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-86);
        make.width.height.mas_equalTo(50);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self postorder_basicwithShuaXin:YES];
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJieShouXiaoXi object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:kJieShouXiaoXi object:nil];
}

-(void)erweiBtChcik:(UIButton *)sender
{
    if (!self.orderDetailErWeiView) {
        self.orderDetailErWeiView = [[OrderDetailErWeiView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        self.orderDetailErWeiView.hidden = YES;
        [self.view addSubview:self.orderDetailErWeiView];
    }
    if ([self.mainData isKindOfClass:[OrderDetailModel class]]) {
        self.orderDetailErWeiView.erWeiImageView.image  = [UIImage qrCodeImageWithContent:self.mainData.order_info.order_url codeImageSize:180 red:0 green:0 blue:0];
        [self.orderDetailErWeiView displayView];
        [self.view bringSubviewToFront:self.orderDetailErWeiView];
    }
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
        _main_tabelView.delegate = self;
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _main_tabelView.dataSource = self;
        _main_tabelView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}

-(void)loadNewData0
{
    [self postorder_basicwithShuaXin:YES];
}
-(OrderDetailHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[OrderDetailHeaderView alloc]init];
        _tableHeaderView.frame = CGRectMake(0, 0, kWindowW, 798/2);
        kWeakSelf(weakSelf)
        _tableHeaderView.aitTiaoZhuanBlcok = ^{
            [weakSelf aitTiaoZhuan];
        };
        _tableHeaderView.aitjieShaoBtChickBlock = ^{
            AITIntroduceViewController *vc = [[AITIntroduceViewController alloc]init];
            vc.shiFouGouMai = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _tableHeaderView.wanShanXXiChcickBlock = ^{
            
            if ([weakSelf.mainData.order_info.order_status integerValue] == 1) {
                NSString *oredeco = weakSelf.chuanZhiModel.ordercode;
                
                PerfectInfoViewController *infoViewController = [[PerfectInfoViewController alloc] init];
                infoViewController.ordercode = oredeco;
                
                [weakSelf.navigationController pushViewController:infoViewController animated:YES];
            }else{
                ViewPerfectInformationVC *vc = [[ViewPerfectInformationVC alloc]init];
                vc.ordercode = weakSelf.chuanZhiModel.ordercode;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        };
        
        _tableHeaderView.tuijianXMChickBlcok = ^{
            MaintenanceProjectViewController *vc = [[MaintenanceProjectViewController alloc]init];
            vc.ordercode = weakSelf.mainData.order_info.ordercode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _tableHeaderView;
}
-(void)aitTiaoZhuan{
    if ([self.mainData.ait.ait_status isEqualToString:@"buy"]) {
        AITIntroduceViewController *vc = [[AITIntroduceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.mainData.ait.ait_status isEqualToString:@"unsupport"]) {
        return;
    }else if ([self.mainData.ait.ait_status isEqualToString:@"support"]) {
        NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/inspect_flow" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            NSDictionary* dataDic = kParseData(responseObject);
            CarCheckDataModel *dataModel = [CarCheckDataModel parseJSON:dataDic];
            [OrderInfoPushManager sharedOrderInfoPushManager].type = OrderInfoPushTypeOrderDetail;
            AITCheckViewController *vc = [[AITCheckViewController alloc]init];
            vc.carCheckDataModel = dataModel;
            vc.ordercode = weakSelf.chuanZhiModel.ordercode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        } failure:^(id error) {
            
        }];
        
        
    }else if ([self.mainData.ait.ait_status isEqualToString:@"done"]) {
        AITBaoGaoListVC *vc = [[AITBaoGaoListVC alloc]init];
        vc.ordercode = self.mainData.order_info.ordercode;
        vc.vin = self.mainData.order_info.vin;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mainDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.mainDataArray[section];
    NSString *panduan = dict[@"name"];
    if ([panduan isEqualToString:@"subjects"]) {
        if (self.mainData.subjects.count>0) {
            return 1;
        }else{
            return 0;
        }
    }else if ([panduan isEqualToString:@"protect_subjects"]) {
        if (self.mainData.protect_subjects.count>0) {
            return 1;
        }else{
            return 0;
        }
    }else if ([panduan isEqualToString:@"parts"]) {
        if (self.mainData.parts.count>0) {
            return 1;
        }else{
            return 0;
        }

    }else if ([panduan isEqualToString:@"services"]) {
        if (self.mainData.services.count>0) {
            return 1;
        }else{
            return 0;
        }
    }else if ([panduan isEqualToString:@"commods"]) {
        if (self.mainData.commods.count>0) {
            return 1;
        }else{
            return 0;
        }
    }else if ([panduan isEqualToString:@"repair_describe"]) {
        if (self.shiFouGuZhangZhan == YES) {
            NSArray *arra = dict[@"vely"];
            return arra.count;
        }else{
            return 0;
        }
        
    }else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.mainDataArray[indexPath.section];
    NSString *panduan = dict[@"name"];
    if ([panduan isEqualToString:@"subjects"]) {
        static NSString *myIdentifier = @"OrderDetailGuZhangQiTaCellxiang";
        OrderDetailGuZhangQiTaCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailGuZhangQiTaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithXianMuModel:self.mainData.subjects];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([panduan isEqualToString:@"protect_subjects"]) {
#warning 环保
        static NSString *myIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        return cell;
    }else if ([panduan isEqualToString:@"parts"]) {
        static NSString *myIdentifier = @"OrderDetailGuZhangQiTaCellpei";
        OrderDetailGuZhangQiTaCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailGuZhangQiTaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithPeiJianModel:self.mainData.parts];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([panduan isEqualToString:@"services"]) {
        static NSString *myIdentifier = @"OrderDetailGuZhangQiTaCellServices";
        OrderDetailGuZhangQiTaCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailGuZhangQiTaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithServicesModel:self.mainData.services];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([panduan isEqualToString:@"commods"]) {
        static NSString *myIdentifier = @"OrderDetailGuZhangQiTaCellCommods";
        OrderDetailGuZhangQiTaCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailGuZhangQiTaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithCommodsModel:self.mainData.commods];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([panduan isEqualToString:@"repair_describe"]) {
        static NSString *myIdentifier = @"OrderDetailGuZhangCell";
        OrderDetailGuZhangCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        NSArray *arra2 = dict[@"vely"];
        if (cell == nil)
            cell = [[OrderDetailGuZhangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:arra2[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *myIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.mainDataArray[indexPath.section];
    NSString *panduan = dict[@"name"];
    if ([panduan isEqualToString:@"subjects"]) {
        return self.mainData.subjects.count*50;
    }else if ([panduan isEqualToString:@"protect_subjects"]) {
        return self.mainData.protect_subjects.count*50;
    }else if ([panduan isEqualToString:@"parts"]) {
        return self.mainData.parts.count*50;
    }else if ([panduan isEqualToString:@"services"]) {
        return self.mainData.services.count*50;
    }else if ([panduan isEqualToString:@"commods"]) {
        return self.mainData.commods.count*50;
    }else if ([panduan isEqualToString:@"repair_describe"]) {
        NSArray *arra2 = dict[@"vely"];
        NSString *jisuanStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(arra2[indexPath.row], @"info")];
        CGSize wordSize = DAJIANG_MULTILINE_TEXTSIZE(jisuanStr, DJSystemFont(15), CGSizeMake(kWindowW-138, 200));
        
        return wordSize.height+50;
    }else{
        return 40;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *zhanShiIm = [[UIImageView alloc]init];
    zhanShiIm.contentMode =  UIViewContentModeScaleAspectFit;
    [headView addSubview:zhanShiIm];
    [zhanShiIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(headView);
        make.width.height.mas_equalTo(22);
    }];
    
    UILabel *zhanshiLabel = [[UILabel alloc]init];
    zhanshiLabel.font = [UIFont systemFontOfSize:16];
    zhanshiLabel.textColor = kRGBColor(102, 102, 102);
    [headView addSubview:zhanshiLabel];
    [zhanshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zhanShiIm.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(headView);
    }];
    
    UIImageView *jianTouIm = [[UIImageView alloc]init];
    jianTouIm.contentMode =  UIViewContentModeScaleAspectFit;
    [headView addSubview:jianTouIm];
    [jianTouIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(19);
        make.centerY.mas_equalTo(headView);
    }];
    
    UIButton *bt = [[UIButton alloc]init];
    [bt addTarget:self action:@selector(tiaoHuanXiuGaiChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setTitleColor:[UIColor clearColor] forState:(UIControlStateNormal)];
    [headView addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    line.hidden = NO;
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(10);
    }];
    
    UILabel *hejiLabel1 = [[UILabel alloc]init];
    hejiLabel1.font = [UIFont systemFontOfSize:14];
    hejiLabel1.textColor = kRGBColor(74, 74, 75);
    hejiLabel1.text = @"合计";
    hejiLabel1.hidden = YES;
    [headView addSubview:hejiLabel1];
    [hejiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zhanshiLabel.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(headView);
    }];
    
    UILabel *hejiLabel2 = [[UILabel alloc]init];
    hejiLabel2.font = [UIFont systemFontOfSize:14];
    hejiLabel2.textColor = [UIColor redColor];
    hejiLabel2.hidden = YES;
    [headView addSubview:hejiLabel2];
    [hejiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hejiLabel1.mas_right).mas_equalTo(3);
        make.centerY.mas_equalTo(headView);
    }];
    
    
    NSDictionary *dict = self.mainDataArray[section];
    NSString *panduan = dict[@"name"];
    if ([panduan isEqualToString:@"subjects"]) {
        zhanShiIm.image = DJImageNamed(@"ic_sa_info_project");
        zhanshiLabel.text = [NSString stringWithFormat:@"项目（%ld）",self.mainData.subjects.count];
        jianTouIm.hidden = NO;
        if ([self.mainData.order_info.order_status integerValue] == 1) {
            jianTouIm.image = DJImageNamed(@"back_btn-1");
        }else{
            jianTouIm.hidden = YES;
        }
        
        [bt setTitle:@"项目" forState:(UIControlStateNormal)];
        if (self.mainData.subjects.count>0) {
            line.hidden = YES;
        }
        hejiLabel1.hidden = NO;
        hejiLabel2.hidden = NO;
        hejiLabel2.text = [NSString stringWithFormat:@"¥%.2f",[self jiSuanSubjectsZongE]];
        
    }else if ([panduan isEqualToString:@"protect_subjects"]) {
        zhanShiIm.image = DJImageNamed(@"ic_sa_info_project");
        zhanshiLabel.text = [NSString stringWithFormat:@"环保项目（%ld）",self.mainData.protect_subjects.count];
        jianTouIm.image = DJImageNamed(@"back_btn-1");
        [bt setTitle:@"环保项目" forState:(UIControlStateNormal)];
        if (self.mainData.protect_subjects.count>0) {
            line.hidden = YES;
        }
    }else if ([panduan isEqualToString:@"parts"]) {
        zhanShiIm.image = DJImageNamed(@"ic_sa_info_parts");
        zhanshiLabel.text = [NSString stringWithFormat:@"配件（%ld）",self.mainData.parts.count];
        jianTouIm.hidden = NO;
        if ([self.mainData.order_info.order_status integerValue] == 1) {
            jianTouIm.image = DJImageNamed(@"back_btn-1");
        }else{
            jianTouIm.hidden = YES;
        }
        [bt setTitle:@"配件" forState:(UIControlStateNormal)];
        if (self.mainData.parts.count>0) {
            line.hidden = YES;
        }
        
        hejiLabel1.hidden = NO;
        hejiLabel2.hidden = NO;
        hejiLabel2.text = [NSString stringWithFormat:@"¥%.2f",[self jiSuanPartsZongE]];
    }else if ([panduan isEqualToString:@"services"]) {
        zhanShiIm.image = DJImageNamed(@"ic_sa_info_project");
        zhanshiLabel.text = [NSString stringWithFormat:@"项目（%ld）",self.mainData.services.count];
        jianTouIm.image = DJImageNamed(@"back_btn-1");
        [bt setTitle:@"洗美项目" forState:(UIControlStateNormal)];
        if (self.mainData.services.count>0) {
            line.hidden = YES;
        }
        jianTouIm.hidden = YES;
        hejiLabel1.hidden = NO;
        hejiLabel2.hidden = NO;
        hejiLabel2.text = [NSString stringWithFormat:@"¥%.2f",[self jiSuanServicesZongE]];
    }else if ([panduan isEqualToString:@"commods"]) {
        zhanShiIm.image = DJImageNamed(@"ic_sa_info_parts");
        zhanshiLabel.text = [NSString stringWithFormat:@"耗材（%ld）",self.mainData.commods.count];
        jianTouIm.image = DJImageNamed(@"back_btn-1");
        [bt setTitle:@"洗美配件" forState:(UIControlStateNormal)];
        if (self.mainData.commods.count>0) {
            line.hidden = YES;
        }
        jianTouIm.hidden = YES;
        hejiLabel1.hidden = NO;
        hejiLabel2.hidden = NO;
        hejiLabel2.text = [NSString stringWithFormat:@"¥%.2f",[self jiSuanCommodsZongE]];
    }else if ([panduan isEqualToString:@"repair_describe"]) {
        zhanShiIm.image = DJImageNamed(@"ic_sa_info_parts");
        zhanShiIm.tag = 3000;
        NSArray *arra = dict[@"vely"];
        zhanshiLabel.text = [NSString stringWithFormat:@"故障描述（%ld）",arra.count];
        jianTouIm.image = DJImageNamed(@"jiaoTou_DownUp");
        [bt setTitle:@"故障描述" forState:(UIControlStateNormal)];
        if (arra.count>0) {
            line.hidden = YES;
        }
        if (self.shiFouGuZhangZhan == YES) {
            [UIView animateWithDuration:0.2 animations:^{
                jianTouIm.transform = CGAffineTransformMakeRotation(0);
            } completion:^(BOOL finished) {
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                jianTouIm.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
            }];
        }
    }

    [headView bringSubviewToFront:bt];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(void)tiaoHuanXiuGaiChick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"故障描述"]) {
        self.shiFouGuZhangZhan = !self.shiFouGuZhangZhan;
        [self.main_tabelView reloadData];
        return;
    }else if ([sender.titleLabel.text isEqualToString:@"项目"]) {
        if ([self.mainData.order_info.order_status integerValue] == 1) {
            OrderDetailProjectVC *vc = [[OrderDetailProjectVC alloc]init];
            vc.chuanZhiArray = self.mainData.subjects;
            vc.ordercode = self.mainData.order_info.ordercode;
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }else if ([sender.titleLabel.text isEqualToString:@"环保项目"]) {
        return;
    }else if ([sender.titleLabel.text isEqualToString:@"配件"]) {
        if (self.mainData.is_hide_button == YES) {
            [self showAlertViewWithTitle:nil Message:@"手动出库中" buttonTitle:@"确定"];
            return;
        }
        if ([self.mainData.order_info.order_status integerValue] == 1) {
            AccessoriesViewController *vc = [[AccessoriesViewController alloc]init];
            vc.chuanZhiArray = self.mainData.parts;
            vc.ordercode = self.mainData.order_info.ordercode;
            [self.navigationController pushViewController:vc animated:YES];
        }
        return;
    }else if ([sender.titleLabel.text isEqualToString:@"洗美项目"]) {
        return;
    }else if ([sender.titleLabel.text isEqualToString:@"洗美配件"]) {
        return;
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
        if ([self.chuanZhiModel.ordercode isEqualToString:KISDictionaryHaveKey(extras, @"ordercode")]) {
            UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
            artView.tag = 200;
            [artView show];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 200) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            AITBaoGaoListVC *vc = [[AITBaoGaoListVC alloc]init];
            vc.ordercode = self.mainData.order_info.ordercode;
            vc.vin = self.mainData.order_info.vin;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
