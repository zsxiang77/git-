//
//  RepairSecondViewController.m
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "RepairSecondViewController.h"
#import "RepairSecondModel.h"
#import "RepairSecondCell.h"
#import "OrderCreatViewController.h"

@interface RepairSecondViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;
//@property (nonatomic, strong) RepairSecondModel *model;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int page;
@end

@implementation RepairSecondViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二级维护";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopViewWithTitle:@"二级维护" withBackButton:YES];
    _dataArr = @[].mutableCopy;
    [self setupView];
    [self requestDatas];
}

- (void)setupView
{
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47 + 13);
        make.bottom.mas_equalTo(0);
    }];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(47);
    }];
    [_commitBtn setTitle:@"确  定" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
    [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"4A90E2"]] forState:UIControlStateNormal];
    _commitBtn.layer.cornerRadius = 4;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 85;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    UIButton * allSelect = ({
        UIButton *bt = [[UIButton alloc]init];
        [m_baseTopView addSubview:bt];
        [bt setTitle:@"全选" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        [bt setTitleColor:kBOSSZhuTiColor forState:UIControlStateNormal];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-7);
            make.width.mas_offset(50);
            make.top.mas_offset(20);
            make.bottom.mas_offset(0);
        }];
        
        bt;
    });
    [allSelect addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    
//    ({
//        UIButton *bt = [[UIButton alloc]init];
//        [<#SubView#> addSubview:bt];
//        [bt setImage:[UIImage imageNamed:<#imageName#>] forState:UIControlStateNormal];
//        [bt setTitle:<#title#> forState:UIControlStateNormal];
//        bt.titleLabel.font = [UIFont systemFontOfSize:12];
//        [bt setTitleColor:UIColorHex(<#_hex_#>) forState:UIControlStateNormal];
//        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        }];
//        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//
//        }];
//        bt;
//    });
    
//    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    _tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreListData)];
    
}

- (void)requestDatas
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(self.page) forKey:@"page"];
    [param setValue:@16 forKey:@"pagesize"];
    [param setValue:@2 forKey:@"subject_id"];
    [param setValue:@"true" forKey:@"is_maint"];
    
    [NetWorkManager requestWithParameters:param withUrl:@"order/repair_order/get_package_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        
        NSLog(@"responseObject = = %@",[responseObject jsonStringEncoded]);
        
        
        RepairSecondDataModel *model = [RepairSecondDataModel parseJSON:data];
        [self.dataArr addObjectsFromArray:model.list];
        for (int i=0; i<self.dataArr.count; i++) {
            RepairSecondDataListModel *listModel = self.dataArr[i];
            if (i == self.dataArr.count-1) {
                listModel.isLast = YES;
            }else{
                listModel.isLast = NO;
            }
        }
        [self.tableView reloadData];
    } failure:^(id error) {

    }];
}

- (void)refreshData
{
    _page = 1;
    [self requestDatas];
}

- (void)loadMoreListData
{
    _page++;
    [self requestDatas];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;//model.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    RepairSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RepairSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.dataArr[indexPath.row]; //_model.dataSource[indexPath.row];;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RepairSecondDataListModel *model = self.dataArr[indexPath.row];
    model.isSelect = !model.isSelect;
    [self.tableView reloadData];
}

#pragma mark -
- (void)clickCommitButton:(UIButton *)btn{
    
    NSMutableArray *arr = @[].mutableCopy;
    for (RepairSecondDataListModel *model in self.dataArr) {
        if (model.isSelect) {
            [arr addObject:model];
        }
    }
    
    if (arr.count == 0) {
        [self showMessageWindowWithTitle:@"请选择维护项目" point:self.view.center delay:1];
        return;
    }

    NSMutableArray *tempArr = [NSMutableArray array];
    float allGongShiPrice = 0.0;
    for (RepairSecondDataListModel *selectModel in arr) {
        ProjectModel *projectModel = [ProjectModel new];
        projectModel.projectName = selectModel.name;
        projectModel.price       = selectModel.fee;
        projectModel.time        = selectModel.hour;
        projectModel.subjectId   = selectModel.subject_id;
        allGongShiPrice = allGongShiPrice + [selectModel.fee floatValue] * [selectModel.hour floatValue];
        [tempArr addObject:projectModel];
    }

    SecondarySafeguardCreatOrderFlowChart *secondarySafeguard = [CreatOrderFlowChartManager defaultOrderFlowChartManager].secondarySafeguard;
    secondarySafeguard.projectModelArr = tempArr.copy;
    secondarySafeguard.title = @"项目";
    secondarySafeguard.imageName = @"项目";
    secondarySafeguard.allGongShiPrice = allGongShiPrice;
    [CreatOrderFlowChartManager defaultOrderFlowChartManager].secondarySafeguard = secondarySafeguard;

    OrderCreatViewController *orderCreat = [OrderCreatViewController new];
    [self.navigationController pushViewController:orderCreat animated:YES];

}

//- (RepairSecondModel *)model
//{
//    if (!_model) {
//        _model = [[RepairSecondModel alloc] init];
//        _model.page = 1;
//    }
//    return _model;
//}

- (void)allSelect:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"全选"]) {
        [sender setTitle:@"全不选" forState:UIControlStateNormal];
        for (int i=0; i<self.dataArr.count; i++) {
            RepairSecondDataListModel *listModel = self.dataArr[i];
            listModel.isSelect = YES;
        }
        [self.tableView reloadData];
    }else{
        for (int i=0; i<self.dataArr.count; i++) {
            RepairSecondDataListModel *listModel = self.dataArr[i];
            listModel.isSelect = NO;
        }
        [sender setTitle:@"全选" forState:UIControlStateNormal];
        [self.tableView reloadData];
    }
    
}
@end
