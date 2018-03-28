//
//  CarYearViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarYearViewController.h"
#import "CarInfoViewController.h"
#import "AddXiMeiViewController.h"

@interface CarYearViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *maiArray;

@end

@implementation CarYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"车辆年份" withBackButton:YES];
    [self postcars_spec];
}

-(void)postcars_spec{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:KISDictionaryHaveKey(self.chuZhiModel, @"series_id") forKey:@"series_id"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/cars_spec" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray *adData = kParseData(responseObject);
        if((![adData isKindOfClass:[NSArray class]])|| (adData.count<=0)){
            return;
        }
        
        weakSelf.maiArray = adData;
        [weakSelf.main_tabelView reloadData];
    } failure:^(id error) {
        
    }];
}
-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.maiArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"ModelCarReMenCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    
    cell.textLabel.text = KISDictionaryHaveKey(self.maiArray[indexPath.row], @"name");
    cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}




#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.xinZengModel.spec = KISDictionaryHaveKey(self.maiArray[indexPath.row], @"name");
    self.xinZengModel.spec_id = KISDictionaryHaveKey(self.maiArray[indexPath.row], @"spec_id");
    if (self.xiMeiZuiZhongModel) {
        AddXiMeiViewController *vc = [[AddXiMeiViewController alloc]init];
        self.xiMeiZuiZhongModel.car_brand   = self.xinZengModel.brand;
        self.xiMeiZuiZhongModel.car_type   = self.xinZengModel.type;
        self.xiMeiZuiZhongModel.cars_spec   = self.xinZengModel.spec;
        self.xiMeiZuiZhongModel.spec_id  = self.xinZengModel.spec_id;
        vc.xiMeiZuiZhongModel = self.xiMeiZuiZhongModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        CarInfoViewController *vc = (CarInfoViewController *)self.superViewController;
        [vc sendCarInfoWithModel:self.xinZengModel];
        [self.navigationController popToViewController:self.superViewController animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [footView addSubview:line];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end
