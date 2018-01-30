//
//  ModelCarZiVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ModelCarZiVC.h"
#import "CarYearViewController.h"

@interface ModelCarZiVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *maiArray;

@end

@implementation ModelCarZiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"车型" withBackButton:YES];
    [self postcars_series];
}
-(void)postcars_series{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@(self.chuZhiModel.brand_id) forKey:@"brand_id"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/cars_series" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CarYearViewController *vc = [[CarYearViewController alloc]init];
    vc.chuZhiModel = self.maiArray[indexPath.row];
    self.xinZengModel.trainSystem = KISDictionaryHaveKey(self.maiArray[indexPath.row], @"name");
    vc.xinZengModel = self.xinZengModel;
    vc.superViewController = self.superViewController;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
