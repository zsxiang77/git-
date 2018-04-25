//
//  ProjectDetailsADDSanVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsADDSanVC.h"

@interface ProjectDetailsADDSanVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *main_tableView;

@end

@implementation ProjectDetailsADDSanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"添加维修项目" withBackButton:YES];
    
    UILabel *la = [[UILabel alloc]init];
    la.font = [UIFont systemFontOfSize:14];
    la.text = KISDictionaryHaveKey(self.chuZhiModel, @"name");
    la.textColor = [UIColor blackColor];
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(kNavBarHeight);
        make.height.mas_equalTo(35);
    }];
    
    UILabel *la2 = [[UILabel alloc]init];
    la2.font = [UIFont systemFontOfSize:13];
    la2.text = [NSString stringWithFormat:@"(共%@个小项目)",KISDictionaryHaveKey(self.chuZhiModel, @"next_num")];
    la2.textColor = [UIColor grayColor];
    [self.view addSubview:la2];
    [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(la.mas_right).mas_equalTo(10);
        make.top.mas_equalTo(kNavBarHeight);
        make.height.mas_equalTo(35);
    }];
    
    self.main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+35, kWindowW, kWindowH-kNavBarHeight-35) style:UITableViewStylePlain];
    [self.main_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.main_tableView.delegate = self;
    self.main_tableView.dataSource = self;
    [self.view addSubview:self.main_tableView];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chuZhiArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    NSDictionary *model = self.chuZhiArray[indexPath.row];

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = KISDictionaryHaveKey(model, @"name");
    return cell;
}


@end
