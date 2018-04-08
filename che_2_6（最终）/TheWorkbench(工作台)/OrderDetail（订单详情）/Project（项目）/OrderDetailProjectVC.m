//
//  OrderDetailProjectVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailProjectVC.h"
#import "OrderDetailProjectCell1.h"
#import "OrderDetailProjectCell2.h"
#import "ProjectDetailsADDVC.h"
#import "OrderDetailProjectVC.h"
#import "NewJianPanShuView.h"

@interface OrderDetailProjectVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)BOOL shiFouDanGePG;
@property(nonatomic,strong)OrderDetailSubjectsModel *shiFouDanGePGModel;

@end

@implementation OrderDetailProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加项目" withBackButton:YES];
    
    UIButton *piLiangBt = [[UIButton alloc]init];
    piLiangBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [piLiangBt setTitle:@"批量派工" forState:(UIControlStateNormal)];
    [piLiangBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    [piLiangBt addTarget:self action:@selector(piLiangBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [m_baseTopView addSubview:piLiangBt];
    [piLiangBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *okButton = [[UIButton alloc]init];
    [okButton addTarget:self action:@selector(okButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    okButton.backgroundColor = kZhuTiColor;
    [okButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [okButton.layer setCornerRadius:3];
    [okButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [okButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-13);
        make.height.mas_equalTo(35);
    }];
    
    self.tianJiaArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.chuanZhiArray.count; i++) {
        [self.tianJiaArray addObject:self.chuanZhiArray[i]];
    }
    
    [self.main_tabelView reloadData];
    
    UIButton *tianJianBt = [[UIButton alloc]init];
    [tianJianBt setBackgroundImage:DJImageNamed(@"order_xiangMu_add") forState:(UIControlStateNormal)];
    [tianJianBt addTarget:self action:@selector(tianJianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:tianJianBt];
    [tianJianBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-86);
        make.width.height.mas_equalTo(50);
    }];
}

#pragma mark - 派工
-(void)piLiangBtChick:(UIButton *)sender
{
    self.shiFouDanGePG = NO;
    if (self.paiGongArray) {
        if (self.paiGongArray.count>0) {
            self.orderDetailProjectPGView.chuanZhiArray = self.paiGongArray;
            self.orderDetailProjectPGView.hidden = NO;
            [self.view bringSubviewToFront:self.orderDetailProjectPGView];
            [self.orderDetailProjectPGView zhuXianShi];
        }else{
            [self postrequest_methodList];
        }
    }else{
       [self postrequest_methodList];
    }
    
}
-(void)danGePaiGong:(OrderDetailSubjectsModel *)model{
    self.shiFouDanGePGModel = model;
    self.shiFouDanGePG = YES;
    if (self.paiGongArray) {
        if (self.paiGongArray.count>0) {
            self.orderDetailProjectPGView.chuanZhiArray = self.paiGongArray;
            self.orderDetailProjectPGView.hidden = NO;
            [self.view bringSubviewToFront:self.orderDetailProjectPGView];
            [self.orderDetailProjectPGView zhuXianShi];
        }else{
            [self postrequest_methodList];
        }
    }else{
        [self postrequest_methodList];
    }
}

-(OrderDetailProjectPGView *)orderDetailProjectPGView
{
    if (!_orderDetailProjectPGView) {
        _orderDetailProjectPGView = [[OrderDetailProjectPGView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        kWeakSelf(weakSelf)
        _orderDetailProjectPGView.queDingBlock = ^{
            for (int i = 0; i<weakSelf.tianJiaArray.count; i++) {
                OrderDetailSubjectsModel *model = weakSelf.tianJiaArray[i];
                model.shiFouBianJi = NO;
            }
            
            
            NSString *operation = @"";
            NSString *operation_name = @"";
            for (int i = 0; i<weakSelf.paiGongArray.count; i++) {
                PaiGongModel *model = weakSelf.paiGongArray[i];
                for (int j = 0; j<model.staff.count; j++) {
                    PaiGongStaffModel *netbib = model.staff[j];
                    if (netbib.shiFouXuanZhong == YES) {
                        [weakSelf.xuanZhongPaiGongArray addObject:netbib];
                        if (operation.length<=0) {
                            operation_name = netbib.real_name;
                            operation = netbib.staff_id;
                        }else{
                            operation_name = [NSString stringWithFormat:@"%@,%@",operation_name,netbib.real_name];
                            operation = [NSString stringWithFormat:@"%@,%@",operation,netbib.staff_id];
                        }
                    }
                }
            }
            
            if (weakSelf.shiFouDanGePG == NO) {
                for (int i = 0; i<weakSelf.tianJiaArray.count ; i++) {
                    OrderDetailSubjectsModel *model = weakSelf.tianJiaArray[i];
                    model.operation = operation;
                    model.operation_name = operation_name;
                }
            }else{
                weakSelf.shiFouDanGePGModel.operation = operation;
                weakSelf.shiFouDanGePGModel.operation_name = operation_name;
            }
            
            [weakSelf.main_tabelView reloadData];
            weakSelf.orderDetailProjectPGView.hidden = YES;
        };
        _orderDetailProjectPGView.hidden = YES;
        [self.view addSubview:_orderDetailProjectPGView];
    }
    return _orderDetailProjectPGView;
}
-(void)okButtonChick:(UIButton *)sender
{
    NSMutableArray *tiJiaoArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.tianJiaArray.count; i++) {
        OrderDetailSubjectsModel *model = self.tianJiaArray[i];
        NSArray *qwe = [[NSArray alloc]init];
        NSDictionary *dict = @{@"subject_id":[NSString stringWithFormat:@"%@",model.subject_id],@"hour":[NSString stringWithFormat:@"%@",model.hour],@"fee":[NSString stringWithFormat:@"%@",model.reality_fee],@"parts":qwe,@"operation":model.operation};
        [tiJiaoArray addObject:dict];
    }
    
    NSArray *ar = tiJiaoArray;
    
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.ordercode forKey:@"ordercode"];
    [dict setObject:@"1" forKey:@"is_operation"];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)tianJianBtChick:(UIButton *)sender
{
    ProjectDetailsADDVC *vc = [[ProjectDetailsADDVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.suerViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-48) style:UITableViewStylePlain];
        _main_tabelView.backgroundColor = [UIColor clearColor];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tianJiaArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    kWeakSelf(weakSelf)
    OrderDetailSubjectsModel *model = self.tianJiaArray[indexPath.section];
    if (model.shiFouBianJi == YES) {
        static NSString *myIdentifier = @"Cell";
        OrderDetailProjectCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailProjectCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:model];
        cell.baoCunChcickBlock = ^(void) {
            [weakSelf.main_tabelView reloadData];
        };
        cell.gongShiTextBtChickBlock = ^{
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:model.hour];
            multipleView.xiaoShuWeiShu = 1;
            multipleView.zuiDaZhiFloat = 999.9;
            multipleView.okClick = ^(NSString* value){
                model.hour = value;
                [weakSelf.main_tabelView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        cell.gongShiTextBtnField = ^{
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:model.reality_fee];
            multipleView.xiaoShuWeiShu = 2;
            multipleView.zuiDaZhiFloat = 99999.99;
            multipleView.okClick = ^(NSString* value){
                model.reality_fee = value;
                
                [weakSelf.main_tabelView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *myIdentifier = @"Cell2";
        OrderDetailProjectCell2 *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailProjectCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:model];
        cell.bianJiBTChcickBlock = ^(void) {
            [weakSelf.main_tabelView reloadData];
        };
        cell.paiGongBtChcickBlock = ^(OrderDetailSubjectsModel *model) {
            [weakSelf danGePaiGong:model];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailSubjectsModel *model = self.tianJiaArray[indexPath.section];
    if (model.shiFouBianJi == YES) {
        return 155/2.0+10;
    }else{
        return 214/2.0+10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headViw = [[UIView alloc]init];
    headViw.backgroundColor = [UIColor clearColor];
    return headViw;
}

/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tianJiaArray removeObject:self.tianJiaArray[indexPath.section]];
    [self.main_tabelView reloadData];
}
/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
