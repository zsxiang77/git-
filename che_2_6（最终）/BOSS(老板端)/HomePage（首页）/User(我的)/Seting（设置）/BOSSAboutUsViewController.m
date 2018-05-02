//
//  BOSSAboutUsViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSAboutUsViewController.h"
#import "BOSSAboutCell.h"


@interface BOSSAboutUsViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSDictionary *maidct;
@property(nonatomic,strong)UITableView *mainTableView;



@end

@implementation BOSSAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"关于我们" withBackButton:YES];

    [self postabout_us];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        
        UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 158)];
        UIImageView *logoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_logo")];
        [shangView addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(48);
            make.centerX.mas_equalTo(shangView);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(47);
        }];
        
        UILabel *banBenLabel = [[UILabel alloc]init];
        banBenLabel.textColor = kRGBColor(74, 74, 74);
        banBenLabel.font = [UIFont systemFontOfSize:17];
        banBenLabel.text = [NSString stringWithFormat:@"版本号：%@",kCurrentVersion];
        [shangView addSubview:banBenLabel];
        [banBenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(logoImageView.mas_bottom).mas_equalTo(12);
            make.centerX.mas_equalTo(shangView);
        }];
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [shangView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(1);
        }];
        
        _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH) style:UITableViewStylePlain];
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        _mainTableView.tableHeaderView=shangView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(void)postabout_us
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"2" forKey:@"status"];
    
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParametersGET:mDict withUrl:@"user/ucenter/about_us" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        weakSelf.maidct = KISDictionaryHaveKey(dataDic, @"info");
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource\

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myIdentifier = @"Cell";
    BOSSAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[BOSSAboutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    [cell chuLiData:self.maidct withIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"";
    if (indexPath.row == 0) {
        str = [NSString stringWithFormat:@"        %@",KISDictionaryHaveKey(self.maidct, @"introduce")];
    }else{
        str = [NSString stringWithFormat:@"        %@",KISDictionaryHaveKey(self.maidct, @"contact")];
    }
    CGSize wordSize2 = DAJIANG_MULTILINE_TEXTSIZE(str, DJSystemFont(14), CGSizeMake(kWindowW-20, 1000));
    return wordSize2.height+96;
}

@end
