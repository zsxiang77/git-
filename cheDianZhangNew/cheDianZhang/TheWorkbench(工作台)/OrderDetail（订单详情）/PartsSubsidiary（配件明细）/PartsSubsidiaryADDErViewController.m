//
//  PartsSubsidiaryADDErViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PartsSubsidiaryADDErViewController.h"
#import "PartsSubsidiaryViewController.h"


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
    [self huoQuFengLeiData];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35-50) style:UITableViewStylePlain];
    self.main_tableView.delegate = self;
    self.main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
-(void)queDingBtChick:(UIButton *)sender
{
    PartsSubsidiaryViewController *vc = (PartsSubsidiaryViewController *)self.suerViewController;
    
    for (int i = 0; i<self.mainArrary.count; i++) {
         PeiJianListModel *model = self.mainArrary[i];
        
        
        if (model.shiFouXuanZhong) {
            model.shiFouXuanZhong = NO;
            [vc.chuanRuArray addObject:model];
        }
    }
    
    [vc.main_tableView  reloadData];
    
    [self.navigationController popToViewController:vc animated:YES];
}

-(void)huoQuFengLeiData{

    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:KISDictionaryHaveKey(self.chuanRumodel, @"classid") forKey:@"classid"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_cid_parts" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        
        [weakSelf.mainArrary removeAllObjects];
        for (int i = 0; i<dataDic.count; i++) {
            PeiJianListModel *model = [[PeiJianListModel alloc]init];
            [model setDangQIanWIthData:dataDic[i]];
            
            model.parts_total = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"count")];
            model.parts_num = @"1";
            model.cname = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"name")];
            model.parts_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"commodityid")];
            model.parts_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic[i], @"price")];
            [weakSelf.mainArrary addObject:model];
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
    PeiJianListModel *model = self.mainArrary[indexPath.row];
    if ([model.parts_total integerValue]<=0) {
        [self showMessageWindowWithTitle:@"无库存" point:self.view.center delay:0.5];
        return;
    }
    
    model.shiFouXuanZhong = !model.shiFouXuanZhong;
    [self.main_tableView  reloadData];
}


@end
