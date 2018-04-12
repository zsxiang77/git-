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
#import "LearningVideoViewController.h"
#import "LearningCenterCellTableViewCell.h"
#import "UIViewController+MMDrawerController.h"
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
    [self postrequest_methodDatawithShuaXin:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"学习中心" withBackButton:NO];
    self.adDatas = [[NSMutableArray alloc]init];
    self.mainListArray = [[NSMutableArray alloc]init];
    [self qingQiuLuoBoData];
    [self postrequest_methodDatawithShuaXin:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
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
    vc.hidesBottomBarWhenPushed = YES;
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
    LearningCenterCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[LearningCenterCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    kWeakSelf(weakSelf)
    cell.changePartst = ^(LearningModel *model, NSIndexPath *index) {
        [weakSelf postdo_article_praise:model withIndex:index];
    };
    [cell refleshData:self.mainListArray[indexPath.row] withIndex:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(kWindowW>320){
        return 140;
    }else{
        return 140*0.8;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LearningModel *model = self.mainListArray[indexPath.row];
    LearningVideoViewController *vc = [[LearningVideoViewController alloc]init];
    vc.video_id = model.video_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

//    WKWebViewViewController *vc = [[WKWebViewViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.isNoShowNavBar = NO;
//    vc.webUrl = [NSString stringWithFormat:@"%@?video_id=%@&exam_id=1",model.url,model.video_id];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
