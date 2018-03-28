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

@interface AITListViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    tianJiabt.backgroundColor = kZhuTiColor;
    [tianJiabt.layer setMasksToBounds:YES];
    [tianJiabt.layer setCornerRadius:3];
    [tianJiabt setTitle:@"新增" forState:(UIControlStateNormal)];
    [tianJiabt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:tianJiabt];
    [tianJiabt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(94/2);
        make.width.mas_equalTo(kWindowW-30);
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mainArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    AITListCell *cell = (AITListCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[AITListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.chuZhiDict = mainArray[indexPath.section];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",indexPath.section+1];
    cell.serialLabel.text = KISDictionaryHaveKey(mainArray[indexPath.section], @"serial_number");
    cell.verifyLabel.text = KISDictionaryHaveKey(mainArray[indexPath.section], @"verify_code");
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127/2;
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


/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.shanDict = mainArray[indexPath.section];
    UIAlertView *alaView  = [[UIAlertView alloc]initWithTitle:nil message:@"是否删除AIT" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alaView.tag = 500;
    [alaView show];
}
/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - SWTableViewDelegate




- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 500) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            kWeakSelf(weakSelf)
            [NetWorkManager requestWithParameters:self.shanDict withUrl:@"store/ait/delete_ait" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
                
                if ([KISDictionaryHaveKey(responseObject, @"code") integerValue] == 200) {
                    [weakSelf showMessageWindowWithTitle:@"删除成功" point:weakSelf.view.center delay:1];
                    
                    [mainArray removeObject:self.shanDict];
                    [weakSelf.main_tabelView reloadData];
                    
//                    [weakSelf.main_tabelView.mj_header beginRefreshing];
                }else{
                    [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
                }
                
            } failure:^(id error) {
                
            }];
        }
    }
}




@end
