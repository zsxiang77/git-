//
//  PartsSubsidiaryADDErViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PartsSubsidiaryADDErViewController.h"


@interface PartsSubsidiaryADDErViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *mainArrary;

@property(nonatomic,strong)UITableView *main_tableView;

@end

@implementation PartsSubsidiaryADDErViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加维修配件" withBackButton:YES];
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavBarHeight, kWindowW-20, 35)];
    la.font = [UIFont systemFontOfSize:14];
    la.text = @"配件名称";
    la.textColor = [UIColor grayColor];
    [self.view addSubview:la];
    
    
    self.mainArrary = [[NSMutableArray alloc]init];
    [self huoQuFengLeiDataShiFouShuaXin:YES];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35-50) style:UITableViewStylePlain];
    self.main_tableView.delegate = self;
    self.main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.main_tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
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

-(void)loadNewData0
{
    [self huoQuFengLeiDataShiFouShuaXin:YES];
}

-(void)queDingBtChick:(UIButton *)sender
{
    if (self.chuanZhiClassid.length>0) {
        OrderDetailPartsModel *cbmodel;
        for (int i = 0; i<self.mainArrary.count; i++) {
            OrderDetailPartsModel *model = self.mainArrary[i];

            if (model.shiFouXuanZhong == YES) {
                cbmodel = model;
            }
            
            
        }
        
        self.chuanZhiPartModel.classid = self.chuanZhiClassid;
        self.chuanZhiPartModel.parts_brand = cbmodel.parts_brand;
        self.chuanZhiPartModel.parts_id = cbmodel.parts_id;
        self.chuanZhiPartModel.parts_name = cbmodel.parts_name;
        self.chuanZhiPartModel.parts_num = cbmodel.parts_num;
        self.chuanZhiPartModel.parts_fee = cbmodel.parts_fee;
        self.chuanZhiPartModel.parts_code = cbmodel.parts_code;
        self.chuanZhiPartModel.unit = cbmodel.unit;
        self.chuanZhiPartModel.count = cbmodel.count;
        
        
        
        self.changePartst(cbmodel,self.chuanZhiClassid);
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        AccessoriesViewController *vc = (AccessoriesViewController *)self.suerViewController;
        for (int i = 0; i<self.mainArrary.count; i++) {
            OrderDetailPartsModel *model = self.mainArrary[i];
            if (model.shiFouXuanZhong == YES) {
                model.parts_num = @"1";
                [vc.tianJiaArray addObject:model];
            }
        }
        [vc.main_tabelView reloadData];
        [self.navigationController popToViewController:vc animated:YES];
    }
    
}

-(void)huoQuFengLeiDataShiFouShuaXin:(BOOL)shua{
    if (shua == YES) {
        self.pageIndex = 1;
    }

    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    if (self.chuanZhiClassid.length>0) {
        [mDict setObject:self.chuanZhiClassid forKey:@"classid"];
    }else{
        [mDict setObject:KISDictionaryHaveKey(self.chuanRumodel, @"classid") forKey:@"classid"];
    }
    
    [mDict setObject:[NSString stringWithFormat:@"%ld",self.pageIndex] forKey:@"page"];
    [mDict setObject:@"20" forKey:@"pagesize"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/cid_parts_page" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (shua == YES) {
            [weakSelf.mainArrary removeAllObjects];
        }
        NSArray *list = KISDictionaryHaveKey(dataDic, @"list");
        
        for (int i = 0; i<list.count; i++) {
            OrderDetailPartsModel *model = [[OrderDetailPartsModel alloc]init];
            [model setdataWithDict:list[i]];
            model.parts_num = @"0";
            [weakSelf.mainArrary addObject:model];
        }
        
        [weakSelf.main_tableView reloadData];
        
        if (list.count>=20) {
            weakSelf.main_tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                weakSelf.pageIndex ++;
                [weakSelf huoQuFengLeiDataShiFouShuaXin:NO];
            }];
        }else{
            weakSelf.main_tableView.mj_footer = nil;
        }
        
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
    PartsSubsidiaryADDErCell *cell = (PartsSubsidiaryADDErCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[PartsSubsidiaryADDErCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    [cell refelesePeiJianWithModel:self.mainArrary[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailPartsModel *model = self.mainArrary[indexPath.row];
    if ([model.count integerValue]<=0) {
        [self showMessageWindowWithTitle:@"无库存" point:self.view.center delay:0.5];
        return;
    }
    
    if (self.chuanZhiClassid.length>0) {
        for (int i = 0; i<self.mainArrary.count; i++) {
            OrderDetailPartsModel *model2 = self.mainArrary[i];
            model2.shiFouXuanZhong = NO;
        }
    }
    
    
    model.shiFouXuanZhong = !model.shiFouXuanZhong;
    [self.main_tableView  reloadData];
}


@end
