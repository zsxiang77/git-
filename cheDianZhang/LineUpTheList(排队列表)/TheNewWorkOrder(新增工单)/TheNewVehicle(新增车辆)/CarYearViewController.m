//
//  CarYearViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarYearViewController.h"

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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.xinZengModel.models = KISDictionaryHaveKey(self.maiArray[indexPath.row], @"name");
    self.xinZengModel.modelsId = KISDictionaryHaveKey(self.maiArray[indexPath.row], @"spec_id");
    self.xinZengModel.shiFouXinZeng = YES;
    self.xinZengModel.shifouXuanZHong = YES;
    [self.navigationController popToViewController:self.superViewController animated:YES];
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
