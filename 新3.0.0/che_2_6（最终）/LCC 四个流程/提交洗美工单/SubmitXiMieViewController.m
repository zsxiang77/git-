//
//  SubmitXiMieViewController.m
//  测试
//
//  Created by lcc on 2018/2/4.
//  Copyright © 2018年 lcc. All rights reserved.
//  洗美生成工单

#import "SubmitXiMieViewController.h"
#import "LCXiMieChePaiCell.h"
#import "OrderProjectCell.h"
#import "OrderAccessoriesCell.h"
#import "LCMessageListView.h"
#import "OrderSectionHeaderView.h"
#import "OrderSectionModel.h"

@interface SubmitXiMieViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *allPeeLB;
@property (nonatomic, strong) NSMutableArray *fuWuXiangMuDataArr;
@property (nonatomic, strong) NSMutableArray *haoCaiXinXiDataArr;
@property (nonatomic, strong) NSMutableArray *messageDataArr;
@property (nonatomic, strong) NSArray *headerDataArr;
@end

@implementation SubmitXiMieViewController

- (void)viewDidLoad {
    
    
    /*
     @property (nonatomic, strong) NSMutableArray *fuWuXiangMuDataArr;
     @property (nonatomic, strong) NSMutableArray *haoCaiXinXiDataArr;
     @property (nonatomic, strong) NSMutableArray *messageDataArr;
     */
    [super viewDidLoad];
    _fuWuXiangMuDataArr = @[].mutableCopy;
    _haoCaiXinXiDataArr = @[].mutableCopy;
    _messageDataArr = @[].mutableCopy;
    [self setTopViewWithTitle:@"生成工单" withBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = ({
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView registerClass:[LCXiMieChePaiCell class] forCellReuseIdentifier:@"LCXiMieChePaiCell"];
        [tableView registerClass:[OrderProjectCell class] forCellReuseIdentifier:@"OrderProjectCell"];
        [tableView registerClass:[OrderAccessoriesCell class] forCellReuseIdentifier:@"OrderAccessoriesCell"];
        [tableView registerClass:[LCMessageListViewCell class] forCellReuseIdentifier:@"LCMessageListViewCell"];
        [tableView registerClass:[OrderSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"OrderSectionHeaderView"];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.bottom.mas_equalTo(-50);
    }];
    
    UIView *lineView = ({
        UIView *v = [[UIView alloc]init];
        [self.view addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_offset(-49.5);
        }];
        v;
    });
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(49);
    }];
    
    UILabel*hejiLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(47.5, 21));
            make.centerY.mas_equalTo(0);
        }];
        lb.text = @"0";
        lb;
    });
    hejiLB.text = @"合计:";
    UIImageView *im = ({
        UIImageView *im = [[UIImageView alloc]init];
        [bottomView addSubview:im];
        im.image = [UIImage imageNamed:@"人民币图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(hejiLB);
            make.left.mas_equalTo(hejiLB.mas_right).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(11.5, 11.5));
        }];
        im;
    });
    self.allPeeLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#FF001F);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(im.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(hejiLB);
        }];
        lb.text = @"0.00";
        lb;
    });
    
    UIButton *quDingBT = ({
        UIButton *bt = [[UIButton alloc]init];
        [bottomView addSubview:bt];
        [bt setTitle:@"确定" forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont pf_PingFangSCRegularFontOfSize:17];
        [bt setTitleColor:UIColorHex(#ffffff) forState:UIControlStateNormal];
        bt.backgroundColor = UIColorHex(#4A90E2);
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth * 230 / 375);
        }];
        @weakify(self)
        [bt addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            NSLog(@"确定了-------");
        }];
        bt;
    });
    
    OrderSectionModel *model2 = [OrderSectionModel new];
    model2.title = @"服务项目";
    model2.imageName = @"信息";
    model2.price = @"480.00";
    
    OrderSectionModel *model3 = [OrderSectionModel new];
    model3.title = @"耗材信息";
    model3.imageName = @"耗材信息";
    model3.price = @"480.00";
    
    OrderSectionModel *model4 = [OrderSectionModel new];
    model4.title = @"需求描述";
    model4.imageName = @"故障描述";
//    model4.price = @"480.00";
    _headerDataArr = @[@"", model2,model3,model4];
    
//    @property (nonatomic, strong) NSMutableArray *fuWuXiangMuDataArr;
//    @property (nonatomic, strong) NSMutableArray *haoCaiXinXiDataArr;
    
    ProjectModel *fuWuXiangMuModel = [ProjectModel new];
    fuWuXiangMuModel.projectName = @"洗车";
    fuWuXiangMuModel.price = @"200";
    fuWuXiangMuModel.time = @"2";
    [_fuWuXiangMuDataArr addObject:fuWuXiangMuModel];
    
    PartsModel *pmodel = [PartsModel new];
    pmodel.partsName = @"分离器";
    pmodel.unitPrice = @"11.11";
    pmodel.num =  @"3";
    pmodel.partsId = @"10-----";
    [_haoCaiXinXiDataArr addObject:pmodel];
    [_haoCaiXinXiDataArr addObject:pmodel];
    [_haoCaiXinXiDataArr addObject:pmodel];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.fuWuXiangMuDataArr.count;
    }else if (section == 2){
        return self.haoCaiXinXiDataArr.count;
    }else if (section == 3){
        return self.messageDataArr.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        LCXiMieChePaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCXiMieChePaiCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        
        OrderProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderProjectCell" forIndexPath:indexPath];
        [cell bingViewModel:self.fuWuXiangMuDataArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        
        OrderAccessoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAccessoriesCell" forIndexPath:indexPath];
        [cell bingViewModel:self.haoCaiXinXiDataArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 3){
        
        LCMessageListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCMessageListViewCell" forIndexPath:indexPath];
        [cell bingViewModel:self.messageDataArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderSectionHeaderView"];
    if (section != 0) {
        [headerView bingViewModel:self.headerDataArr[section]];
    }
    return headerView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 41;
    }else if (indexPath.section == 1){
        return 16+12;
    }else if (indexPath.section == 2){
        return 16+12;
    }else if (indexPath.section == 3 && self.messageDataArr.count>0){
        LCMessageViewModel *messageVM = self.messageDataArr[indexPath.row];
        return messageVM.cell_H;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }
    return 35;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
