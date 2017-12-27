//
//  PerformanceViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/9.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PerformanceViewController.h"
#import "PerformanceCell.h"

@interface PerformanceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *main_tabelView;
@property(nonatomic,strong)NSString  *mainNum;
@property(nonatomic,strong)NSString  *mainSum;



@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:self.titleName withBackButton:YES];
    self.mainNum = @"";
    self.mainSum = @"";
    [self postQingQiuShuJu];
    
}

-(void)postQingQiuShuJu{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    if ([self.titleName isEqualToString:@"今日绩效"]) {
        [mDict setObject:@"today" forKey:@"range"];
    }else  if ([self.titleName isEqualToString:@"本周业绩"]) {
        [mDict setObject:@"week" forKey:@"range"];
    }else  if ([self.titleName isEqualToString:@"本月业绩"]) {
        [mDict setObject:@"month" forKey:@"range"];
    }else
    {
        [mDict setObject:@"yestoday" forKey:@"range"];
    }
    [mDict setObject:@"opera" forKey:@"role"];
    [mDict setObject:@"" forKey:@"class_id"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"data_center/performance/perform" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            weakSelf.mainSum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"sum")];
            weakSelf.mainNum = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"num")];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        [weakSelf.main_tabelView reloadData];
    } failure:^(id error) {
        
    }];
    
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
         [_main_tabelView setSeparatorInset:UIEdgeInsetsZero];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        [_main_tabelView registerClass:[PerformanceCell class] forCellReuseIdentifier:@"Cell"];
//        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _main_tabelView.scrollEnabled = NO;
        [self.view addSubview:_main_tabelView];
        
    }
    return _main_tabelView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PerformanceCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.zuoLabel.text = @"总单数";
        cell.youLabel.text = self.mainNum;
    }else
    {
        cell.zuoLabel.text = @"金额";
        cell.youLabel.text = self.mainSum;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [footView addSubview:line];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end
