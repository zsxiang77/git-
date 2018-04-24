//
//  StoreRenWuView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenWuView.h"
#import "StoreRenWuCell.h"

#import "StoreRenWuRenYuanCell.h"
@implementation StoreRenWuView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.headerView = [[StoreHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 804/2)];
        
        
        self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kWindowW,self.frame.size.height)style:UITableViewStyleGrouped];
        self.mainTable.delegate = self;
        self.mainTable.tableHeaderView = self.headerView;
        self.mainTable.dataSource = self;
        [self addSubview:self.mainTable];
        
        self.renyuanmainTable = [[UITableView alloc]initWithFrame:CGRectMake(0,  0, kWindowW,self.frame.size.height)style:UITableViewStyleGrouped];
        self.renyuanmainTable.delegate = self;
        self.renyuanmainTable.dataSource = self;
        self.renyuanmainTable.hidden = NO;
        self.renyuanmainTable.tableHeaderView = self.headerView;
        [self addSubview:self.renyuanmainTable];
        
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.mainTable){
        static NSString *Identifier = @"Identifier";
        StoreRenWuCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[StoreRenWuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Task_listModel * model =self.zhauModel.task_list[indexPath.row];
        [cell refleshData:model dieIndex: indexPath];
        [self.mainTable reloadData];
        return cell;
    }else{
        static NSString *Identirenyuan = @"Identirenyuan";
        StoreRenWuRenYuanCell *cell = [tableView dequeueReusableCellWithIdentifier:Identirenyuan];
        if (cell == nil) {
            cell = [[StoreRenWuRenYuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identirenyuan];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Staff_listModel * model =self.zhauModel.staff_list[indexPath.row];
        [cell refleshData:model dieIndex: indexPath];
         [self.renyuanmainTable reloadData];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.mainTable){
        return 45;
    }else{
        return 45;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.mainTable){
        return self.zhauModel.task_list.count;
    }else{
       return self.zhauModel.staff_list.count;
    }
   
}
@end

