//
//  HaoCaiViewController.m
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//
#import "HaoCaiViewController.h"
#import "XiMeiNewOrdersErModel.h"
#import "HaoCaiTableViewCell.h"
#import "HaoCaiTableViewCell2.h"
#import "NewJianPanShuView.h"
#import "HaoCaiAddViewController.h"
@interface HaoCaiViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HaoCaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"耗材详情" withBackButton:YES];
    self.xinZengArray = [[NSMutableArray  alloc]init];
    if (self.chuanZhiArray.count>0) {
        for (int i = 0; i<self.chuanZhiArray.count; i++) {
            
            Service_commods *model = [[Service_commods alloc]init];
            [model setDictData:self.chuanZhiArray[i]];
            
            NPrintLog(@"打印文本%@",self.chuanZhiArray[i]);
            model.shiFouKeShan  = NO;
            model.xuanZhong = NO;
            [self.xinZengArray addObject:model];
        }
    }
    
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
-(void)okButtonChick:(UIButton *)sender
{
    NSMutableArray *tiJiaoArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.xinZengArray.count; i++) {
        Service_commods *model = self.xinZengArray[i];
        NSDictionary *dict = @{@"commodity_id":[NSString stringWithFormat:@"%@",model.commodity_id],@"name":[NSString stringWithFormat:@"%@",model.name],@"commodity_num":[NSString stringWithFormat:@"%@",model.count],@"commodity_sku":model.sku_properties,@"fee":model.price};
        [tiJiaoArray addObject:dict];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.ordercode forKey:@"ordercode"];
    
    [dict setObject:[self convertToJsonDataWithArray:tiJiaoArray] forKey:@"commodity"];
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:dict withUrl:@"order/new_order/add_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
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
-(void)tianJianBtChick:(UIButton *)sender
{
    HaoCaiAddViewController * vc = [[HaoCaiAddViewController alloc]init];
    kWeakSelf(weakSelf)
    vc.xuanZhongArrayBlock = ^(NSArray *array) {
        for (int i = 0; i<array.count; i++) {
            [weakSelf.xinZengArray addObject:array[i]];
        }
        [weakSelf.main_tabelView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-(94/2+15)) style:UITableViewStylePlain];
        _main_tabelView.backgroundColor = [UIColor clearColor];
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_main_tabelView];
    }
    return _main_tabelView;
}
#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.xinZengArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    kWeakSelf(weakSelf)
    Service_commods *model = self.xinZengArray[indexPath.section];
    if (model.shiFouKeShan == YES) {
        static NSString *myIdentifier = @"Cell";
        HaoCaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[HaoCaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        [cell refeleseWithModel:model];
        cell.baoCunChcickBlock = ^(void) {
            [weakSelf.main_tabelView reloadData];
        };
        cell.shuliangTextBtChickBlock = ^(Service_commods *model) {
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:0];
            multipleView.xiaoShuWeiShu = 1;
            multipleView.zuiDaZhiFloat = 999.9;
            multipleView.okClick = ^(NSString* value){
                model.count = value;
                [weakSelf.main_tabelView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        
        cell.jiageTextBtnField = ^(Service_commods *model){
            NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:0];
            multipleView.xiaoShuWeiShu = 2;
            multipleView.zuiDaZhiFloat = 99999.99;
            multipleView.okClick = ^(NSString* value){
                 model.price = value;
                [weakSelf.main_tabelView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
            [multipleView displayView];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *myIdentifier = @"Cell2";
        HaoCaiTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
        cell = [[HaoCaiTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
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
    Service_commods *model = self.xinZengArray[indexPath.section];
    if (model.xuanZhong == YES) {
        return 214/2.0+10;
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
    [self.xinZengArray removeObject:self.xinZengArray[indexPath.section]];
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
