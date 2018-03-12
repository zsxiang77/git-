//
//  PushMessageViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PushMessageViewController.h"
#import "PushMessageCell.h"
#import "OrderMessageViewController.h"

@interface PushMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTableView;

@end

@implementation PushMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"消息" withBackButton:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.mainTableView reloadData];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:(UITableViewStylePlain)];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    PushMessageCell *cell = (PushMessageCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[PushMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    if (indexPath.row == 0) {
        cell.titileImageView.image = DJImageNamed(@"notice");
        cell.biaoTiLabel.text = @"系统消息";
        if ([UserInfo shareInstance].userHuanCunXiTongArray.count<=0) {
            cell.shuoMingLabel.text = @"暂无系统消息";
        }else
        {
            cell.shuoMingLabel.text = [NSString stringWithFormat:@"共%ld条消息",(unsigned long)[UserInfo shareInstance].userHuanCunXiTongArray.count];
        }
    }
    if (indexPath.row == 1) {
        cell.titileImageView.image = DJImageNamed(@"message");
        cell.biaoTiLabel.text = @"订单消息";
        if ([UserInfo shareInstance].userDingDanArray.count<=0) {
            cell.shuoMingLabel.text = @"暂无订单消息";
        }else
        {
            cell.shuoMingLabel.text = [NSString stringWithFormat:@"共%ld条消息",(unsigned long)[UserInfo shareInstance].userDingDanArray.count];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        if ([UserInfo shareInstance].userHuanCunXiTongArray.count<=0) {
            [self showMessageWindowWithTitle:@"无系统消息" point:self.view.center delay:1];
        }else
        {
            
        }
    }
    if (indexPath.row == 1) {
       
        if ([UserInfo shareInstance].userDingDanArray.count<=0) {
            [self showMessageWindowWithTitle:@"无订单消息" point:self.view.center delay:1];
        }else
        {
            OrderMessageViewController *vc = [[OrderMessageViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
