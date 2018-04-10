//
//  LearningDaAnViewController.m
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningDaAnViewController.h"
#import "LearningCuoTiCell.h"
#import "LearningVideoViewController.h"
@interface LearningDaAnViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LearningDaAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"自测题" withBackButton:YES];
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStyleGrouped];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    UIView * viewHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 62)];
    self.mainTableView.tableHeaderView = viewHead;
    
    UILabel * lable1 =[[UILabel alloc]init];
    lable1.font = [UIFont boldSystemFontOfSize:17];
    lable1.textColor = kRGBColor(51, 51, 51);
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"您共完成%@道题,其中%@道题错误",self.chuanZhiDict.totalnum,self.chuanZhiDict.num]];
         [AttributedStr addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor redColor]
                                      range:NSMakeRange(9+self.chuanZhiDict.totalnum.length, self.chuanZhiDict.num.length)];
    lable1.attributedText = AttributedStr;
    [viewHead addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(viewHead);
        make.centerY.mas_equalTo(viewHead);
    }];
    
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma  mark - UITableViewDataSource
//tableview分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.chuanZhiDict.wrong.count;
}
//tableview设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LearningWrongListModel *wrongModel = self.chuanZhiDict.wrong[section];
    return wrongModel.option.count;
}
//tableview设置cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    LearningCuoTiCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[LearningCuoTiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LearningWrongListModel *wrongModel = self.chuanZhiDict.wrong[indexPath.section];
    [cell shuaXinData:wrongModel.option[indexPath.row] withZhengQueStr:wrongModel.answer withWrongStr:wrongModel.answer_u witINdex:indexPath.row];
    return cell;
}
//tableview设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
//tableview设置头部view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *hTitle = [[UILabel alloc]init];
    hTitle.numberOfLines = 2;
    hTitle.adjustsFontSizeToFitWidth = YES;
    hTitle.font = [UIFont boldSystemFontOfSize:17];
    hTitle.textColor = kRGBColor(74, 74, 74);
    [headView addSubview:hTitle];
    [hTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    
    LearningWrongListModel *wrongModel = self.chuanZhiDict.wrong[section];
    hTitle.text = [NSString stringWithFormat:@"%ld、%@",section+1,wrongModel.title];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    return headView;
}
//设置tableview头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
//设置tableview尾部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.chuanZhiDict.wrong.count-1) {
        return 100;
    }else{
        return 0;
    }
}
//设置tableview尾部view
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    if (section == self.chuanZhiDict.wrong.count-1) {
        UIButton *okBt = [[UIButton alloc]init];
        okBt.titleLabel.font = [UIFont systemFontOfSize:18];
        okBt.backgroundColor = kZhuTiColor;
        [okBt addTarget:self action:@selector(okBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [okBt setTitle:@"我知道了" forState:(UIControlStateNormal)];
        [okBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [okBt.layer setMasksToBounds:YES];
        [okBt.layer setCornerRadius:5];
        [footView addSubview:okBt];
        [okBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(94/2);
            make.top.mas_equalTo(22);
        }];
    }
    return footView;
}


-(void)okBtChick:(UIButton *)sender
{
    [self.navigationController popToViewController:self.fatherViewController animated:YES];
}
@end
