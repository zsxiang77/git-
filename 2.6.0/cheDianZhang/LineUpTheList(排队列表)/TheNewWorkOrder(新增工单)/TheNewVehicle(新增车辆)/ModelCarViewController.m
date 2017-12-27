//
//  ModelCarViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ModelCarViewController.h"

@interface ModelCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *biaoQianArray;


@end

@implementation ModelCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"车型" withBackButton:YES];
    self.biaoQianArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"G",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    self.zhuArray = [[NSMutableArray alloc]init];
    
    [self getReMenNetWork];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
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
    return self.zhuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.zhuArray[section];
    NSArray *ar = KISDictionaryHaveKey(dict, @"array");
    if ([KISDictionaryHaveKey(dict, @"name") isEqualToString:@"热门品牌"]) {
        return ar.count/5;
    }else
    {
        return ar.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *myIdentifier = @"ModelCarReMenCell";
        ModelCarReMenCell *cell = (ModelCarReMenCell*)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[ModelCarReMenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        
        NSDictionary *dict = self.zhuArray[indexPath.section];
        NSArray *ar1 = KISDictionaryHaveKey(dict, @"array");
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i = 0; i<ar1.count; i++) {
            if ((i/5) == indexPath.row) {
                [array addObject:ar1[i]];
            }
        }
        cell.tiaozhuanArray = array;
        [cell  refleshTableCellWith:array];
        kWeakSelf(weakSelf)
        cell.userDianJiTiaoZhuan = ^(NSDictionary *dict) {
            ErMenModel *model = (ErMenModel *)dict;
            ModelCarZiVC *vc = [[ModelCarZiVC alloc]init];
            vc.chuZhiModel = model;
            weakSelf.xinZengModel.brands = model.name;
            vc.xinZengModel = weakSelf.xinZengModel;
            vc.superViewController = weakSelf.superViewController;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *myIdentifier = @"ModelCarJiBenCell";
        ModelCarJiBenCell *cell = (ModelCarJiBenCell*)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil)
            cell = [[ModelCarJiBenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
        
        NSDictionary *dict = self.zhuArray[indexPath.section];
        NSArray *ar = KISDictionaryHaveKey(dict, @"array");
        ErMenModel *model = ar[indexPath.row];
        [cell.zuoZhuImageView  sd_setImageWithURL:[NSURL URLWithString:model.imges] placeholderImage:DJImageNamed(@"xiangMuBack")];
        cell.titleLabel.text = model.name;
        return cell;
    }
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (kWindowW-10)/5 +20;
    }else
    {
        return 40;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = kRGBColor(220, 220, 220);
    NSDictionary *dict = self.zhuArray[section];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.text = KISDictionaryHaveKey(dict, @"name");
    [header addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.mas_equalTo(0);
    }];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //更改索引的背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];

    return self.biaoQianArray;
}
//section （标签）标题显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    return [self.biaoQianArray objectAtIndex:section];
}
//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.zhuArray[indexPath.section];
    NSArray *ar = KISDictionaryHaveKey(dict, @"array");
    ErMenModel *model = ar[indexPath.row];
    ModelCarZiVC *vc = [[ModelCarZiVC alloc]init];
    vc.chuZhiModel = model;
    self.xinZengModel.brands = model.name;
    vc.xinZengModel = self.xinZengModel;
    vc.superViewController = self.superViewController;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
