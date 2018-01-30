//
//  PartsSubsidiaryADDViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PartsSubsidiaryADDViewController.h"
#import "PartsSubsidiaryADDErViewController.h"

@interface PartsSubsidiaryADDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *main_tableView;

@end

@implementation PartsSubsidiaryADDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加维修配件" withBackButton:YES];
    changArray = [[NSMutableArray alloc]init];
    fenLeiArray = [[NSMutableArray alloc]init];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
    [self.main_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    
    [self huoQuChangYong];
}

-(void)huoQuChangYong{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"10" forKey:@"num"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_usual_parts" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        
        [changArray removeAllObjects];
        
        for (int i = 0; i<dataDic.count; i++) {
            [changArray addObject:dataDic[i]];
        }
        [weakSelf.main_tableView reloadData];
        
        [weakSelf huoQuFenLeiList];
        
    } failure:^(id error) {
        
    }];
}
-(void)huoQuFenLeiList{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/get_parts_category" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        
        [fenLeiArray removeAllObjects];
        
        for (int i = 0; i<dataDic.count; i++) {
            [fenLeiArray addObject:dataDic[i]];
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
        NSDictionary *dict = fenLeiArray[indexPath.row];
        cell.textLabel.text = KISDictionaryHaveKey(dict, @"classname");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        PartsSubsidiaryADDErViewController *vc = [[PartsSubsidiaryADDErViewController alloc]init];
        vc.suerViewController = self.suerViewController;
        vc.chuanRumodel = fenLeiArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0) {
        
        
        
        PartsSubsidiaryViewController *vc = (PartsSubsidiaryViewController *)self.suerViewController;
        NSDictionary *dict = changArray[indexPath.row];
        if ([KISDictionaryHaveKey(dict, @"count") integerValue]<=0) {
            [self showMessageWindowWithTitle:@"库存为0不能使用" point:self.view.center delay:0.5];
            return;
        }
        PeiJianListModel *model = [[PeiJianListModel alloc]init];
        [model setDangQIanWIthData:dict];
        model.shiFouXuanZhong = NO;
        model.parts_total = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"count")];
        model.parts_num = @"1";
        model.cname = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
        model.parts_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"commodityid")];
        model.parts_fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"price")];
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



@end
