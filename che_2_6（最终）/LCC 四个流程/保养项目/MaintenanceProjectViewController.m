//
//  MaintenanceProjectViewController.m
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "MaintenanceProjectViewController.h"
#import "MaintenanceProjecClasstCell.h"
#import "MaintenanceProjecPartstBackCell.h"
#import "MaintenanceProjectModel.h"
#import "IQKeyboardManager.h"
#import "OrderCreatViewController.h"    //生成工单
#import "RepairSecondViewController.h"  //二级维护

#import "PartsSubsidiaryADDErViewController.h"

@interface MaintenanceProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *partsDataArr;
@property (nonatomic, strong) UILabel *selectNunLB;
@property (nonatomic, strong) UILabel *allPeeLB;
@end

@implementation MaintenanceProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"保养项目" withBackButton:YES];
    if (!self.ordercode) {
        self.ordercode = @"";
    }
    self.dataArr = @[].mutableCopy;
    self.partsDataArr = @[].mutableCopy;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = ({
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [tableView registerClass:[MaintenanceProjecClasstCell class] forCellReuseIdentifier:@"MaintenanceProjecClasstCell"];
        [tableView registerClass:[MaintenanceProjecPartstBackCell class] forCellReuseIdentifier:@"MaintenanceProjecPartstBackCell"];
//        [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@""];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableView;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(m_baseTopView.mas_bottom);
        make.bottom.mas_equalTo(-49);
    }];
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(49);
    }];
    UILabel*yiXunLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(47.5, 21));
            make.top.mas_equalTo(2.5);
        }];
        lb;
    });
    yiXunLB.text = @"已选:";
    self.selectNunLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(yiXunLB.mas_right).mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(47.5, 21));
            make.top.mas_equalTo(2.5);
        }];
        lb;
    });
    
    UILabel*hejiLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [bottomView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:15];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.size.mas_equalTo(CGSizeMake(47.5, 21));
            make.bottom.mas_equalTo(-2.5);
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
            if (self.ordercode.length>0) {
                [self tuiJianXiangMuQueDing];
            }else{
                if ([CreatOrderFlowChartManager defaultOrderFlowChartManager].secondarySafeguard.isSelect){
                    //选择了
                    RepairSecondViewController *repairSecond = [RepairSecondViewController new];
                    [self.navigationController pushViewController:repairSecond animated:YES];
                }else{
                    
                    OrderCreatViewController *creatOrderVC = [OrderCreatViewController new];
                    [self.navigationController pushViewController:creatOrderVC animated:YES];
                }
            }
            
        }];
        bt;
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preChange:) name:@"LC_preChangeNotification" object:nil];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enableAutoToolbar = NO;
    [self netWoiking];
}


-(void)tuiJianXiangMuQueDing
{
    NSMutableArray *tiJiaoArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.dataArr.count; i++) {
        MaintenanceProjectModel *model = self.dataArr[i];
        NSMutableArray *partsArray = [[NSMutableArray alloc]init];
        for (int h= 0; h < model.parts.count; h++) {
            MaintenanceProjectPartstModel *model2 = model.parts[h];
            NSDictionary *dict = @{@"parts_fee":[NSString stringWithFormat:@"%@",model2.parts_fee],@"parts_id":[NSString stringWithFormat:@"%@",model2.parts_id],@"parts_num":[NSString stringWithFormat:@"%@",model2.parts_num]};
            [partsArray addObject:dict];
        }
        if (model.isSelect) {
            NSDictionary *dict = @{@"subject_id":[NSString stringWithFormat:@"%@",model.subject_id],@"fee":[NSString stringWithFormat:@"%@",model.fee],@"hour":[NSString stringWithFormat:@"%@",model.hour],@"is_normal":[NSString stringWithFormat:@"%@",@"0"],@"parts":partsArray};
            [tiJiaoArray addObject:dict];
        }
        
    }
    
    NSArray *ar = tiJiaoArray;
    
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1" forKey:@"is_add"];
    [dict setObject:self.ordercode forKey:@"ordercode"];
    [dict setObject:ar forKey:@"subjects"];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:[self convertToJsonData:dict] forKey:@"modify_upload"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/modify_subjects" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] != 200) {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }else
        {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(id error) {
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MaintenanceProjecClasstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintenanceProjecClasstCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self)
        cell.selectBtClick = ^{
            @strongify(self)
            MaintenanceProjectModel *model = self.dataArr[indexPath.row];
            model.isSelect = !model.isSelect;
            [self.tableView reloadData];
        };
        [cell bingViewModel:self.dataArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 1){
        MaintenanceProjecPartstBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintenanceProjecPartstBackCell" forIndexPath:indexPath];
        @weakify(self)
        kWeakSelf(weakSelf)
        __block MaintenanceProjecPartstBackCell *cell2 = cell;
        cell.changePartst = ^(MaintenanceProjectPartstModel *partsModel, NSArray *partsArr) {
            @strongify(self)
            NSUInteger i = 0;
            if([self.partsDataArr containsObject:partsArr]){
                if ([partsArr containsObject: partsModel]) {
                   
                    i = [partsArr indexOfObject:partsModel];
                }
            }
            
            NSMutableArray *tempArr = @[].mutableCopy;
            for (MaintenanceProjectPartstModel *partsModel in partsArr) {
                [tempArr addObject:partsModel];
            }
            
            PartsSubsidiaryADDErViewController *vc = [[PartsSubsidiaryADDErViewController alloc]init];
            vc.chuanZhiPartModel = partsModel;
            vc.chuanZhiClassid = partsModel.classid;
            vc.changePartst = ^(OrderDetailPartsModel *chuanZhiPartModel,NSString *chuanZhiClassid) {
                
//                MaintenanceProjectPartstModel *partModel2 = [MaintenanceProjectPartstModel new];
//                partModel2.classid = chuanZhiClassid;
//                partModel2.parts_brand = chuanZhiPartModel.parts_brand;
//                partModel2.parts_id = chuanZhiPartModel.parts_id;
//                partModel2.parts_name = chuanZhiPartModel.parts_name;
//                partModel2.parts_num = chuanZhiPartModel.parts_num;
//                partModel2.parts_fee = chuanZhiPartModel.parts_fee;
//                partModel2.parts_code = chuanZhiPartModel.parts_code;
//                partModel2.unit = chuanZhiPartModel.unit;
//                partsModel.count = chuanZhiPartModel.count;
////                partModel.
//                [tempArr replaceObjectAtIndex:i withObject:partModel2];
//
//                MaintenanceProjectModel *model =  self.dataArr[indexPath.row];
//
//                model.parts = tempArr.copy;
                [self.tableView reloadData];
                [cell2.tableView reloadData];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LC_preChangeNotification" object:nil];
                
            };
            
            [weak_self.navigationController pushViewController:vc animated:YES];
            
            
        };
        [cell bingViewModel:self.partsDataArr[indexPath.row]];
        return cell;
    }
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *titles = @[@"项目类型",@"选择配件"];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 39)];
    backView.backgroundColor = UIColorHex(#FAFAFA);
    UILabel * nameLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 9.5, 60, 20)];
    nameLB.font = [UIFont pf_PingFangSCSemiboldFontOfSize:14];
    nameLB.text = titles[section];
    [backView addSubview:nameLB];
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 75;
    }else if (indexPath.section == 1){
        MaintenanceProjectModel *model = self.dataArr[indexPath.row];
        NSArray *parts = model.parts;
        return model.isSelect ? 104*parts.count : 0;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (void)netWoiking{
    
//    NSArray *aaa = @[@"油类",@"机滤",@"空滤",@"进气滤芯"];
//    for (NSString *name in aaa) {
//        MaintenanceProjectModel *model = [MaintenanceProjectModel new];
//        model.fee     = @"40.00";
//        model.hour    = @"2";
//        model.name = name;
//        model.img_num = name;
//        model.subject_id = @"1797599";
//        MaintenanceProjectPartstModel *partsModel = [MaintenanceProjectPartstModel new];
//        partsModel.count = @"111";
//        partsModel.parts_code = @"123456";
//        partsModel.parts_fee = @"40.00";
//        partsModel.parts_id  = @"22883";
//        partsModel.parts_name = @"djfiewajf";
//        partsModel.parts_num = @"1";
//        model.parts = @[partsModel];
//        [self.partsDataArr addObject:model.parts];
//        [self.dataArr addObject:model];
//    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    if (self.ordercode.length>0) {
        [mDict setObject:self.ordercode forKey:@"ordercode"];
    }
    
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/maintain_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSLog(@"responseObject = = = %@",responseObject);
        
        NSDictionary *dic = responseObject;
        NSLog(@"json = = %@",[dic jsonPrettyStringEncoded]);
        NSDictionary *data = responseObject[@"data"];
        NSArray *maintain_list = data[@"maintain_list"];
        for (int i=0; i<maintain_list.count; i++) {
            MaintenanceProjectModel *model = [MaintenanceProjectModel parseJSON:maintain_list[i]];
            [self.dataArr addObject:model];
            [self.partsDataArr addObject:model.parts];
            [self.tableView reloadData];
        }
        
        for (int i = 0; i<self.dataArr.count; i++) {
            MaintenanceProjectModel *modelProject1 = self.dataArr[i];
            if ([[CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel isKindOfClass:[CustomerInformationYYueModel class]]) {
                CustomerInformationYYueModel *modelProject2 = [CreatOrderFlowChartManager defaultOrderFlowChartManager].yueYueModel;
                for (int h = 0; h<modelProject2.subject.count; h++) {
                    OrderDetailSubjectsModel *md = modelProject2.subject[h];
                    if ([modelProject1.subject_id isEqualToString:md.subject_id]) {
                        modelProject1.isSelect = YES;
                    }
                }
                
            }else{
                 modelProject1.isSelect = NO;
            }
            
        }
        [self.tableView reloadData];
        
//        NSDictionary *data = [responseObject objectForKey:@"data"];
        
//        PerctInfoDataModel *model = [PerctInfoDataModel parseJSON:data];
//        [self.model buildDataSourceWithModel:model];
//        [self updateUI];

    } failure:^(id error) {
        
    }];
    
}

- (void)preChange:(NSNotification *)notification{
    
    [self.tableView reloadData];
    int i=0;
    float allPee = 0.00;
    //项目
    NSMutableArray *projectModelArr = @[].mutableCopy;
    float allGongShiPrice = 0.0;

    //配件
    NSMutableArray *partsModelArr  = @[].mutableCopy;
    float allPeiPrice = 0.0;
    
    for (MaintenanceProjectModel *model in self.dataArr) {
        if (model.isSelect) {
            i = i+1;
            float PartsPee = 0.00;
            //
            for (MaintenanceProjectPartstModel *partsModel in model.parts) {
                
                PartsPee = PartsPee + [partsModel.parts_fee floatValue] * [partsModel.parts_num floatValue]; //一个项目所有的配件总价格
                
                PartsModel *danLipartsModel = [PartsModel new];
                danLipartsModel.partsName = partsModel.parts_name;//配件名字
                danLipartsModel.unitPrice = partsModel.parts_fee; //配件单价
                danLipartsModel.num       = partsModel.parts_num; //配件个数
                danLipartsModel.partsId   = partsModel.parts_id;
                [partsModelArr addObject:danLipartsModel];
                
                allPeiPrice = allPeiPrice + PartsPee;             //n项目个所有配件总价
            }
            
            allPee = allPee + PartsPee + [model.fee floatValue] * [model.hour floatValue];;
            //
            ProjectModel *projectModel = [ProjectModel new];
            projectModel.projectName = model.name;
            projectModel.price = model.fee;
            projectModel.subjectId = model.subject_id;
            projectModel.time = model.hour;
            [projectModelArr addObject:projectModel];
            allGongShiPrice = allGongShiPrice + [model.fee floatValue] * [model.hour floatValue];
        }
    }
    
    self.selectNunLB.text = [NSString stringWithFormat:@"%d",i];
    self.allPeeLB.text    = [NSString stringWithFormat:@"%.2f",allPee];
    [self.tableView reloadData];
//    项目
    ProjectListModel *projectListModel = [ProjectListModel new];
    projectListModel.imageName = @"项目";
    projectListModel.title = [NSString stringWithFormat:@"项目(%lu)",(unsigned long)projectModelArr.count];
    projectListModel.allGongShiPrice = allGongShiPrice;
    projectListModel.projectModelArr = projectModelArr.copy;

    //配件
    PartsListModel *partsListModel = [PartsListModel new];
    partsListModel.imageName = @"配件";
    partsListModel.title = [NSString stringWithFormat:@"配件(%lu)",(unsigned long)partsModelArr.count];//@"配件";
    partsListModel.allPeiJianPrice = allPeiPrice;
    partsListModel.partsModelArr = partsModelArr.mutableCopy;
    
    [CreatOrderFlowChartManager defaultOrderFlowChartManager].maintenance.projectListModel = projectListModel;
    [CreatOrderFlowChartManager defaultOrderFlowChartManager].maintenance.partsListModel   = partsListModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
