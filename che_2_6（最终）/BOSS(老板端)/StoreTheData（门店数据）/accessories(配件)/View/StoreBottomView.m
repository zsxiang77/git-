//
//  StoreBottomView.m
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreBottomView.h"
#import "StorePeiJianCell.h"

@implementation StoreBottomView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        
        //收起按钮
        UIButton * btn = [[UIButton alloc]init];
        [self addSubview:btn];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(shouqiAnniuClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(0);
            make.height.width.mas_equalTo(50);
        }];
        self.listModel = [[NSMutableArray alloc]init];
        self.mainTable= [[UITableView alloc]initWithFrame:CGRectMake(0, 52, kWindowW,self.frame.size.height-52)style:UITableViewStyleGrouped];
        self.mainTable.backgroundColor = [UIColor whiteColor];
        self.mainTable.delegate = self;
        self.mainTable.dataSource = self;
        self.mainTable.hidden = NO;
       // self.mainTable.tableHeaderView = self.headerView;
        [self addSubview: self.mainTable];
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"Identifier";
    StorePeiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[StorePeiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    listPeiJianModel * model = self.listModel[indexPath.row];
    [cell refleshData:model dieIndex:indexPath];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 74/2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listModel.count;;
    
    
}
-(void)shouqiAnniuClick:(UIButton*)sender
{
    
}
@end
