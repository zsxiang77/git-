//
//  AccessoryEquipmentVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AccessoryEquipmentVC.h"
#import "AccessoryEquipmentCell.h"
#import "AccessoryEquipmentModel.h"
#import "HPGrowingTextView.h"
#import "FunctionalCheckViewController.h"

@interface AccessoryEquipmentVC ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate>

@property(nonatomic,strong)HPGrowingTextView *schemeTextView;

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)NSString *goods_remarkStr;

@end

@implementation AccessoryEquipmentVC

- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}
#pragma 键盘的通知
- (void) keyboardWillShow:(NSNotification*)noti
{
    CGRect keyboardFrameBeginRect = [[[noti userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainTableView.frame = CGRectMake(0, kNavBarHeight-keyboardFrameBeginRect.size.height+70, kWindowW, kWindowH-kNavBarHeight);
        [weakSelf setNavBarToBring];
    }];
}

- (void) keyboardWillHidden:(NSNotification*)noti
{
    
    kWeakSelf(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainTableView.frame = CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"随车装备" withBackButton:YES];
    
    self.goods_remarkStr = @"";
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    [self postHuoQuOrder_goods];
    
}

-(void)postHuoQuOrder_goods
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/order_goods" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        NSArray *goods = KISDictionaryHaveKey(dataDic, @"goods");
        for (int i = 0; i<goods.count; i++) {
            AccessoryEquipmentModel *model = [[AccessoryEquipmentModel alloc]init];
            [model setDataShuJu:goods[i]];
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
    AccessoryEquipmentModel *model = self.dataArray[indexPath.row];

    cell.zuoTitelLabel.text = model.name;
    if (model.dataBool == YES) {
        cell.youLabel.text = @"有";
        cell.xuanZhongImaheView.image = [UIImage imageNamed:@"cell_select"];
    }else{
        cell.youLabel.text = @"无";
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
    AccessoryEquipmentModel *model = self.dataArray[indexPath.row];
    model.dataBool = !model.dataBool;
    [self.mainTableView  reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView  = [[UIView alloc]init];
    UILabel *shuoMingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWindowW-20, 40)];
    shuoMingLabel.textColor = [UIColor grayColor];
    shuoMingLabel.text = @"备注";
    [footView addSubview:shuoMingLabel];

    UIView *whiBeiJingView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 60)];
    whiBeiJingView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:whiBeiJingView];

    self.schemeTextView = [[HPGrowingTextView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 100)];
    self.schemeTextView.isScrollable = NO;
    self.schemeTextView.text = self.goods_remarkStr;
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


- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self.goods_remarkStr = self.schemeTextView.text;
    if ([text isEqualToString:@"\n"]) {
        [self.schemeTextView resignFirstResponder];
        return NO;
    }

    if (self.schemeTextView.text.length>255) {//50字
        return NO;
    }else
    {
        return YES;
    }

}

-(void)queDingBtChick:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.chuaOrdercode forKey:@"ordercode"];
    
    NSString *exist = @"";
    for (int i = 0; i<self.dataArray.count; i++) {
        AccessoryEquipmentModel *model = self.dataArray[i];
        if (model.dataBool == YES) {
            if (exist.length>0) {
                exist = [NSString stringWithFormat:@"%@,%@",exist,model.overhaul_id];
            }else{
                exist = model.overhaul_id;
            }
        }
    }
    
    [mDict setObject:exist forKey:@"exist"];
    [mDict setObject:self.schemeTextView.text forKey:@"goods_remark"];

    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/pull_goods" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if (weakSelf.shiFouFanHui == YES) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            FunctionalCheckViewController *vc = [[FunctionalCheckViewController alloc]init];
            vc.chuaOrdercode = weakSelf.chuaOrdercode;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(id error) {
        
    }];
}

@end
