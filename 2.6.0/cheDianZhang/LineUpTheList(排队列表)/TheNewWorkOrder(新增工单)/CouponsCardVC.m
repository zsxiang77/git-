//
//  CouponsCardVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CouponsCardVC.h"

@interface CouponsCardVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CouponsCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"会员卡" withBackButton:YES];
    self.view.backgroundColor = kRGBColor(244, 245, 246);
    [self.main_tabelView reloadData];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shangYeMianChuanZhi.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"Cell";
    CouponsCardCell *cell = (CouponsCardCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[CouponsCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    
    [cell refreshViewWithDate:self.shangYeMianChuanZhi[indexPath.row]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kWindowW-20)*260/600 +20;
}

@end
