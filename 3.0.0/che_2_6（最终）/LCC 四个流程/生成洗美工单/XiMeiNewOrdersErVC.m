//
//  XiMeiNewOrdersErVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiNewOrdersErVC.h"
#import "NewJianPanShuView.h"
#import "NewMaterialViewController.h"

@interface XiMeiNewOrdersErVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *zuiELabel;

@end

@implementation XiMeiNewOrdersErVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增洗美单" withBackButton:YES];
    
    self.huoQuServiceData = [[XiMeiNewOrdersErModel alloc]init];
    self.service_commodArray = [[NSMutableArray alloc]init];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowH-44, kWindowW, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *shengChengBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-110, 0, 110, 44)];
    [shengChengBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [shengChengBt addTarget:self action:@selector(shengChengBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shengChengBt setTitle:@"生成工单" forState:(UIControlStateNormal)];
    shengChengBt.backgroundColor = kZhuTiColor;
    [bottomView addSubview:shengChengBt];
    
    self.zuiELabel = [[UILabel alloc]init];
    NSMutableAttributedString* att1 = [[NSMutableAttributedString alloc] initWithString:@"工单总额：¥0.00"];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 5)];
    self.zuiELabel.attributedText = att1;
    self.zuiELabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:self.zuiELabel];
    [self.zuiELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(shengChengBt.mas_left).mas_equalTo(-5);
        make.centerY.mas_equalTo(bottomView);
    }];
    
    [self postREQUEST_METHODWithService_id:self.chuZhiModel.serviceid];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.main_tabelView reloadData];
}
-(void)shengChengBtChick:(UIButton *)sender
{
    [self postREQUEST_METHODWithTiaoJiao];
}

-(void)jiSuanZongEQian
{
    CGFloat qian = 0.00;
    if (self.service_commodArray.count>0) {
        
        qian += [self.huoQuServiceData.price floatValue];
        
        for (int i = 0; i<self.service_commodArray.count; i++) {
            Service_commods *model = self.service_commodArray[i];
            if (model.shiFouKeShan == YES) {
                qian += ([model.price floatValue]*[model.count floatValue]);
            }
        }
    }else
    {
        qian += [self.huoQuServiceData.price floatValue];
        
    }
    NSString *qianStr = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",qian]];
    NSMutableAttributedString* att1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"工单总额：%@",qianStr]];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, qianStr.length)];
    self.zuiELabel.attributedText = att1;
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-44) style:UITableViewStylePlain];
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
    if (self.service_commodArray.count>0) {
        return self.service_commodArray.count + 2;
    }else{
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0|| section == 1) {
        return 1;
    }else
    {
        if (self.service_commodArray.count>0) {
            return 3;
        }else{
            return 0;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *myIdentifier = @"Cell1";
        XiMeiNewOrdersErCell1 *cell = (XiMeiNewOrdersErCell1 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[XiMeiNewOrdersErCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.zuoLabel.text = [NSString stringWithFormat:@"车牌号：%@",self.zuiZongModel.car_number];
        cell.youLabel.text = self.zuiZongModel.cars_detail;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1)
    {
        static NSString *myIdentifier = @"Cell2";
        XiMeiNewOrdersErCell1 *cell = (XiMeiNewOrdersErCell1 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[XiMeiNewOrdersErCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        cell.zuoLabel.text = self.huoQuServiceData.title;
        cell.youLabel.text = [NSString stringWithFormat:@"¥%@元",self.huoQuServiceData.price];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        Service_commods *model =  self.service_commodArray[indexPath.section-2];
        if (indexPath.row == 0) {
            static NSString *myIdentifier = @"Cell3";
            XiMeiNewOrdersErCell2 *cell = (XiMeiNewOrdersErCell2 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
            if (cell == nil)
                cell = [[XiMeiNewOrdersErCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
            
            cell.zuoShangLabel.text = model.name;
            cell.zuoXiaLabel.text = @"编码";
            cell.youLabel.text = [NSString stringWithFormat:@"属性：%@",model.sku_properties];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row == 1)
        {
            static NSString *myIdentifier = @"Cell4";
            XiMeiNewOrdersErCell3 *cell = (XiMeiNewOrdersErCell3 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
            if (cell == nil)
                cell = [[XiMeiNewOrdersErCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
            cell.zuoLabel.text = @"单价：";
            CGFloat qianstr = [model.price floatValue];
            cell.mainTextField.text = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",qianstr]];
            cell.youLabel.text = @"元";
            
            cell.model = model;
            cell.superViewColler = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *myIdentifier = @"Cell5";
            XiMeiNewOrdersErCell4 *cell = (XiMeiNewOrdersErCell4 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
            if (cell == nil)
                cell = [[XiMeiNewOrdersErCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
            cell.zuoLabel.text = @"数量";
            cell.titleLabel.text = model.count;
            cell.model = model;
            kWeakSelf(weakSelf)
            if (model.shiFouKeShan == YES) {
                cell.shuLiangXiuGai = ^(Service_commods *modelZhu){
                    NewJianPanShuView* multipleView = [[NewJianPanShuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) value:modelZhu.count];
                    multipleView.xiaoShuWeiShu = 2;
                    multipleView.zuiDaZhiFloat = [modelZhu.current_count floatValue];
                    multipleView.okClick = ^(NSString* value){
                        modelZhu.count = value;
                        [weakSelf jiSuanZongEQian];
                        [weakSelf.main_tabelView reloadData];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:multipleView];
                    [multipleView displayView];
                };
                
                cell.jiaHuoJianDianJiBlock = ^{
                    [weakSelf jiSuanZongEQian];
                    [weakSelf.main_tabelView reloadData];
                };
            }else{
                cell.shuLiangXiuGai = ^(Service_commods *modelZhu){
                    [weakSelf showMessageWindowWithTitle:@"只能修改新增耗材" point:self.view.center delay:1];
                    [weakSelf.main_tabelView reloadData];
                };
                
                cell.jiaHuoJianDianJiBlock = ^{
                    [weakSelf showMessageWindowWithTitle:@"只能修改新增耗材" point:self.view.center delay:1];
                    [weakSelf.main_tabelView reloadData];
                };
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>1) {
        Service_commods *model =  self.service_commodArray[indexPath.section-2];
        if (model.shiFouKeShan == YES) {
            [self.service_commodArray removeObject:model];
            [self.main_tabelView reloadData];
            [self jiSuanZongEQian];
        }else
        {
            [self showMessageWindowWithTitle:@"只能删除新增耗材" point:self.view.center delay:1];
        }
    }
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
    if (indexPath.section>1) {
        if (indexPath.row==0) {
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleNone;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>1) {
        if (indexPath.row == 0) {
            return 65;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headeView = [[UIView alloc]init];
    headeView.backgroundColor = [UIColor clearColor];
    
    UILabel *zuoLabel  = [[UILabel alloc]init];
    zuoLabel.textColor = [UIColor grayColor];
    zuoLabel.font  = [UIFont systemFontOfSize:13];
    if (section == 1) {
        [headeView addSubview:zuoLabel];
        zuoLabel.text = @"服务信息";
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    
    if (section == 2) {
        [headeView addSubview:zuoLabel];
        zuoLabel.text = @"耗材信息";
        [zuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        UILabel *rightLabel = [[UILabel alloc]init];
        rightLabel.textColor = kZhuTiColor;
        rightLabel.font  = [UIFont systemFontOfSize:13];
        [headeView addSubview:rightLabel];
        rightLabel.text = @"新增耗材";
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
        
        UIImageView *tianJianTu = [[UIImageView alloc]initWithImage:DJImageNamed(@"add2")];
        [headeView addSubview:tianJianTu];
        [tianJianTu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightLabel.mas_left).mas_equalTo(-5);
            make.width.height.mas_equalTo(18);
            make.centerY.mas_equalTo(headeView);
        }];
        
        UIButton *xinZengHaoCaiBt = [[UIButton alloc]init];
        [xinZengHaoCaiBt addTarget:self action:@selector(xinZengHaoCaiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headeView addSubview:xinZengHaoCaiBt];
        [xinZengHaoCaiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
    }
    
    return headeView;
}

-(void)xinZengHaoCaiBtChick:(UIButton *)sender
{
    NewMaterialViewController *vc = [[NewMaterialViewController alloc]init];
    vc.zuiZongModel = self.zuiZongModel;
    kWeakSelf(weakSelf)
    vc.xuanZhongArrayBlock = ^(NSArray *array) {
        for (int i = 0; i<array.count; i++) {
            [weakSelf.service_commodArray addObject:array[i]];
            [weakSelf jiSuanZongEQian];
            [weakSelf.main_tabelView reloadData];
        }
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        if (section == 2) {
            return 35;
        }
        return 25;
    }else if(section == 0)
    {
        return 0;
    }else
    {
        return 8;
    }
}





@end
