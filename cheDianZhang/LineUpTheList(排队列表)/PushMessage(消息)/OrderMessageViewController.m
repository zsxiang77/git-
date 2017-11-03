//
//  OrderMessageViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderMessageViewController.h"
#import "OrderMessageCell.h"
#import "XiMeiDetailViewController.h"
#import "TheWorkModel.h"

@interface OrderMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTableView;

@end

@implementation OrderMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订单消息" withBackButton:YES];
    [self.mainTableView reloadData];
    
    UIButton *qingKongBt = [[UIButton alloc]initWithFrame:CGRectMake(10, kWindowH-60, kWindowW-20, 40)];
    [qingKongBt setBackgroundColor:kNavBarColor];
    [qingKongBt setTitle:@"清空" forState:(UIControlStateNormal)];
    [qingKongBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [qingKongBt addTarget:self action:@selector(qingKongBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [qingKongBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [qingKongBt.layer setCornerRadius:3];
    [self.view addSubview:qingKongBt];
}

-(void)qingKongBtChick:(UIButton *)sender
{
    [UserInfo cleanDingDanArray];
    [self.mainTableView reloadData];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-60) style:(UITableViewStylePlain)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UserInfo  shareInstance].userDingDanArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    OrderMessageCell *cell = (OrderMessageCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[OrderMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    NSDictionary *dict = [UserInfo  shareInstance].userDingDanArray[indexPath.row];
    cell.titileImageView.image = DJImageNamed(@"ic_launcher");
    cell.zuoLabel.text = [NSString stringWithFormat:@"单号%@",KISDictionaryHaveKey(dict, @"ordercode")];
    cell.youLabel.text = [NSString stringWithFormat:@"状态：%@",KISDictionaryHaveKey(dict, @"status")];
    cell.biaoTiLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"car_number")];
    NSString *shuoMingStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"service")];
    NSString *operation_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"operation_name")];
    if (operation_name.length>0) {
        shuoMingStr = [NSString stringWithFormat:@"%@   %@",shuoMingStr,operation_name];
    }else
    {
        shuoMingStr = [NSString stringWithFormat:@"%@   无",shuoMingStr];
    }
    
    cell.shuoMingLabel.text = shuoMingStr;
    NPrintLog(@"dict是\n%@",dict);
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XiMeiDetailViewController *vc = [[XiMeiDetailViewController alloc]init];
    NSDictionary *dict = [UserInfo  shareInstance].userDingDanArray[indexPath.row];
    TheWorkModel *model = [[TheWorkModel alloc]init];
    model.ordercode = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"ordercode")];
    vc.chuanzhiModel = model;
    vc.yingCangAnNiu = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
