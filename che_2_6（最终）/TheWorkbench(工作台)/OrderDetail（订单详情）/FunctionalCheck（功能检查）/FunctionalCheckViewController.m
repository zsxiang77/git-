//
//  FunctionalCheckViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "FunctionalCheckViewController.h"
#import "AccessoryEquipmentCell.h"
#import "HPGrowingTextView.h"
#import "FunctionalCheckModel.h"
#import "JieCheInformiTionVC.h"

@interface FunctionalCheckViewController ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate>

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)HPGrowingTextView *schemeTextView;

@end

@implementation FunctionalCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"功能检查" withBackButton:YES];
    
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.functions_remark = @"";
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    [self postHuoQuOrder_functions];
}

-(void)postHuoQuOrder_functions
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/order_functions" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        weakSelf.functions_remark = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dataDic, @"functions_remark")];
        NSArray *functions = KISDictionaryHaveKey(dataDic, @"functions");
        for (int i = 0; i<functions.count; i++) {
            FunctionalCheckModel *model = [[FunctionalCheckModel alloc]init];
            [model setDataShuJu:functions[i]];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myIdentifier = @"Cell";
    AccessoryEquipmentCell *cell = (AccessoryEquipmentCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AccessoryEquipmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    FunctionalCheckModel *model = self.dataArray[indexPath.row];
    
    cell.zuoTitelLabel.text = model.name;
    if (model.dataBool == YES) {
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
    FunctionalCheckModel *model = self.dataArray[indexPath.row];
    model.dataBool = !model.dataBool;
    [self.mainTableView  reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView  = [[UIView alloc]init];
    footView.backgroundColor = self.view.backgroundColor;
    UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWindowW-20, 40)];
    shuoMingLabel.textColor = [UIColor grayColor];
    shuoMingLabel.text = @"备注";
    [footView addSubview:shuoMingLabel];
    
    UIView *whiBeiJingView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 60)];
    whiBeiJingView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:whiBeiJingView];
    
    self.schemeTextView = [[HPGrowingTextView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 100)];
    self.schemeTextView.text = self.functions_remark;
    self.schemeTextView.isScrollable = NO;
    self.schemeTextView.minNumberOfLines = 1;
    self.schemeTextView.maxNumberOfLines = 6;
    self.schemeTextView.font = [UIFont systemFontOfSize:13];
    self.schemeTextView.delegate = self;
    self.schemeTextView.returnKeyType = UIReturnKeyDone;
    self.schemeTextView.placeholder = @"为防止车主贵重物品丢失，请提示带走..";
    self.schemeTextView.placeholderColor = kRGBColor(220, 220, 220);
    [footView addSubview:self.schemeTextView];
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    if (self.shiFouFanHui == YES) {
        [queDingBt setTitle:@"确定" forState:(UIControlStateNormal)];
    }else{
        [queDingBt setTitle:@"下一步" forState:(UIControlStateNormal)];
    }
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [footView addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.schemeTextView.mas_bottom).mas_equalTo(40);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    
    
    return footView;
}

-(void)queDingBtChick:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    
    NSString *exist = @"";
    for (int i = 0; i<self.dataArray.count; i++) {
        FunctionalCheckModel *model = self.dataArray[i];
        if (model.dataBool == YES) {
            if (exist.length>0) {
                exist = [NSString stringWithFormat:@"%@,%@",exist,model.overhaul_id];
            }else{
                exist = model.overhaul_id;
            }
        }
    }
    
    [mDict setObject:exist forKey:@"abnormal"];
    [mDict setObject:self.schemeTextView.text forKey:@"functions_remark"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/pull_functions" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (weakSelf.shiFouFanHui == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            JieCheInformiTionVC *vc = [[JieCheInformiTionVC alloc]init];
            vc.chuaOrdercode = weakSelf.chuaOrdercode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(id error) {
        
    }];
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.schemeTextView resignFirstResponder];
        return NO;
    }
    
    if (self.schemeTextView.text.length>255) {//50字
        return NO;
    }else
    {
        self.functions_remark = text;
        return YES;
    }
    
}

@end
