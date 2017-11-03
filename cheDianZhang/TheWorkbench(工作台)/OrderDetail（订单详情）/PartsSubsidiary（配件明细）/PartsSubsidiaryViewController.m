//
//  PartsSubsidiaryViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PartsSubsidiaryViewController.h"
#import "OrderDetailCell2.h"
#import "ProjectDetailsCell.h"
#import "NewJianPanShuView.h"
#import "ProjectDetailsADDVC.h"
#import "ProjectDetailsADDZDYVC.h"

@interface PartsSubsidiaryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *shangView;
@property(nonatomic,strong)UIView *shangView2;

@property(nonatomic,strong)UIButton *bianJiButton;

@property(nonatomic,strong)UIButton *tianJiabt;

@end

@implementation PartsSubsidiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"配件明细" withBackButton:YES];
    self.bianJiButton = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 20, 44, 44)];
    [self.bianJiButton addTarget:self action:@selector(bianJiButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bianJiButton setTitle:@"编辑" forState:(UIControlStateNormal)];
    [self.bianJiButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [m_baseTopView addSubview:self.bianJiButton];
    
    self.shangView.hidden = NO;
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35-50) style:UITableViewStylePlain];
    self.main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
    
    self.tianJiabt = [[UIButton alloc]initWithFrame:CGRectMake(50, kWindowH-50, kWindowW-100, 35)];
    [self.tianJiabt addTarget:self action:@selector(tianJiabtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.tianJiabt.backgroundColor = kRGBColor(220, 220, 220);
    self.tianJiabt.userInteractionEnabled = NO;
    [self.tianJiabt.layer setMasksToBounds:YES];
    [self.tianJiabt.layer setCornerRadius:3];
    self.tianJiabt.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.tianJiabt setTitle:@"+ 添加配件" forState:(UIControlStateNormal)];
    [self.tianJiabt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:self.tianJiabt];
}

-(UIView *)shangView
{
    if (!_shangView) {
        _shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 30)];
        _shangView.backgroundColor = kRGBColor(240, 240, 240);
        [self.view addSubview:_shangView];
        UILabel *la = [[UILabel alloc]init];
        la.textColor = [UIColor grayColor];
        la.text = @"配件信息";
        la.font = [UIFont systemFontOfSize:14];
        [_shangView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(_shangView);
        }];
        _shangView.hidden = YES;
    }
    return _shangView;
}
-(UIView *)shangView2
{
    if (!_shangView2) {
        _shangView2 = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, 30)];
        _shangView2.backgroundColor = kRGBColor(240, 240, 240);
        [self.view addSubview:_shangView2];
        
        self.quanXuanBt = [[UIButton alloc]init];
        [self.quanXuanBt setImage:DJImageNamed(@"cell_noselect") forState:(UIControlStateNormal)];
        [self.quanXuanBt setImage:DJImageNamed(@"cell_select") forState:(UIControlStateSelected)];
        [self.quanXuanBt setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [self.quanXuanBt addTarget:self action:@selector(quanXuanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_shangView2 addSubview:self.quanXuanBt];
        [self.quanXuanBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(_shangView);
            make.width.height.mas_equalTo(30);
        }];
        
        
        UILabel *la = [[UILabel alloc]init];
        la.textColor = [UIColor grayColor];
        la.text = @"配件信息";
        la.font = [UIFont systemFontOfSize:14];
        [_shangView2 addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.quanXuanBt.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(_shangView);
        }];
        
        UIButton *shanChuBt = [[UIButton alloc]init];
        [shanChuBt setImage:DJImageNamed(@"car_delete") forState:(UIControlStateNormal)];
        [shanChuBt setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [shanChuBt addTarget:self action:@selector(shanChuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_shangView2 addSubview:shanChuBt];
        [shanChuBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(_shangView);
            make.width.height.mas_equalTo(30);
        }];
        
        _shangView2.hidden = YES;
    }
    return _shangView2;
}

-(void)shanChuBtChick:(UIButton *)sender
{
    NSInteger index = self.chuanRuArray.count;
    
    for (int i = 0; i<index; i++) {
        if (i<self.chuanRuArray.count) {
            PeiJianListModel *orignalModel = self.chuanRuArray[i];
            if (orignalModel.shiFouXuanZhong == YES) {
                [self.chuanRuArray removeObject:orignalModel];
                i--;
            }
        }
    }
    [self.main_tableView reloadData];
}

-(void)quanXuanBtChick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    for (int i = 0; i<self.chuanRuArray.count; i++) {
        PeiJianListModel *orignalModel = self.chuanRuArray[i];
        orignalModel.shiFouXuanZhong = sender.selected;
    }
    
    [self.main_tableView reloadData];
}

-(void)backButtonClick:(id)sender
{
    OrderDetailViewController *vc = (OrderDetailViewController *)self.suerViewController;
    [vc postpeiJianMingXiWithModel:vc.chuanzhiModel withTiaoZhua:NO With:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bianJiButtonChick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        [sender setTitle:@"确定" forState:(UIControlStateNormal)];
        self.tianJiabt.backgroundColor = [UIColor orangeColor];
        self.tianJiabt.userInteractionEnabled = YES;
        
        self.shangView.hidden = YES;
        self.shangView2.hidden = NO;
        [self.main_tableView reloadData];
    }else
    {
        NSMutableArray *tiJiaoArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<self.chuanRuArray.count; i++) {
            PeiJianListModel *model = self.chuanRuArray[i];
            NSDictionary *dict = @{@"parts_id":[NSString stringWithFormat:@"%@",model.parts_id],@"parts_num":[NSString stringWithFormat:@"%@",model.parts_num],@"parts_fee":[NSString stringWithFormat:@"%@",model.parts_fee],@"name":[NSString stringWithFormat:@"%@",model.cname],@"name":[NSString stringWithFormat:@"%@",model.cname],@"cost":@"",@"partsattribute":@"",};
            [tiJiaoArray addObject:dict];
        }
        
        NSArray *ar = tiJiaoArray;
        
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:self.ordercode forKey:@"ordercode"];
        [dict setObject:ar forKey:@"parts"];
        
        NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
        [mDict setObject:[self convertToJsonData:dict] forKey:@"modify_upload"];
        
        kWeakSelf(weakSelf)
        [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/modify_parts" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
            
            if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] != 200) {
                [self showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                return;
            }else
            {
                OrderDetailViewController *vc = (OrderDetailViewController *)self.suerViewController;
                [vc postpeiJianMingXiWithModel:vc.chuanzhiModel withTiaoZhua:NO With:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(id error) {
            
        }];
        
    }
}

// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


-(void)tianJiabtChick:(UIButton *)sender
{
    PartsSubsidiaryADDViewController *vc = [[PartsSubsidiaryADDViewController alloc]init];
    vc.suerViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chuanRuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.bianJiButton.titleLabel.text isEqualToString:@"编辑"]) {
        static NSString *myIdentifier = @"Cell2";
        OrderDetailCell2 *cell = (OrderDetailCell2 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refelesePeiJianWithModel:self.chuanRuArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *myIdentifier = @"Cell";
        PartsSubsidiaryCell *cell = (PartsSubsidiaryCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[PartsSubsidiaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refelesePeiJianWithModel:self.chuanRuArray[indexPath.row]];
        kWeakSelf(weakSelf)
        cell.tableViewShuaXinBlock = ^{
            BOOL shiFouQuanXuan = YES;
            for (int i = 0; i<weakSelf.chuanRuArray.count; i++) {
                PeiJianListModel *orignalModel = weakSelf.chuanRuArray[i];
                if (orignalModel.shiFouXuanZhong == NO) {
                    shiFouQuanXuan = NO;
                }
            }
            
            weakSelf.quanXuanBt.selected = shiFouQuanXuan;
            
            [weakSelf.main_tableView reloadData];
        };
        cell.xiuGaiGongShiBlock = ^(PeiJianListModel *peiJianModel) {
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:peiJianModel.parts_num];
            multipleView.xiaoShuWeiShu = 1;
            multipleView.zuiDaZhiFloat = [peiJianModel.parts_total floatValue];
            multipleView.okClick = ^(NSString* value){
                CGFloat filortValue = [value floatValue];
                if (filortValue > [peiJianModel.parts_total floatValue]) {
                    peiJianModel.parts_num = peiJianModel.parts_total;
                }else{
                    peiJianModel.parts_num = value;
                }
                
                
                [weakSelf.main_tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        
        cell.xiuGaiGongShiFeiBlock = ^(PeiJianListModel *peiJianModel) {
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:peiJianModel.parts_fee];
            multipleView.xiaoShuWeiShu = 1;
            multipleView.zuiDaZhiFloat = 99999.9;
            multipleView.okClick = ^(NSString* value){
                peiJianModel.parts_fee = value;
                
                [weakSelf.main_tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

@end
