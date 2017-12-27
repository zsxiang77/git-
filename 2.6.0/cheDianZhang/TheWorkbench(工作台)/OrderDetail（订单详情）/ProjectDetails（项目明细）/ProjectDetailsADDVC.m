//
//  ProjectDetailsADDVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDVC.h"
#import "ProjectDetailsADDErVC.h"
#import "ProjectDetailsViewController.h"

@interface ProjectDetailsADDVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *main_tableView;

@end

@implementation ProjectDetailsADDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加维修项目" withBackButton:YES];
    changArray = [[NSMutableArray alloc]init];
    fenLeiArray = @[@"车身部分",@"车身电器",@"发动机",@"悬挂系统",@"传动系统",@"转向系统",@"空调系统",@"烤漆美容",@"制动系统",@"整车保养",@"钣金",@"制动系统"];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
    [self.main_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    
    [self huoQuChangYong];
    
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return changArray.count;
    }else{
        return fenLeiArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        NSDictionary *dict = changArray[indexPath.row];
        cell.textLabel.text = KISDictionaryHaveKey(dict, @"name");
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = fenLeiArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        ProjectDetailsADDErVC *vc = [[ProjectDetailsADDErVC alloc]init];
        vc.suerViewController = self.suerViewController;
        vc.mainClass = fenLeiArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0) {
        ProjectDetailsViewController *vc = (ProjectDetailsViewController *)self.suerViewController;
        NSDictionary *dict = changArray[indexPath.row];
        OrignalModel *model = [[OrignalModel alloc]init];
        [model setDangQIanWIthData:dict];
        
        model.subject = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
        model.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fee")];
        [vc.chuanRuArray addObject:model];
        [vc.main_tableView  reloadData];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}



#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NPrintLog(@"%@",userInfo);
    
    NSDictionary *extras = KISDictionaryHaveKey(userInfo, @"extras");
    
    if (![extras isKindOfClass:[NSDictionary class]]) {
        return;
    }
    ProjectDetailsViewController *vc = (ProjectDetailsViewController *)self.suerViewController;
    if ([KISDictionaryHaveKey(extras, @"is_ait") boolValue] == YES) {
        if ([vc.ordercode isEqualToString:KISDictionaryHaveKey(extras, @"ordercode")]) {
            UIAlertView  *artView = [[UIAlertView alloc]initWithTitle:nil message:KISDictionaryHaveKey(userInfo, @"content") delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
            artView.tag = 200;
            [artView show];
            self.tiaoZhuanordercode = KISDictionaryHaveKey(extras, @"ordercode");
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
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


@end
