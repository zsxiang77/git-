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
        self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kWindowW,self.frame.size.height)style:UITableViewStyleGrouped];
        self.mainTable.backgroundColor = [UIColor yellowColor];
        self.mainTable.delegate = self;
        self.mainTable.tableHeaderView = self.headerView;
        self.mainTable.dataSource = self;
        [self addSubview:self.mainTable];
        self.shiFouRenYuan = NO;

    }
    return self;
}

-(StoreHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[StoreHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 804/2)];
        kWeakSelf(weakSelf)
        _headerView.renYuanShiXiangQieBlock = ^(NSInteger index) {
            if (index == 0) {
                weakSelf.shiFouRenYuan = NO;
            }else{
               
                weakSelf.shiFouRenYuan = YES;
            }
            
            [weakSelf.mainTable reloadData];
        };
    }
    return _headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shiFouRenYuan == NO) {
        static NSString *Identifier = @"Identifier";
        StoreRenWuCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[StoreRenWuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Task_listModel * model;
        if (indexPath.row>0) {
            model = self.zhauModel.task_list[indexPath.row-1];
        }
        [cell refleshData:model dieIndex: indexPath];
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
        Staff_listModel * model;
        if (indexPath.row>0) {
            model = self.zhauModel.staff_list[indexPath.row-1];
        }
        
        [cell refleshData:model dieIndex: indexPath];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.shiFouRenYuan == NO){
        if (self.zhauModel.task_list.count>0) {
            return self.zhauModel.task_list.count+1;
        }else{
            return 0;
        }
        
    }else{
        if (self.zhauModel.staff_list.count>0) {
            return self.zhauModel.staff_list.count+1;
        }else{
            return 0;
        }
        
    }
   
}
@end

