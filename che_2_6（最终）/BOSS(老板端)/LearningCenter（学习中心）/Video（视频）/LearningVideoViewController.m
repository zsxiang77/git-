//
//  LearningVideoViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningVideoViewController.h"
#import "UIImage+ImageWithColor.h"
#import "LearningCenterCellTableViewCell.h"


#define SHIPINGGAO (kWindowW*472/750)//视频高度

@interface LearningVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *btView;
}

@property(nonatomic,assign)BOOL  shiFouShiP;//是否视频选项

@property(nonatomic,strong)UIView  *daoHangLanView;//导航栏View
@property(nonatomic,strong)UILabel *titleLabe;


@end

@implementation LearningVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_mainTopTitle = @"视频详情";
    
    self.daoHangLanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 55)];
    self.daoHangLanView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.daoHangLanView];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_back_btn")];
    backImageView.frame = CGRectMake(10, (kBOSSNavBarHeight - 27)/2+10,13,21);
    [self.daoHangLanView addSubview:backImageView];
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.daoHangLanView addSubview:backButton];
    
    self.titleLabe = [[UILabel alloc]init];
    
    
    self.shiFouShiP = YES;
    
    self.mainJiShuArray = [[NSMutableArray alloc]init];
    self.mainListArray = [[NSMutableArray alloc]init];
    
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, SHIPINGGAO+38)];
    [self.view addSubview:shangView];
    _playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.CLwidth, SHIPINGGAO)];
    [shangView addSubview:_playerView];
    //重复播放，默认不播放
    _playerView.repeatPlay = YES;
    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    _playerView.isLandscape = YES;
    //全屏是否隐藏状态栏，默认一直不隐藏
    _playerView.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
    //顶部工具条隐藏样式，默认不隐藏
    _playerView.topToolBarHiddenType = TopToolBarHiddenSmall;
////    //播放
//    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    kWeakSelf(weakSelf)
    [_playerView backButton:^(UIButton *button) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
    [self qingQiuLuoBoData];
    btView = [[UIView alloc]initWithFrame:CGRectMake(0, SHIPINGGAO, kWindowW, 38)];
    btView.backgroundColor = kRGBColor(59, 59, 59);
    [shangView addSubview:btView];
    for (int i = 0; i<3; i++) {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW/3*i, 0, kWindowW/3, 38)];
        bt.titleLabel.font = [UIFont systemFontOfSize:13];
        
        bt.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [bt setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
        [bt setBackgroundImage:[UIImage imageWithColor:kColorWithRGB(255, 255, 255, 0.5)] forState:(UIControlStateSelected)];
        [bt addTarget:self action:@selector(qieHuanDianJChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [bt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        bt.tag = 3000+i;
        [btView addSubview:bt];
        if (i == 0) {
            [bt setTitle:@"看视频" forState:(UIControlStateNormal)];
            [bt setImage:DJImageNamed(@"boss_kanShiPin") forState:(UIControlStateNormal)];
            bt.imageEdgeInsets = UIEdgeInsetsMake(8, 5, 8, 5);
            bt.selected = YES;
        }else if(i == 1)
        {
            [bt setTitle:@"听音频" forState:(UIControlStateNormal)];
            [bt setImage:DJImageNamed(@"boss_yinPin") forState:(UIControlStateNormal)];
            bt.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
        }else{
            [bt setTitle:@"做测试" forState:(UIControlStateNormal)];
            [bt setImage:DJImageNamed(@"boss_zuoCeShi") forState:(UIControlStateNormal)];
            bt.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
        }
    }
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SHIPINGGAO+38, kWindowW, kWindowH- (SHIPINGGAO+38)) style:(UITableViewStyleGrouped)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    [self.view bringSubviewToFront:self.daoHangLanView];
}

-(void)qieHuanDianJChick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    
    self.shiFouShiP = NO;

    [UserInfo shareInstance].shiFouXuanZhuan = NO;
    _playerView.autoRotate = NO;
    _playerView.strokeColor = [UIColor clearColor];

    LearningVideoModel *model;
    for (int i = 0; i<self.mainJiShuArray.count; i++) {
        LearningVideoModel *model2 = self.mainJiShuArray[i];
        if (model2.shiFouXuanZhong == YES) {
            model = model2;
        }
    }
    if (sender.tag == 3000) {
        self.shiFouShiP = YES;
        for (int i = 0; i<3; i++) {
            UIButton *bt = [btView viewWithTag:3000+i];
            bt.selected = NO;
        }
        [UserInfo shareInstance].shiFouXuanZhuan = YES;
        _playerView.autoRotate = YES;

        
        for (int i = 0; i<3; i++) {
            UIButton *bt = [btView viewWithTag:3000+i];
            bt.selected = NO;
        }

        [UserInfo shareInstance].shiFouXuanZhuan = YES;
        _playerView.autoRotate = YES;

        sender.selected = !sender.selected;
        self.playerView.url = [NSURL URLWithString:model.video_url];
        self.playerView.kDWaterWaveView.hidden = YES;
        _playerView.strokeColor = [UIColor whiteColor];
        [self.playerView.kDWaterWaveView stopWave];
    }else if(sender.tag == 3001)
    {
        for (int i = 0; i<3; i++) {
            UIButton *bt = [btView viewWithTag:3000+i];
            bt.selected = NO;
        }
        sender.selected = !sender.selected;
        self.playerView.url = [NSURL URLWithString:model.auto_url];
        self.playerView.kDWaterWaveView.hidden = NO;
        [self.playerView.kDWaterWaveView startWave];
    }else{
        LearningZuoCeShiViewController *vc = [[LearningZuoCeShiViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.chuanZhiModel = model;
        vc.fatherViewController = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.shiFouShiP == YES) {
        [UserInfo shareInstance].shiFouXuanZhuan = YES;
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_playerView pausePlay];
    [UserInfo shareInstance].shiFouXuanZhuan = NO;
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
    self.video_id = model.video_id;
    [self qingQiuLuoBoData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 354/2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    LearningVideoModel *model;
    for (int i = 0; i<self.mainJiShuArray.count; i++) {
        LearningVideoModel *model2 = self.mainJiShuArray[i];
        if (model2.shiFouXuanZhong == YES) {
            model = model2;
        }
    }
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = model.title;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = kRGBColor(74, 74, 74);
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(5);
    }];
    
    UILabel *jieShaoL = [[UILabel alloc]init];
    jieShaoL.text = model.brief;
    jieShaoL.font = [UIFont systemFontOfSize:12];
    jieShaoL.textColor = kRGBColor(155, 155, 155);
    [headView addSubview:jieShaoL];
    [jieShaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(30);
    }];
    
    UILabel *line1 = [[UILabel alloc]init];
    line1.backgroundColor = kLineBgColor;
    [headView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(55);
    }];
    
    UILabel *jiShuL = [[UILabel alloc]init];
    jiShuL.font = [UIFont systemFontOfSize:16];
    jiShuL.textColor = kRGBColor(74, 74, 74);
    jiShuL.text = @"选集";
    [headView addSubview:jiShuL];
    [jiShuL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(66);
    }];
    
    zuoYouScrollView = [[UIScrollView alloc]init];
    [headView addSubview:zuoYouScrollView];
    [zuoYouScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(jiShuL.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    
    [self zuoYouScrollView:zuoYouScrollView];
    
    
    UILabel *zuoLine = [[UILabel alloc]init];
    zuoLine.backgroundColor = kZhuTiColor;
    [headView addSubview:zuoLine];
    [zuoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(3);
    }];
    
    UILabel *tuLa = [[UILabel alloc]init];
    tuLa.text = @"推荐内容";
    tuLa.font = [UIFont boldSystemFontOfSize:16];
    tuLa.textColor = kRGBColor(74, 74, 74);
    [headView addSubview:tuLa];
    [tuLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(zuoLine);
    }];
    
    UILabel *boLine = [[UILabel alloc]init];
    boLine.backgroundColor = kLineBgColor;
    [headView addSubview:boLine];
    [boLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    return headView;
}
-(void)dealloc
{
    [_playerView destroyPlayer];
}


-(void)zuoYouScrollView:(UIScrollView *)scrollView
{
    //删除的所有子视图
    while ([scrollView.subviews lastObject] != nil)
    {
        [[scrollView.subviews lastObject] removeFromSuperview];
    }
    if (self.mainJiShuArray.count>0) {
        scrollView.contentSize = CGSizeMake(74*self.mainJiShuArray.count, 60);
        
        
        
        for (int i = 0; i<self.mainJiShuArray.count; i++) {
            LearningVideoModel *model2 = self.mainJiShuArray[i];
            
            UIButton *zuoYuoBt = [[UIButton alloc]initWithFrame:CGRectMake(10+74*i, (60-38)/2, 64, 38)];
            if (i+1>9) {
                [zuoYuoBt setTitle:[NSString stringWithFormat:@"%d",i+1] forState:(UIControlStateNormal)];
            }else{
                [zuoYuoBt setTitle:[NSString stringWithFormat:@"0%d",i+1] forState:(UIControlStateNormal)];
            }
            
            zuoYuoBt.titleLabel.font = [UIFont systemFontOfSize:14];
            zuoYuoBt.tag = i;
            [zuoYuoBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
            [zuoYuoBt setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
            [zuoYuoBt addTarget:self action:@selector(zuoYuoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [zuoYuoBt.layer setMasksToBounds:YES];
            [zuoYuoBt.layer setCornerRadius:8];
            [zuoYuoBt setBackgroundImage:[UIImage imageWithColor:kZhuTiColor] forState:(UIControlStateSelected)];
            [zuoYuoBt setBackgroundImage:[UIImage imageWithColor:kRGBColor(240, 240, 240)] forState:(UIControlStateNormal)];
            if (model2.shiFouXuanZhong == YES) {
                zuoYuoBt.selected = YES;
            }else{
                zuoYuoBt.selected = NO;
            }
            [scrollView addSubview:zuoYuoBt];
            
        }
    }
}

-(void)zuoYuoBtChick:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i = 0; i<self.mainJiShuArray.count; i++) {
        LearningVideoModel *model = self.mainJiShuArray[i];
        model.shiFouXuanZhong = NO;
    }
    
    LearningVideoModel *model2 = self.mainJiShuArray[sender.tag];
    model2.shiFouXuanZhong = YES;
    if (self.shiFouShiP == YES) {
        self.playerView.url = [NSURL URLWithString:model2.video_url];
    }else{
        self.playerView.url = [NSURL URLWithString:model2.auto_url];
    }
    [self.mainTableView reloadData];
}
@end
