//
//  SwitchRolesViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "SwitchRolesViewController.h"
#import "SwitchRolesCell.h"

@interface SwitchRolesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *mainArray;
@property(nonatomic,strong)UITableView    *mainTableView;


@end

@implementation SwitchRolesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"角色切换" withBackButton:YES];
    self.mainArray = [[NSMutableArray alloc]init];
    [self huoquMengDianData];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:(UITableViewStylePlain)];
        _mainTableView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_mainTableView];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
}


-(void)huoquMengDianData
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/ucenter/role_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
            NSArray* dataDic = kParseData(responseObject);
            for (int i = 0; i<dataDic.count; i++) {
                [weakSelf.mainArray addObject:dataDic[i]];
            }
            [weakSelf.mainTableView reloadData];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
    } failure:^(id error) {
        
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    SwitchRolesCell *cell = (SwitchRolesCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[SwitchRolesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    [cell refeleseWithModel:self.mainArray[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.mainArray[indexPath.row];
    if ([[UserInfo shareInstance].userPositions[0] integerValue] == [KISDictionaryHaveKey(dict, @"role_id") integerValue]) {
        return;
    }else{
        NSString * role_idStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"role_id")];
        NSArray *array  = [NSArray arrayWithObject:role_idStr];
        [UserInfo shareInstance].userPositions = array;
        [UserInfo saveUserName];
        AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate startFirstPage];
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *fotView = [[UIView alloc]init];
    fotView.backgroundColor = self.view.backgroundColor;
    return fotView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
@end
