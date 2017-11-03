//
//  FunctionalCheckViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FunctionalCheckViewController.h"
#import "AccessoryEquipmentCell.h"
#import "AccessoryEquipmentModel.h"

@interface FunctionalCheckViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;

@end

@implementation FunctionalCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"接车检查" withBackButton:YES];
    UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 40)];
    titleLa.text = @"2.功能检查";
    titleLa.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLa];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+40, kWindowW, kWindowH-kNavBarHeight-40) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chuRuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"Cell";
    AccessoryEquipmentCell *cell = (AccessoryEquipmentCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AccessoryEquipmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    AccessoryFunctionsModel *model = self.chuRuArray[indexPath.row];
    
    cell.zuoTitelLabel.text = model.name;
    if (model.FunctionXuanZhong == YES) {
        cell.youLabel.text = @"异常";
        cell.youLabel.textColor = [UIColor blackColor];
        cell.xuanZhongImaheView.image = [UIImage imageNamed:@"cell_select"];
    }else{
        cell.youLabel.text = @"正常";
        cell.youLabel.textColor = [UIColor grayColor];
        cell.xuanZhongImaheView.image = [UIImage imageNamed:@"cell_noselect"];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AccessoryFunctionsModel *model = self.chuRuArray[indexPath.row];
    model.FunctionXuanZhong = !model.FunctionXuanZhong;
    [self.mainTableView  reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView  = [[UIView alloc]init];

    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kNavBarColor;
    [queDingBt setTitle:@"下一步" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [footView addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    
    return footView;
}

-(void)queDingBtChick:(UIButton *)sender
{
    
    NSString *abnormal = @"";
    for (int i = 0; i<self.chuRuArray.count; i++) {
        AccessoryFunctionsModel *model = self.chuRuArray[i];
        if (model.FunctionXuanZhong == YES) {
            if (abnormal.length>0) {
                abnormal = [NSString stringWithFormat:@"%@,%@",abnormal,model.overhaul_id];
            }else
            {
                abnormal = [NSString stringWithFormat:@"%@",model.overhaul_id];
            }
        }
    }
    
    self.zuiZhongModel.abnormal = abnormal;
    
    JieCheInformiTionVC *vc = [[JieCheInformiTionVC alloc]init];
    vc.zuiZhongModel = self.zuiZhongModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
