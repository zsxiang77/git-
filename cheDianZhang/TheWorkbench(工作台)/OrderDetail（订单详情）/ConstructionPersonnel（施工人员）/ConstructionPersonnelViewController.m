//
//  ConstructionPersonnelViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ConstructionPersonnelViewController.h"
#import "ConstructionPersonnelCell.h"
#import "ConstructionPersonnelErVC.h"

@interface ConstructionPersonnelViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIButton *bianJiButton;

@property(nonatomic,strong)UIButton *xuanZeGongRen;

@property(nonatomic,strong)UIButton *quanXuanBt;

@end

@implementation ConstructionPersonnelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"选择施工人员" withBackButton:YES];
    
    for (int i = 0; i<self.chuanRuArray.count; i++) {
        OrignalModel *model = self.chuanRuArray[i];
        model.shiFouXuanZhong = NO;
    }
    
    self.bianJiButton = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 20, 44, 44)];
    [self.bianJiButton addTarget:self action:@selector(bianJiButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bianJiButton setTitle:@"完成" forState:(UIControlStateNormal)];
    [self.bianJiButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [m_baseTopView addSubview:self.bianJiButton];
    
    self.quanXuanBt = [[UIButton alloc]init];
    [self.quanXuanBt setImage:DJImageNamed(@"cell_noselect") forState:(UIControlStateNormal)];
    [self.quanXuanBt setImage:DJImageNamed(@"cell_select") forState:(UIControlStateSelected)];
    [self.quanXuanBt setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [self.quanXuanBt addTarget:self action:@selector(quanXuanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.quanXuanBt];
    [self.quanXuanBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarHeight);
        make.width.height.mas_equalTo(35);
    }];
    
    
    UILabel *la = [[UILabel alloc]init];
    la.textColor = [UIColor grayColor];
    la.text = @"维修项目";
    la.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.quanXuanBt.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(self.quanXuanBt);
    }];
    
    self.xuanZeGongRen = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-50, kWindowW-40, 35)];
    [self.xuanZeGongRen addTarget:self action:@selector(xuanZeGongRenChick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.xuanZeGongRen.backgroundColor = kNavBarColor;
    [self.xuanZeGongRen.layer setMasksToBounds:YES];
    [self.xuanZeGongRen.layer setCornerRadius:3];
    self.xuanZeGongRen.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.xuanZeGongRen setTitle:@"选择施工人员" forState:(UIControlStateNormal)];
    [self.xuanZeGongRen setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:self.xuanZeGongRen];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35-50) style:UITableViewStylePlain];
    self.main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
}

-(void)bianJiButtonChick:(UIButton *)sende
{
    OrderDetailViewController *vc = (OrderDetailViewController *)self.suerViewController;
    [vc postrequest_methodMingXiWithModel:vc.chuanzhiModel withTiaoZhua:NO With:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backButtonClick:(id)sender
{
    OrderDetailViewController *vc = (OrderDetailViewController *)self.suerViewController;
    [vc postrequest_methodMingXiWithModel:vc.chuanzhiModel withTiaoZhua:NO With:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)xuanZeGongRenChick:(UIButton *)sender
{
    BOOL shiF = NO;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.chuanRuArray.count; i++) {
        OrignalModel *model = self.chuanRuArray[i];
        if (model.shiFouXuanZhong == YES) {
            shiF = YES;
            [array addObject:model];
        }
    }
    
    if (shiF == NO) {
        [self showMessageWindowWithTitle:@"请先指定维修项目" point:self.view.center delay:0.8];
        return;
    }
    
    ConstructionPersonnelErVC *vc = [[ConstructionPersonnelErVC alloc]init];
    vc.superViewController = self;
    vc.ordercode = self.ordercode;
    vc.chuanRuArra = array;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)quanXuanBtChick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    for (int i = 0; i<self.chuanRuArray.count; i++) {
        OrignalModel *orignalModel = self.chuanRuArray[i];
        orignalModel.shiFouXuanZhong = sender.selected;
    }
    
    [self.main_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chuanRuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    ConstructionPersonnelCell *cell = (ConstructionPersonnelCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[ConstructionPersonnelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    [cell refeleseWithModel:self.chuanRuArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrignalModel *model = self.chuanRuArray[indexPath.row];
    model.shiFouXuanZhong = !model.shiFouXuanZhong;
    BOOL shifouQuanX = YES;
    for (int i = 0; i<self.chuanRuArray.count; i++) {
        OrignalModel *model2 = self.chuanRuArray[i];
        if (model2.shiFouXuanZhong == NO) {
            shifouQuanX = NO;
        }
    }
    self.quanXuanBt.selected = shifouQuanX;
    
    [self.main_tableView reloadData];
}

@end
