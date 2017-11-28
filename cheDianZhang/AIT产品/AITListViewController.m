//
//  AITListViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITListViewController.h"
#import "MJChiBaoZiHeader.h"
#import "SettingAITSerialNumberVC.h"

@interface AITListViewController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
{
    NSInteger  page;
    NSMutableArray   *mainArray;
}
@property(nonatomic,strong)NSDictionary *shanDict;

@end

@implementation AITListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"AIT产品序列号列表" withBackButton:YES];
    mainArray = [[NSMutableArray alloc]init];
    
    
    UIButton *tianJiabt = [[UIButton alloc]init];
    [tianJiabt addTarget:self action:@selector(tianJiabtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    tianJiabt.backgroundColor = UIColorFromRGBA(0xfe8000, 1);
    [tianJiabt.layer setMasksToBounds:YES];
    [tianJiabt.layer setCornerRadius:3];
    tianJiabt.titleLabel.font = [UIFont systemFontOfSize:14];
    [tianJiabt setTitle:@"+ 添加设备" forState:(UIControlStateNormal)];
    [tianJiabt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:tianJiabt];
    [tianJiabt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(130);
    }];
}

-(void)tianJiabtChick:(UIButton *)sender
{
    SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
    [self.navigationController   pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.main_tabelView.mj_header beginRefreshing];
}

-(UITableView *)main_tabelView
{
    if (!_main_tabelView) {
        _main_tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-50) style:UITableViewStylePlain];
        _main_tabelView.backgroundColor = [UIColor clearColor];
        _main_tabelView.allowsMultipleSelectionDuringEditing = YES;
        _main_tabelView.delegate = self;
        _main_tabelView.dataSource = self;
        _main_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _main_tabelView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        [self.view addSubview:_main_tabelView];
        
    }
    return _main_tabelView;
}
-(void)loadNewData0
{
    [self.main_tabelView.mj_header endRefreshing];
    [self setNetworkListstore_aitsWithshuaxin:YES];
}

-(void)setNetworkListstore_aitsWithshuaxin:(BOOL)shuaxin{
    
    if (shuaxin == YES) {
        page = 1;
    }
    
    [[self.main_tabelView viewWithTag:2000] removeFromSuperview];
    [self.main_tabelView.mj_footer endRefreshing];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [mDict setObject:@"20" forKey:@"pagesize"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"store/ait/ait_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        if (shuaxin == YES) {
            [mainArray removeAllObjects];
        }
        
        NSArray *array = KISDictionaryHaveKey(dataDic, @"list");
        if (array.count<20) {
            weakSelf.main_tabelView.mj_footer = nil;
        }else
        {
            weakSelf.main_tabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                page ++;
                [weakSelf setNetworkListstore_aitsWithshuaxin:NO];
            }];
        }
        
        for (int i = 0; i<array.count; i++) {
            [mainArray addObject:array[i]];
        }
        
        if(mainArray.count<=0)
        {
            UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kWindowW, 50)];
            cLabel.text = @"暂无数据";
            cLabel.tag = 2000;
            cLabel.textAlignment = NSTextAlignmentCenter;
            cLabel.textColor = kColorWithRGB(116.0, 116.0, 116.0, 1.0);
            cLabel.font = [UIFont boldSystemFontOfSize:20];
            cLabel.backgroundColor = [UIColor clearColor];
            [weakSelf.main_tabelView addSubview:cLabel];
            
        }
        
        weakSelf.shuXianNumber(mainArray.count);
        
        [weakSelf.main_tabelView reloadData];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    AITListCell *cell = (AITListCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AITListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    cell.delegate = self;
    cell.chuZhiDict = mainArray[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.serialLabel.text = KISDictionaryHaveKey(mainArray[indexPath.row], @"serial_number");
    cell.verifyLabel.text = KISDictionaryHaveKey(mainArray[indexPath.row], @"verify_code");
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127/2+10;
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];


    
    UIButton *deleteBtn = [[UIButton alloc]init];
    deleteBtn.backgroundColor = [UIColor redColor];
    [deleteBtn.layer setMasksToBounds:YES];
    [deleteBtn.layer setCornerRadius:42/2];
    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [deleteBtn setImage:DJImageNamed(@"16_trash") forState:(UIControlStateNormal)];
    [rightUtilityButtons addObject:deleteBtn];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate




- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [cell hideUtilityButtonsAnimated:YES];
            AITListCell *Cell = (AITListCell *)cell;
            NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
            [mDict setObject:KISDictionaryHaveKey(Cell.chuZhiDict, @"id") forKey:@"id"];
            self.shanDict = mDict;
            UIAlertView *alaView  = [[UIAlertView alloc]initWithTitle:nil message:@"是否删除AIT" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
            alaView.tag = 500;
            [alaView show];
            break;
        }
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 500) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            kWeakSelf(weakSelf)
            [NetWorkManager requestWithParameters:self.shanDict withUrl:@"store/ait/delete_ait" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
                
                if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
                    [weakSelf showMessageWindowWithTitle:@"删除成功" point:weakSelf.view.center delay:1];
                    [weakSelf.main_tabelView.mj_header beginRefreshing];
                }else{
                    [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                }
                
            } failure:^(id error) {
                
            }];
        }
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}



@end
