//
//  ProjectDetailsADDErVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDErVC.h"
#import "ProjectDetailsADDErCell.h"
#import "ProjectDetailsADDSanVC.h"

@interface ProjectDetailsADDErVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *main_tableView;

@property(nonatomic,assign)NSInteger page;


@end

@implementation ProjectDetailsADDErVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加维修项目" withBackButton:YES];
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavBarHeight, kWindowW-20, 35)];
    la.font = [UIFont systemFontOfSize:14];
    la.text = @"项目名称";
    la.textColor = [UIColor grayColor];
    [self.view addSubview:la];
    
    
    self.mainArrary = [[NSMutableArray alloc]init];
    [self huoQuFengLeiDataWithShuaX:YES];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35-50) style:UITableViewStylePlain];
    self.main_tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kNavBarColor;
    [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-15);
    }];
    
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

-(void)queDingBtChick:(UIButton *)sender
{
    ProjectDetailsViewController *vc = (ProjectDetailsViewController *)self.suerViewController;
    
    for (int i = 0; i<self.mainArrary.count; i++) {
        NSMutableDictionary *dict = self.mainArrary[i];
        NSDictionary *duct2 = KISDictionaryHaveKey(dict, @"data");
        
        
        if ([KISDictionaryHaveKey(dict, @"xuanZhong") isEqualToString:@"1"]) {
            if ([KISDictionaryHaveKey(duct2, @"have_next") integerValue] == 1) {
                NSArray *array = KISDictionaryHaveKey(dict, @"array");
                for (int j =0; j<array.count; j++) {
                    OrignalModel *model2 = [[OrignalModel alloc]init];
                    NSDictionary *duct3 = array[j];
                    [model2 setDangQIanWIthData:duct3];
                    model2.subject = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(duct3, @"name")];
                    model2.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(duct3, @"fee")];
                    [vc.chuanRuArray addObject:model2];
                }
                
            }else
            {
                OrignalModel *model2 = [[OrignalModel alloc]init];
                [model2 setDangQIanWIthData:duct2];
                model2.subject = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(duct2, @"name")];
                model2.reality_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(duct2, @"fee")];
                [vc.chuanRuArray addObject:model2];
            }
        }
    }

    [vc.main_tableView  reloadData];

    [self.navigationController popToViewController:vc animated:YES];
}

-(void)loadNewData0
{
    [self huoQuFengLeiDataWithShuaX:YES];
}



-(void)huoQuFengLeiDataWithShuaX:(BOOL)shuaXin{
    if (shuaXin == YES) {
        self.page = 0;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.mainClass forKey:@"class"];
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    [mDict setObject:@"20" forKey:@"pagesize"];
    
    [self.main_tableView.mj_footer endRefreshing];
    [self.main_tableView.mj_header endRefreshing];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_cid_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (shuaXin == YES) {
            [weakSelf.mainArrary removeAllObjects];
        }
        
        NSArray *arrary = KISDictionaryHaveKey(dataDic, @"list");
        if (arrary.count<20) {
            weakSelf.main_tableView.mj_footer = nil;
        }else
        {
            weakSelf.main_tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                self.page ++;
                [weakSelf huoQuFengLeiDataWithShuaX:NO];
            }];
        }
        
        
        
        for (int i = 0; i<arrary.count; i++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:arrary[i] forKey:@"data"];
            [dict setObject:@"0" forKey:@"xuanZhong"];
            [weakSelf.mainArrary addObject:dict];
        }
        
        [weakSelf.main_tableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArrary.count;
     
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    ProjectDetailsADDErCell *cell = (ProjectDetailsADDErCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[ProjectDetailsADDErCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    NSMutableDictionary *dict = self.mainArrary[indexPath.row];
    NSDictionary *model = KISDictionaryHaveKey(dict, @"data");
    
    cell.model = model;
    
    if ([KISDictionaryHaveKey(dict, @"xuanZhong") isEqualToString:@"0"]) {
        cell.zuoImageView.image = DJImageNamed(@"cell_noselect");
    }else{
        cell.zuoImageView.image = DJImageNamed(@"cell_select");
    }
    
    if ([KISDictionaryHaveKey(model, @"have_next") integerValue] == 1) {
        cell.mainLabel.text = [NSString stringWithFormat:@"%@(共%@个小项目)",KISDictionaryHaveKey(model, @"name"),KISDictionaryHaveKey(model, @"next_num")];
        cell.sanJiBt.hidden = NO;
        kWeakSelf(weakSelf)
        cell.tiaoZhanSanJiBlock = ^(NSDictionary *dict) {
            [weakSelf huoQuSanChangYongWithDict:dict withShiFouTiaoZhuan:YES withXiuGaiDict:nil];
        };
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else
    {
        cell.mainLabel.text = KISDictionaryHaveKey(model, @"name");
        cell.sanJiBt.hidden = YES;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *dict = self.mainArrary[indexPath.row];
    if ([KISDictionaryHaveKey(dict, @"xuanZhong") isEqualToString:@"0"]) {
        [dict setObject:@"1" forKey:@"xuanZhong"];
        NSDictionary *model = KISDictionaryHaveKey(dict, @"data");
        if ([KISDictionaryHaveKey(model, @"have_next") integerValue] == 1) {
            [self huoQuSanChangYongWithDict:model withShiFouTiaoZhuan:NO withXiuGaiDict:dict];
        }
        
    }else{
        [dict setObject:@"0" forKey:@"xuanZhong"];
    }
    [self.main_tableView reloadData];
}

-(void)huoQuSanChangYongWithDict:(NSDictionary *)dict withShiFouTiaoZhuan:(BOOL)tiaoZhan withXiuGaiDict:(NSMutableDictionary *)dict2{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:KISDictionaryHaveKey(dict, @"subject_id") forKey:@"subject_id"];
    [mDict setObject:@"1" forKey:@"page"];
    [mDict setObject:KISDictionaryHaveKey(dict, @"next_num") forKey:@"pagesize"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_package_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSArray *array = KISDictionaryHaveKey(dataDic, @"list");
        if (![array isKindOfClass:[NSArray class]]) {
            return;
        }
        
        if (tiaoZhan == YES) {
            ProjectDetailsADDSanVC *vc = [[ProjectDetailsADDSanVC alloc]init];
            vc.chuZhiModel = dict;
            vc.chuZhiArray  = array;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else
        {
            [dict2 setObject:array forKey:@"array"];
        }
    } failure:^(id error) {
        
    }];
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
