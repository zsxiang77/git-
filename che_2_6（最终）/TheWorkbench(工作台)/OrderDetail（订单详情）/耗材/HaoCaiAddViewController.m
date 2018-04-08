//
//  HaoCaiAddViewController.m
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "HaoCaiAddViewController.h"
#import "DuplexTableView.h"
#import "SegmentButtonsView.h"
#import "NewMaterialCell.h"
#import "UIImageView+WebCache.h"
@interface HaoCaiAddViewController ()
<UITableViewDelegate,UITableViewDataSource,DuplexTableDelegate>
{
    DuplexTableView*    m_moreTable;
    SegmentButtonsView* m_segButtonsView;
}
@end

@implementation HaoCaiAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"新增耗材" withBackButton:YES];
    self.xuanZhongArray = [[NSMutableArray alloc]init];
    [self buildMainView];
    
    UIButton *queDingBt = [[UIButton alloc]init];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"添加耗材" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.view addSubview:queDingBt];
    [queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(45);
    }];
}

-(void)queDingBtChick:(UIButton *)sender
{
   [self.xuanZhongArray removeAllObjects];
    for (int i = 0; i<4; i++) {
        for (int h = 0;h<main_dataArry[i].count; h++) {
            Service_commods *mode = main_dataArry[i][h];
            if (mode.xuanZhong == YES) {
                mode.shiFouKeShan = NO;
                [self.xuanZhongArray addObject:mode];
            }
        }
    }
    
    self.xuanZhongArrayBlock(self.xuanZhongArray);
    
    [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark 分栏
- (void)buildMainView
{
    
    NSArray *nameArray = @[@"维修保养",@"车载电器",@"美容清洗",@"汽车装饰"];
    //----------按钮-------------//
    NSMutableArray* btns = [[NSMutableArray alloc] init];
    CGFloat jisuanKuai = kWindowW/4;
    for (int i = 0; i < 4; i++) {
        main_dataArry[i] = [[NSMutableArray alloc]init];
        yeMa[i] = 1;
        
        m_mySegBtn[i] = [[UIButton alloc] initWithFrame:CGRectMake(jisuanKuai*i, 0, jisuanKuai, 43)];
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor grayColor];
        [m_mySegBtn[i] addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        [m_mySegBtn[i] setTitle:[NSString stringWithFormat:@"%@",nameArray[i]] forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kColorWithRGB(102, 102, 102, 1.0) forState:UIControlStateNormal];
        [m_mySegBtn[i] setTitleColor:kZhuTiColor forState:UIControlStateSelected];
        m_mySegBtn[i].backgroundColor = [UIColor clearColor];
        m_mySegBtn[i].titleLabel.font = DJSystemFont(KAddFont_6P(16.0));
        m_mySegBtn[i].tag = i+1;
        if (i == 0) {
            m_mySegBtn[i].selected = YES;
        }
        [m_mySegBtn[i] addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:m_mySegBtn[i]];
    }
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 43-1.5, jisuanKuai, 1.5)];
    bottomView.backgroundColor = kZhuTiColor;
    m_segButtonsView = [[SegmentButtonsView alloc] initWithFrame:CGRectMake(0,kNavBarHeight, kWindowW, 43) buttonArray:btns bottomView:bottomView];
    [self.view addSubview:m_segButtonsView];
    
    //底部表格
    for (int i = 0; i < 4; i++) {
        main_tableView[i] = [[UITableView alloc]initWithFrame:CGRectMake(kWindowW*i, 0, kWindowW, kWindowH-kNavBarHeight-88) style:(UITableViewStylePlain)];
        
        main_tableView[i].delegate = self;
        main_tableView[i].tag = i + 2000;
        main_tableView[i].dataSource = self;
        main_tableView[i].backgroundColor = kColorWithRGB(246, 246, 246, 1.0);
        main_tableView[i].tableFooterView = [[UIView alloc] init];
        main_tableView[i].separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (i == 0) {
            main_tableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        }else if (i == 1) {
            main_tableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData1)];
        }else if (i == 2) {
            main_tableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData2)];
        }else if (i == 3) {
            main_tableView[i].mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData3)];
        }
    }
    
    
    m_moreTable = [[DuplexTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+43, kWindowW, kWindowH-kNavBarHeight-43-45)];
    m_moreTable.backgroundColor = [UIColor yellowColor];
    
    m_moreTable.myDelegate = self;
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i++) {
        [tableArray addObject:main_tableView[i]];
    }
    [m_moreTable buildMainViewWithTabel:tableArray head:nil visibleHeight:40 isHaveDownRefresh:NO];
    [self.view addSubview:m_moreTable];
    
    [main_tableView[0].mj_header beginRefreshing];
}
-(void)loadNewData0
{
    [self postcommods_listWithIndex:0 isShuXin:YES];
}
-(void)loadNewData1{
    [self postcommods_listWithIndex:1 isShuXin:YES];
}
-(void)loadNewData2{
    [self postcommods_listWithIndex:2 isShuXin:YES];
}
-(void)loadNewData3{
    [self postcommods_listWithIndex:3 isShuXin:YES];
}



#pragma mark 切换

- (void)segmentButtonClick:(UIButton*)segBtn
{
    for (int i = 0; i <4 ; i++) {
        if (segBtn != m_mySegBtn[i]) {
            m_mySegBtn[i].selected = NO;
        }
        else{
            m_mySegBtn[i].selected = YES;
        }
    }
    NSUInteger tag = segBtn.tag;//1,2
    [m_moreTable setFatherScrollToIndex:tag-1];
    
    [self tableChangedToIndex:tag-1];
}
- (void)tableChangedToIndex:(NSInteger)index
{
    [m_segButtonsView SGBscrollViewDidEndDecelerating:index];
    if (main_dataArry[index].count<=0) {
        [main_tableView[index].mj_header beginRefreshing];
    }
}
- (void)fatherScrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    NSInteger index = offsetofScrollView.x/CGRectGetWidth(scrollView.frame);
    for (int i = 0; i < 3; i++) {
        if (i != index) {
            m_mySegBtn[i].selected = NO;
        }
        else{
            m_mySegBtn[i].selected = YES;
        }
    }
    [m_segButtonsView SGBscrollViewDidScroll2:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //表格滑动
    [m_moreTable tableViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == main_tableView[0]) {
        return main_dataArry[0].count;
    }else if (tableView == main_tableView[1]) {
        return main_dataArry[1].count;
    }else if (tableView == main_tableView[2]) {
        return main_dataArry[2].count;
    }else if (tableView == main_tableView[3]) {
        return main_dataArry[3].count;
    }else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    NewMaterialCell *cell = (NewMaterialCell *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[NewMaterialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    
    Service_commods *mode;
    if (tableView == main_tableView[0]) {
        mode = main_dataArry[0][indexPath.row];
    }else  if (tableView == main_tableView[1]) {
        mode = main_dataArry[1][indexPath.row];
    }else if (tableView == main_tableView[2]) {
        mode = main_dataArry[2][indexPath.row];
    }else
    {
        mode = main_dataArry[3][indexPath.row];
    }
    cell.titleLabel.text = mode.name;
    if (mode.sku_properties.length>0) {
        cell.shuXinLabel.text = [NSString stringWithFormat:@"属性：%@",mode.sku_properties];
    }
    
    cell.kuCunLabel.text = [NSString stringWithFormat:@"库存：%@",mode.current_count];
    
    cell.danJiaLabel.text = [NSString stringWithFormat:@"¥%@",mode.price];
    
    if (mode.xuanZhong == YES) {
        cell.xuanZhonImageView.image = DJImageNamed(@"rect_check_box_selected");
    }else{
        cell.xuanZhonImageView.image = DJImageNamed(@"rect_check_box_unselect");
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Service_commods *mode;
    if (tableView == main_tableView[0]) {
        mode = main_dataArry[0][indexPath.row];
        
        CGFloat kuCurrent_count = [mode.current_count floatValue];
        if (kuCurrent_count>0) {
            mode.xuanZhong = !mode.xuanZhong;
        }else{
            [self showMessageWindowWithTitle:@"该库存为0" point:self.view.center delay:1];
        }
        [main_tableView[0] reloadData];
    }else  if (tableView == main_tableView[1]) {
        mode = main_dataArry[1][indexPath.row];
        CGFloat kuCurrent_count = [mode.current_count floatValue];
        if (kuCurrent_count>0) {
            mode.xuanZhong = !mode.xuanZhong;
        }else{
            [self showMessageWindowWithTitle:@"该库存为0" point:self.view.center delay:1];
        }
        [main_tableView[1] reloadData];
    }else if (tableView == main_tableView[2]) {
        mode = main_dataArry[2][indexPath.row];
        CGFloat kuCurrent_count = [mode.current_count floatValue];
        if (kuCurrent_count>0) {
            mode.xuanZhong = !mode.xuanZhong;
        }else{
            [self showMessageWindowWithTitle:@"该库存为0" point:self.view.center delay:1];
        }
        [main_tableView[2] reloadData];
    }else
    {
        mode = main_dataArry[3][indexPath.row];
        CGFloat kuCurrent_count = [mode.current_count floatValue];
        if (kuCurrent_count>0) {
            mode.xuanZhong = !mode.xuanZhong;
        }else{
            [self showMessageWindowWithTitle:@"该库存为0" point:self.view.center delay:1];
        }
        [main_tableView[3] reloadData];
    }
}
-(void)postcommods_listWithIndex:(NSInteger )index isShuXin:(BOOL)shuaXin{
    
    
    if (shuaXin == YES) {
        yeMa[index] = 1;
    }
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    //    100 维修配件
    //    182 车载电器
    //    195 美容清洗
    //    202 汽车装饰
    if (index == 0) {
        [mDict setObject:@"100" forKey:@"classid"];
    }else if (index == 1) {
        [mDict setObject:@"182" forKey:@"classid"];
    }else if (index == 2) {
        [mDict setObject:@"195" forKey:@"classid"];
    }else if (index == 3) {
        [mDict setObject:@"202" forKey:@"classid"];
    }
    
    [mDict setObject:[NSString stringWithFormat:@"%ld",(long)yeMa[index]] forKey:@"p"];
 
    for (int i=0; i<4; i++) {
        [main_tableView[i].mj_header endRefreshing];
        [main_tableView[i].mj_footer endRefreshing];
        
    }
    
    
    
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order/commods_list" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        if (shuaXin == YES) {
            [main_dataArry[index] removeAllObjects];
        }
        
        
        if (([KISDictionaryHaveKey(dataDic, @"p") integerValue] == [KISDictionaryHaveKey(dataDic, @"ptotal") integerValue])||([KISDictionaryHaveKey(dataDic, @"p") integerValue] > [KISDictionaryHaveKey(dataDic, @"ptotal") integerValue])) {
            main_tableView[index].mj_footer = nil;
        }else
        {
            yeMa[index] = [KISDictionaryHaveKey(dataDic, @"p") integerValue]+1;
            main_tableView[index].mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf postcommods_listWithIndex:index isShuXin:NO];
            }];
        }
        NSArray *commods = KISDictionaryHaveKey(dataDic, @"commods");
        if (commods.count>0) {
            for (int i = 0; i<commods.count; i++) {
                Service_commods *model = [Service_commods modelWithDictionary:commods[i]];
                model.shiFouKeShan  = YES;
                model.xuanZhong = NO;
                [main_dataArry[index] addObject:model];
            }
        }
        
        [main_tableView[index] reloadData];
        
    } failure:^(id error) {
        
    }];
}

@end
