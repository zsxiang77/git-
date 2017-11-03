//
//  ConstructionPersonnelErVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ConstructionPersonnelErVC.h"
#import "ConstructionPersonnelErModel.h"
#import "ConstructionPersonnelErCell.h"

@interface ConstructionPersonnelErVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIButton *xuanZeGongRen;

@property(nonatomic,strong)NSMutableArray *zongDataArray;
@property(nonatomic,strong)NSMutableArray *xuanZhongArray;

@end

@implementation ConstructionPersonnelErVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"待派工订单" withBackButton:YES];
    self.zongDataArray = [[NSMutableArray alloc]init];
    self.xuanZhongArray = [[NSMutableArray alloc]init];
    
    UILabel *la = [[UILabel alloc]init];
    la.textColor = [UIColor grayColor];
    la.text = @"选定人员";
    la.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(kNavBarHeight);
        make.height.mas_equalTo(35);
    }];
    
    self.xuanZeGongRen = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-50, kWindowW-40, 35)];
    [self.xuanZeGongRen addTarget:self action:@selector(xuanZeGongRenChick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.xuanZeGongRen.backgroundColor = kNavBarColor;
    [self.xuanZeGongRen.layer setMasksToBounds:YES];
    [self.xuanZeGongRen.layer setCornerRadius:3];
    self.xuanZeGongRen.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.xuanZeGongRen setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.xuanZeGongRen setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:self.xuanZeGongRen];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35-50) style:UITableViewStylePlain];
    self.main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    [self postrequest_methodList];
}

-(void)xuanZeGongRenChick:(UIButton *)sender
{
    if (self.xuanZhongArray.count<=0) {
        [self showMessageWindowWithTitle:@"请选择人员" point:self.view.center delay:0.8];
        return;
    }
    NSString *subject_id = @"";
    for (int i = 0; i<self.chuanRuArra.count; i++) {
        OrignalModel *model = self.chuanRuArra[i];
        if (subject_id.length>0) {
            subject_id = [NSString stringWithFormat:@"%@,%@",subject_id,model.subject_id];
        }else
        {
            subject_id = model.subject_id;
        }
    }
    NSString *operation = @"";
    NSString *name = @"";
    for (int i = 0; i<self.xuanZhongArray.count; i++) {
        ConstructionStaffModel *model = self.xuanZhongArray[i];
        if (operation.length>0) {
            operation = [NSString stringWithFormat:@"%@,%@",operation,model.staff_id];
            name = [NSString stringWithFormat:@"%@|%@",name,model.real_name];
        }else
        {
            operation = model.staff_id;
            name = model.real_name;
        }
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.ordercode forKey:@"ordercode"];
    [mDict setObject:subject_id forKey:@"subject_id"];
    [mDict setObject:operation forKey:@"operation"];
    ConstructionPersonnelViewController *vc = (ConstructionPersonnelViewController *)self.superViewController;
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/simple_manage_assign" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] != 200) {
            [self showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }else
        {
            for (int i = 0; i<vc.chuanRuArray.count; i++) {
                OrignalModel *model = vc.chuanRuArray[i];
                if (model.shiFouXuanZhong == YES) {
                    model.operation = name;
                }
            }
            [vc.main_tableView reloadData];
            [weakSelf.navigationController  popViewControllerAnimated:YES];
        }
    } failure:^(id error) {
        
    }];
}

#pragma mark - 配件明细
-(void)postrequest_methodList{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/oper_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] != 200) {
            [self showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }else
        {
            [weakSelf.zongDataArray removeAllObjects];
            
            NSArray *works = KISDictionaryHaveKey(dataDic, @"works");
            for (int i = 0; i<works.count; i++) {
                ConstructionPersonnelErModel *model = [[ConstructionPersonnelErModel alloc]init];
                
                model.zheHe = YES;
                [model setQingQiuData:works[i]];
                [weakSelf.zongDataArray addObject:model];
            }
            [weakSelf.main_tableView reloadData];
        }
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.zongDataArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        ConstructionPersonnelErModel *model = self.zongDataArray[section - 1];
        if (model.zheHe == YES) {
            return 1;
        }else
        {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    ConstructionPersonnelErCell *cell = (ConstructionPersonnelErCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[ConstructionPersonnelErCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    cell.superViewController = self;
    
    if (indexPath.section == 0) {
        [cell refeleseWithModel:self.xuanZhongArray withXiuGai:YES withXiuGaiArray:self.xuanZhongArray];
    }else
    {
        ConstructionPersonnelErModel *model = self.zongDataArray[indexPath.section - 1];
        [cell refeleseWithModel:model.staff withXiuGai:NO withXiuGaiArray:self.xuanZhongArray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (kWindowW/4+20);
    }else
    {
        ConstructionPersonnelErModel *model = self.zongDataArray[indexPath.section - 1];
        NSArray *array = model.staff;
        return (array.count/4+1)*(kWindowW/4+20);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = kRGBColor(240, 240, 240);
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = [UIColor whiteColor];
    UILabel *zuoLabel = [[UILabel alloc]init];
    zuoLabel.font = [UIFont systemFontOfSize:14];
    [headerV addSubview:zuoLabel];
    [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(headerV);
    }];
    
    UIImageView *biaoJi = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_arrow_down")];
    [headerV addSubview:biaoJi];
    [biaoJi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(headerV);
    }];
    
    UIButton *xiangXiaZhanShibt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-40, 0, 40, 38)];
    xiangXiaZhanShibt.tag = 1000 + section;
    [xiangXiaZhanShibt addTarget:self action:@selector(xiangXiaZhanShibtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerV addSubview:xiangXiaZhanShibt];
    
    UIButton *quanXuanBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-100, 0, 60, 38)];
    [quanXuanBt setTitle:@"全选" forState:(UIControlStateNormal)];
    quanXuanBt.tag = 2000 + section;
    [quanXuanBt setTitleColor:kNavBarColor forState:(UIControlStateNormal)];
    [quanXuanBt addTarget:self action:@selector(quanXuanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerV addSubview:quanXuanBt];
    
    if (section == 0) {
        zuoLabel.text = @"已派人员";
        zuoLabel.textColor = [UIColor grayColor];
        biaoJi.hidden = YES;
        xiangXiaZhanShibt.hidden = YES;
        quanXuanBt.hidden = YES;
    }else
    {
        ConstructionPersonnelErModel *model = self.zongDataArray[section - 1];
        zuoLabel.text = model.type_name;
        zuoLabel.textColor = [UIColor blackColor];
        biaoJi.hidden = NO;
        xiangXiaZhanShibt.hidden = NO;
        if (model.zheHe == YES) {
            quanXuanBt.hidden = NO;
        }else
        {
            quanXuanBt.hidden = YES;
        }
    }
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [headerV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    return headerV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
}

-(void)xiangXiaZhanShibtChick:(UIButton *)sender
{
    NSInteger inde = sender.tag - 1000;
    ConstructionPersonnelErModel *model = self.zongDataArray[inde - 1];
    model.zheHe = !model.zheHe;
    
    [self.main_tableView reloadData];
}

-(void)quanXuanBtChick:(UIButton *)sender
{
    NSInteger inde = sender.tag - 2000;
    ConstructionPersonnelErModel *model = self.zongDataArray[inde - 1];
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:model.staff];
    for (int i = 0; i<array.count; i++) {
        ConstructionStaffModel *modelStaff = array[i];
        modelStaff.shiFouXuanZhong = YES;
    }
    
    [self.xuanZhongArray removeAllObjects];
    for (int i = 0; i<self.zongDataArray.count; i++) {
        ConstructionPersonnelErModel *model2 = self.zongDataArray[i];
        NSMutableArray *array2 = [[NSMutableArray alloc]initWithArray:model2.staff];
        for (int j = 0; j<array2.count; j++) {
            ConstructionStaffModel *modelStaff = array2[j];
            if (modelStaff.shiFouXuanZhong == YES) {
                [self.xuanZhongArray addObject:modelStaff];
            }
        }
    }
    
    
    [self.main_tableView reloadData];
}

@end
