//
//  AccessoriesViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "AccessoriesViewController.h"
#import "OrderDetailAccessoriesCell1.h"
#import "OrderDetailAccessoriesCell2.h"
#import "PartsSubsidiaryADDViewController.h"
#import "NewJianPanShuView.h"

@interface AccessoriesViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AccessoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"配件详情" withBackButton:YES];
    self.tianJiaArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.chuanZhiArray.count; i++) {
        [self.tianJiaArray addObject:self.chuanZhiArray[i]];
    }
    
    [self.main_tabelView reloadData];
    
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
        make.height.mas_equalTo(94/2);
    }];
    
    UIButton *tianJianBt = [[UIButton alloc]init];
    [tianJianBt setBackgroundImage:DJImageNamed(@"order_xiangMu_add") forState:(UIControlStateNormal)];
    [tianJianBt addTarget:self action:@selector(tianJianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:tianJianBt];
    [tianJianBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-86);
        make.width.height.mas_equalTo(50);
    }];
    [self.view bringSubviewToFront:tianJianBt];
}
-(void)tianJianBtChick:(UIButton *)sender
{
    PartsSubsidiaryADDViewController *vc= [[PartsSubsidiaryADDViewController alloc]init];
    vc.suerViewController = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)okButtonChick:(UIButton *)sender
{
    NSMutableArray *tiJiaoArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.tianJiaArray.count; i++) {
        OrderDetailPartsModel *model = self.tianJiaArray[i];
        NSDictionary *dict = @{@"parts_brand":[NSString stringWithFormat:@"%@",model.parts_brand],@"parts_id":[NSString stringWithFormat:@"%@",model.parts_id],@"parts_name":[NSString stringWithFormat:@"%@",model.parts_name],@"parts_num":[NSString stringWithFormat:@"%@",model.parts_num],@"parts_fee":[NSString stringWithFormat:@"%@",model.parts_fee],@"parts_code":[NSString stringWithFormat:@"%@",model.parts_code],@"unit":[NSString stringWithFormat:@"%@",model.unit],@"count":[NSString stringWithFormat:@"%@",model.count]};
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
    OrderDetailPartsModel *model = self.tianJiaArray[indexPath.section];
    if (model.shiFouBianJi == YES) {
        static NSString *myIdentifier = @"Cell";
        OrderDetailAccessoriesCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailAccessoriesCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:model];
        cell.baoCunChcickBlock = ^(void) {
            [weakSelf.main_tabelView reloadData];
        };
        cell.gongShiTextBtChickBlock = ^{
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:model.parts_num];
            multipleView.xiaoShuWeiShu = 1;
            multipleView.zuiDaZhiFloat = [model.count floatValue];
            multipleView.okClick = ^(NSString* value){
                model.parts_num = value;
                [weakSelf.main_tabelView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        cell.gongShiTextBtnField = ^{
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:model.parts_fee];
            multipleView.xiaoShuWeiShu = 2;
            multipleView.zuiDaZhiFloat = 99999.99;
            multipleView.okClick = ^(NSString* value){
                model.parts_fee = value;
                
                [weakSelf.main_tabelView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *myIdentifier = @"Cell2";
        OrderDetailAccessoriesCell2 *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[OrderDetailAccessoriesCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:model];
        cell.bianJiBTChcickBlock = ^(void) {
            [weakSelf.main_tabelView reloadData];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 231/2;
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
