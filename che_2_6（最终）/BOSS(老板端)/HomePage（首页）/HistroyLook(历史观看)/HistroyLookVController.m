//
//  HistroyLookVController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "HistroyLookVController.h"
#import "MJChiBaoZiHeader.h"
#import "HistroyLookUItableViewCell.h"
#import "WKWebViewViewController.h"
@interface HistroyLookVController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HistroyLookVController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"历史观看" withBackButton:YES];
    main_dataArry = [[NSMutableArray alloc]init];
    
    [self postmy_videoDatawithShuaXin:YES];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(void)requestMatchInfoData
{
    [self postmy_videoDatawithShuaXin:YES];
}

-(void)postmy_videoDatawithShuaXin:(BOOL)shuaX
{
    if (shuaX == YES) {
        page = 1;
    }
    
    [[self.mainTableView viewWithTag:3000] removeFromSuperview];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [mDict setObject:@"20" forKey:@"pagesize"];
    
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/study/my_history" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (shuaX == YES) {
            [main_dataArry removeAllObjects];
        }
        NSDictionary* dataDic = kParseData(responseObject);
        
        NSArray *order_list = KISDictionaryHaveKey(dataDic, @"list");
        if (order_list.count>=20) {
            weakSelf.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf postmy_videoDatawithShuaXin:NO];
            }];
        }else{
            weakSelf.mainTableView.mj_footer = nil;
        }
        
        for (int i = 0; i<order_list.count; i++) {
            HistroyModel*model = [[HistroyModel alloc]init];
            [model setDatashuJu:order_list[i]];
            [main_dataArry addObject:model];
        }
        
        if(main_dataArry.count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无历史观看";
            cLabel.tag = 3000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [weakSelf.mainTableView addSubview:cLabel];
            
        }
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return main_dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    HistroyLookUItableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[HistroyLookUItableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refleshData:main_dataArry[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280/2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistroyModel *model = main_dataArry[indexPath.row];
    
    
    LearningModel *model2 = [[LearningModel alloc]init];
    model2.title = model.title;
    model2.video_id = model.video_id;
    LearningVideoViewController *vc = [[LearningVideoViewController alloc]init];
    vc.chuanMOdel = model2;
    vc.video_id = model.video_id;
    vc.hidesBottomBarWhenPushed = YES;
    vc.chuanSeconds = [model.minutes integerValue]/60;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
