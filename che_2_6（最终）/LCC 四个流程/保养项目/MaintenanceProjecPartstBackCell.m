//
//  MaintenanceProjecPartstBackCell.m
//  测试
//
//  Created by lcc on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "MaintenanceProjecPartstBackCell.h"
#import "MaintenanceProjecPartstCell.h"
@interface MaintenanceProjecPartstBackCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *partArr;
@end


@implementation MaintenanceProjecPartstBackCell

-(void)setUpViews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView = ({
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView registerClass:[MaintenanceProjecPartstCell class] forCellReuseIdentifier:@"MaintenanceProjecPartstCell"];
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        //        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        [self.contentView addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.partArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintenanceProjecPartstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintenanceProjecPartstCell" forIndexPath:indexPath];
    @weakify(self)
    cell.changePartst = ^(MaintenanceProjectPartstModel *partsModel) {
        @strongify(self)
        !self.changePartst ? : self.changePartst(partsModel,self.partArr);
    };
    [cell bingViewModel:self.partArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 104;
}

- (void)bingViewModel:(id)viewModel{
    if (!(self.partArr == viewModel)) {
        self.partArr = viewModel;
        [self.tableView reloadData];
    }
}
@end
