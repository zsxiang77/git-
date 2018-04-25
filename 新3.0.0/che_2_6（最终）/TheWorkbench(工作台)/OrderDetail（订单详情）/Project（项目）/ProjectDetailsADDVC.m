//
//  ProjectDetailsADDVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDVC.h"
#import "OrderDetailProjectVC.h"
#import "OrderDetailModel.h"
#import "ProjectDetailsADDZDYVC.h"
#import "ProjectDetailsADDErVC.h"
#import "ProjectDetailsAddListTableViewCell.h"
#import "ProjectDetailSearchCell.h"
#import "ProjecAddProjectView.h"
@interface ProjectDetailsADDVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *main_tableView;
@property(nonatomic,strong)ProjecAddProjectView *projectDetailsChooseView;
@end

@implementation ProjectDetailsADDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加维修项目" withBackButton:YES];
    [self buildSearchView];
    UIButton *ziDingYiBt = [[UIButton alloc]init];
    ziDingYiBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [ziDingYiBt setTitle:@"自定义" forState:(UIControlStateNormal)];
    [ziDingYiBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    [ziDingYiBt addTarget:self action:@selector(ziDingYiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [m_baseTopView addSubview:ziDingYiBt];
    [ziDingYiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    changArray = [[NSMutableArray alloc]init];
    fenLeiArray = @[@"车身部分",@"车身电器",@"发动机",@"悬挂系统",@"传动系统",@"转向系统",@"空调系统",@"烤漆美容",@"制动系统",@"整车保养",@"钣金",@"制动系统"];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+63/2+10, kWindowW, kWindowH-kNavBarHeight-63/2-10) style:UITableViewStylePlain];
    [self.main_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    
    [self huoQuChangYong];
    
    
}

-(void)ziDingYiBtChick:(UIButton *)sender
{
    ProjectDetailsADDZDYVC *vc = [[ProjectDetailsADDZDYVC alloc]init];
    vc.suerViewController = self.suerViewController;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

-(void)huoQuChangYong{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_usual_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        [changArray removeAllObjects];
        for (int i = 0; i<dataDic.count; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"fee")] forKey:@"fee"];
            [dic setObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"id")] forKey:@"subject_id"];
            [dic setObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"name")] forKey:@"name"];
            [dic setObject:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"hour")] forKey:@"hour"];
            [changArray addObject:dic];
        }
        [weakSelf.main_tableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.main_tableView){
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.main_tableView){
        if (indexPath.section == 0) {
            return 65;
        }else{
            
            return 45;
        }
    }else{
        return 65;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView ==self.main_tableView){
        if (section == 0) {
            return changArray.count;
        }else{
            return fenLeiArray.count;
        }
    }else{
        return self.searchArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView ==self.main_tableView){
        if (indexPath.section == 0) {
            static NSString * dentifier = @"dentifier";
            ProjectDetailsAddListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
            if (cell == nil) {
                cell = [[ProjectDetailsAddListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dentifier];
            }
            [cell refelesePeiJianWithModel:changArray[indexPath.row]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = fenLeiArray[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            
            
        }
    }else{
        
        static NSString * dentifier = @"dentifier";
        ProjectDetailSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
        if (cell == nil) {
            cell = [[ProjectDetailSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dentifier];
        }
        [cell refelesePeiJianWithModel:self.searchArray[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        //        ProjectDetailsADDErVC *vc = [[ProjectDetailsADDErVC alloc]init];
        //        vc.suerViewController = self.suerViewController;
        //        vc.mainClass = fenLeiArray[indexPath.row];
        //        [self.navigationController pushViewController:vc animated:YES];
        self.dianJiClass = fenLeiArray[indexPath.row];
        [self huoQuFengLeiDataWithShuaX:YES shifouShow:YES];
    }
    if (indexPath.section == 0) {
        OrderDetailProjectVC *vc = (OrderDetailProjectVC *)self.suerViewController;
        NSDictionary *dict = changArray[indexPath.row];
        OrderDetailSubjectsModel *model = [[OrderDetailSubjectsModel alloc]init];
        [model setdataWithDict:dict];
        model.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fee")];
        [vc.tianJiaArray addObject:model];
        [vc.main_tabelView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(ProjecAddProjectView *)projectDetailsChooseView
{
    if (!_projectDetailsChooseView) {
        _projectDetailsChooseView = [[ProjecAddProjectView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        [self.view addSubview:_projectDetailsChooseView];
        _projectDetailsChooseView.main_tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        kWeakSelf(weakSelf)
        _projectDetailsChooseView.xuanZhongQueDingBlock = ^(NSArray *xuanZhongFanHuiArray) {
            if (xuanZhongFanHuiArray.count>0) {
                OrderDetailProjectVC *vc = (OrderDetailProjectVC *)weakSelf.suerViewController;
                for (int i = 0; i<xuanZhongFanHuiArray.count; i++) {
                    ProjecAddProjectSanModel *nebModel = xuanZhongFanHuiArray[i];
                    if (nebModel.sanJiArra.count>0){
                        for (int i = 0; i<nebModel.sanJiArra.count; i++) {
                            NSDictionary *dict = nebModel.sanJiArra[i];
                            OrderDetailSubjectsModel *model = [[OrderDetailSubjectsModel alloc]init];
                            [model setdataWithDict:dict];
                            model.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fee")];
                            [vc.tianJiaArray addObject:model];
                        }
                    }else{
                        NSDictionary *dictNe = nebModel.zhuDict;
                        NSDictionary *dict = KISDictionaryHaveKey(dictNe, @"data");
                        OrderDetailSubjectsModel *model = [[OrderDetailSubjectsModel alloc]init];
                        [model setdataWithDict:dict];
                        model.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fee")];
                        [vc.tianJiaArray addObject:model];
                    }
                }
                [vc.main_tabelView reloadData];
                weakSelf.projectDetailsChooseView.hidden = YES;
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf showMessageWindowWithTitle:@"没选中" point:weakSelf.view.center delay:1];
            }
        };
        _projectDetailsChooseView.diSanJiArrayBlcok = ^(NSMutableDictionary *chuanDict, ProjecAddProjectSanModel *dict) {
            [weakSelf huoQuSanChangYongWithDict:chuanDict withProjecAddProjectSanModel:dict];
        };
    }
    return _projectDetailsChooseView;
}

#pragma mark - 获取第三级
-(void)huoQuSanChangYongWithDict:(NSMutableDictionary *)dict2 withProjecAddProjectSanModel:(ProjecAddProjectSanModel *)xiuGaiModel{
    NSDictionary *dict = KISDictionaryHaveKey(dict2, @"data");
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:KISDictionaryHaveKey(dict, @"subject_id") forKey:@"subject_id"];
    [mDict setObject:@"1" forKey:@"page"];
    [mDict setObject:KISDictionaryHaveKey(dict, @"next_num") forKey:@"pagesize"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_package_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject){
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSArray *array = KISDictionaryHaveKey(dataDic, @"list");
        if (![array isKindOfClass:[NSArray class]]) {
            return;
        }
        [dict2 setObject:@"1" forKey:@"xuanZhong"];
        xiuGaiModel.sanJiArra = array;
        [weakSelf.projectDetailsChooseView.main_tableView reloadData];
    } failure:^(id error) {
        
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView ==self.main_tableView){
        UIView *headerV = [[UIView alloc]init];
        headerV.backgroundColor = kRGBColor(240, 240, 240);
        UILabel *la = [[UILabel alloc]init];
        la.font = [UIFont systemFontOfSize:14];
        la.textColor = [UIColor grayColor];
        [headerV addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        if (section == 0) {
            la.text = @"常用";
        }else{
            la.text = @"分类";
        }
        return headerV;
    }else{
        UIView *headerV = [[UIView alloc]init];
        UILabel *seaLabel = [[UILabel alloc]init];
        seaLabel.font = [UIFont systemFontOfSize:14];
        seaLabel.textColor = kRGBColor(51, 51, 51);
        seaLabel.text = @"搜索结果";
        [headerV addSubview:seaLabel];
        [seaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(headerV);
        }];
        return headerV;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.main_tableView){
        return 35;
    }else{
        return 40;
    }
}
//搜索
-(UITableView *)seachTableView
{
    if (!_seachTableView) {
        self.searchArray = [[NSMutableArray alloc]init];
        _seachTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+63/2+10, kWindowW, kWindowH-(kNavBarHeight+(63/2+10))) style:(UITableViewStylePlain)];
        _seachTableView.backgroundColor = [UIColor whiteColor];
        _seachTableView.delegate = self;
        _seachTableView.dataSource = self;
        _seachTableView.hidden = YES;
        _seachTableView.bounces =NO;
        _seachTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_seachTableView];
        [self.view bringSubviewToFront:_seachTableView];
    }
    return _seachTableView;
}
//侧边view7
-(void)loadNewData0
{
    [self huoQuFengLeiDataWithShuaX:YES shifouShow:NO];
}

-(void)huoQuFengLeiDataWithShuaX:(BOOL)shuaXin shifouShow:(BOOL)str{
    if (shuaXin == YES) {
        self.projectDetailsChooseView.page = 1;
    }
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.dianJiClass forKey:@"class"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)self.projectDetailsChooseView.page] forKey:@"page"];
    [mDict setObject:@"20" forKey:@"pagesize"];
    [self.projectDetailsChooseView.main_tableView.mj_footer endRefreshing];
    [self.projectDetailsChooseView.main_tableView.mj_header endRefreshing];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_cid_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (shuaXin == YES) {
            [weakSelf.projectDetailsChooseView.mainArrary removeAllObjects];
        }
        if (str == YES) {
            [weakSelf.projectDetailsChooseView showView];
            weakSelf.projectDetailsChooseView.mainClass =weakSelf.dianJiClass;
            [weakSelf.view bringSubviewToFront:weakSelf.projectDetailsChooseView];
        }
        NSArray *arrary = KISDictionaryHaveKey(dataDic, @"list");
        if (arrary.count<20) {
            weakSelf.projectDetailsChooseView.main_tableView.mj_footer = nil;
        }else
        {
            weakSelf.projectDetailsChooseView.main_tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                weakSelf.projectDetailsChooseView.page ++;
                [weakSelf huoQuFengLeiDataWithShuaX:NO shifouShow:NO];
            }];
        }
        
        for (int i = 0; i<arrary.count; i++) {
            ProjecAddProjectSanModel *model = [[ProjecAddProjectSanModel alloc]init];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:arrary[i] forKey:@"data"];
            [dict setObject:@"0" forKey:@"xuanZhong"];
            model.zhuDict = dict;
            [weakSelf.projectDetailsChooseView.mainArrary addObject:model];
        }
        
        
        [weakSelf.projectDetailsChooseView.main_tableView reloadData];
        
    } failure:^(id error) {
        
    }];
}










#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    //
    //    NSDictionary * userInfo = [notification userInfo];
    //    NPrintLog(@"%@",userInfo);
    //
    //    NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
    //
    //    if (![extras isKindOfClass:[NSDictionary class]]) {
    //        return;
    //    }
    //    ProjectDetailsViewController *vc = (ProjectDetailsViewController *)self.suerViewController;
    //    if ([KISDictionaryHaveKey(extras, @"is_ait") boolValue] == YES) {
    //        if ([vc.ordercode isEqualToString:KISDictionaryHaveKey(extras, @"ordercode")]) {
    //            UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
    //            artView.tag = 200;
    //            [artView show];
    //            self.tiaoZhuanordercode = KISDictionaryHaveKey(extras, @"ordercode");
    //        }
    //    }
    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 200) {
//        if (buttonIndex != alertView.cancelButtonIndex) {
//            NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
//            [mDict setObject:self.tiaoZhuanordercode forKey:@"ordercode"];
//
//            kWeakSelf(weakSelf)
//            [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/order_report" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
//
//                if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
//
//                    AITHTMLViewController *vc = [[AITHTMLViewController alloc]init];
//                    NSArray* dataDic = kParseData(responseObject);
//                    if (![dataDic isKindOfClass:[NSArray class]]) {
//                        return;
//                    }
//                    vc.chuanZhiArray = dataDic;
//                    [weakSelf.navigationController pushViewController:vc animated:YES];
//                }else
//                {
//                    [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
//                }
//
//            } failure:^(id error) {
//
//            }];
//        }
//    }
//}


@end

