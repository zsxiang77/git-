//
//  StoreRenYuanView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenYuanView.h"
#import "StoreRenYuanCell.h"
@implementation StoreRenYuanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self==[super initWithFrame:(CGRect)frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight,kWindowW, 81)];
        self.headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self.headerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-28);
            make.height.mas_equalTo(1);
        }];
        
        UIView * shangview = [[UIView alloc]initWithFrame:CGRectMake(0, 53, kWindowW, 28)];
        [self.headerView addSubview:shangview];
        
        UILabel * zuoLable =[[UILabel alloc]init];
        zuoLable.font = [UIFont boldSystemFontOfSize:16];
        [zuoLable setTextColor:kRGBColor(74, 74, 74)];
        zuoLable.text = @"排名";
        [shangview addSubview:zuoLable];
        [zuoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(56/2);
            make.centerY.mas_equalTo(shangview);
        }];
        
        UILabel * centerLable =[[UILabel alloc]init];
        centerLable.font = [UIFont boldSystemFontOfSize:16];
        [centerLable setTextColor:kRGBColor(74, 74, 74)];
        centerLable.text = @"姓名";
        [shangview addSubview:centerLable];
        [centerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(308*kWindowW/750);
            make.centerY.mas_equalTo(shangview);
        }];
        
        UILabel * youLable =[[UILabel alloc]init];
        youLable.font = [UIFont boldSystemFontOfSize:16];
        [youLable setTextColor:kRGBColor(74, 74, 74)];
        youLable.text = @"业绩";
        [shangview addSubview:youLable];
        [youLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-76/2);
            make.centerY.mas_equalTo(shangview);
        }];
        
        UILabel * linebom = [[UILabel alloc]init];
        linebom.backgroundColor = kLineBgColor;
        [shangview addSubview:linebom];
        [linebom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        
        UIButton * btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:@"shijianTuPian"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(riliClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(6);
            make.width.height.mas_equalTo(40);
        }];
        
        self.timeDateLable = [[UILabel alloc]init];
        self.timeDateLable.font = [UIFont systemFontOfSize:12];
        [self.timeDateLable setTextColor:[UIColor blackColor]];
        self.timeDateLable.text = @"2018年";
        [self.headerView addSubview:self.timeDateLable];
        [self.timeDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btn.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(btn);
        }];
        
        self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kWindowW,self.frame.size.height)style:UITableViewStyleGrouped];
        self.mainTable.delegate = self;
        self.mainTable.tableHeaderView = self.headerView;
        self.mainTable.dataSource = self;
        [self addSubview:self.mainTable];
    }
    return self;
}
#pragma _mark detedate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *Identifier = @"Identifier";
        StoreRenYuanCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[StoreRenYuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        listModel * model = self.zhuanzhiModel[indexPath.row];
        [cell refleshData:model dieIndex:indexPath];
        [self.mainTable reloadData];
        return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 152/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.zhuanzhiModel.count;
}


-(void)riliClick:(UIButton *)sender
{
    self.showRiLiBlock();
}

@end
