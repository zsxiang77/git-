//
//  LearningCenterViewController.m
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningCenterViewController.h"
#import "MJRefresh.h"
#import "SGFocusImageFrame.h"

@interface LearningCenterViewController ()<SGFocusImageFrameDelegate,UITableViewDelegate,UITableViewDataSource>


@end

@implementation LearningCenterViewController


-(UITableView *)main_tableView
{
    if (!_main_tableView) {
        _main_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight-1, kWindowW, kWindowH-[self getTabBarHeight]-kBOSSNavBarHeight) style:UITableViewStylePlain];
        _main_tableView.delegate = self;
        _main_tableView.dataSource = self;
        _main_tableView.backgroundColor = [UIColor whiteColor];
        _main_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _main_tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMatchInfoData)];
        [self.view addSubview:_main_tableView];
    }
    return _main_tableView;
}
-(void)requestMatchInfoData
{
    [_main_tableView.mj_header endRefreshing];
    [self qingQiuLuoBoData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"学习中心" withBackButton:NO];
    self.adDatas = [[NSMutableArray alloc]init];
    [self qingQiuLuoBoData];
}

#pragma mark 头部
- (void)buildAdView
{
    NSInteger adCount = [self.adDatas count];
    if (adCount == 0) {
        return;
    }
    NSMutableArray* imageURLArray = [NSMutableArray arrayWithCapacity:1];
     NSMutableArray* titleArray = [NSMutableArray arrayWithCapacity:1];
    
    if (adCount > 1) {
        NSDictionary* dic = [self.adDatas objectAtIndex:adCount - 1];
        NSString *icon_url = KISDictionaryHaveKey(dic, @"image_url");
        [imageURLArray addObject:icon_url];
        
        [titleArray addObject:KISDictionaryHaveKey(dic, @"title")];
        
    }
    for (int j = 0; j < adCount; j++) {
        NSDictionary* dic = [self.adDatas objectAtIndex:j];
        NSString *icon_url = KISDictionaryHaveKey(dic, @"image_url");
        [imageURLArray addObject:icon_url];
        [titleArray addObject:KISDictionaryHaveKey(dic, @"title")];
    }
    //添加第一张图 用于循环
    if (adCount > 1)
    {
        NSDictionary* dic = [self.adDatas objectAtIndex:0];
        NSString *icon_url = KISDictionaryHaveKey(dic, @"image_url");
        [imageURLArray addObject:icon_url];
        [titleArray addObject:KISDictionaryHaveKey(dic, @"title")];
    }
    SGFocusImageFrame* AdScrollView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*334/750) delegate:self imageItems:imageURLArray isAuto:YES placeHolderImage:DJImageNamed(@"ad_default") pageSize:6.0 withTiTle:titleArray];
    AdScrollView.backgroundColor = kRGBColor(206, 206, 206);
    self.main_tableView.tableHeaderView = AdScrollView;
}

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(NSInteger)item
{
    
    NSDictionary *dict = [self.adDatas objectAtIndex:MAX(item-1, 0)];
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
    vc.isNoShowNavBar = NO;
    vc.webUrl = [NSString stringWithFormat:@"%@?video_id=%@&exam_id=1",KISDictionaryHaveKey(dict, @"url"),KISDictionaryHaveKey(dict, @"video_id")];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LearningModel *model = self.mainListArray[indexPath.row];
    WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
    vc.isNoShowNavBar = NO;
    vc.webUrl = [NSString stringWithFormat:@"%@?video_id=%@&exam_id=1",model.url,model.video_id];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
