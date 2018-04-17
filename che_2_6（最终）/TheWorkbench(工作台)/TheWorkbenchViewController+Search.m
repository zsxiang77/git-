//
//  TheWorkbenchViewController+Search.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "TheWorkbenchViewController.h"
#import "PlateIDCameraViewController.h"
#import "TheWorkbenchSearchViewController.h"

@implementation TheWorkbenchViewController (Search)
- (void)buildSearchView
{
    UIView* searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, CGRectGetWidth(self.view.frame), (63/2+10)*2)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.hidden = NO;
    [self.view addSubview:searchBg];
    
    UIView *qieView = [[UIView alloc]initWithFrame:CGRectMake(0, (63/2+10), kWindowW, (63/2+10))];
    qieView.backgroundColor = [UIColor clearColor];
    [searchBg addSubview:qieView];
    
    UIView *shaiXuanView = [[UIView alloc]init];
    shaiXuanView.backgroundColor = kRGBColor(244, 244, 244);
    [shaiXuanView.layer setMasksToBounds:YES];
    [shaiXuanView.layer setBorderWidth:0.5];
    [shaiXuanView.layer setCornerRadius:54/4];
    [shaiXuanView.layer setBorderColor:kLineBgColor.CGColor];
    [qieView addSubview:shaiXuanView];
    [shaiXuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(qieView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(54/2);
    }];
    
    shaiXuanImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"waiting_repair")];
    [shaiXuanView addSubview:shaiXuanImageView];
    [shaiXuanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.width.mas_equalTo(15);
        make.centerY.mas_equalTo(shaiXuanView);
    }];
    
    shaiXuanTitle = [[UILabel alloc]init];
    shaiXuanTitle.font = [UIFont systemFontOfSize:12];
    shaiXuanTitle.textColor = kRGBColor(245, 166, 35);
    shaiXuanTitle.text = @"待施工";
    [shaiXuanView addSubview:shaiXuanTitle];
    [shaiXuanTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shaiXuanImageView.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(shaiXuanView);
    }];
    
    shaiXuanJianTou = [[UIImageView alloc]initWithImage:DJImageNamed(@"jiaoTou_DownUp")];
    [shaiXuanView addSubview:shaiXuanJianTou];
    [shaiXuanJianTou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(shaiXuanView);
    }];
    
    UIButton *shaiXuanBt = [[UIButton alloc]init];
    [shaiXuanBt addTarget:self action:@selector(shaiXuanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shaiXuanView addSubview:shaiXuanBt];
    [shaiXuanBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIView *qieView2 = [[UIView alloc]init];
    qieView2.backgroundColor = kRGBColor(244, 244, 244);
    [qieView2.layer setMasksToBounds:YES];
    [qieView2.layer setBorderWidth:0.5];
    [qieView2.layer setCornerRadius:54/4];
    [qieView2.layer setBorderColor:kLineBgColor.CGColor];
    [qieView addSubview:qieView2];
    [qieView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(qieView);
        make.width.mas_equalTo(227/2);
        make.height.mas_equalTo(54/2);
    }];
    
    myListButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 117/2, 54/2)];
    myListButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [myListButton.layer setMasksToBounds:YES];
    [myListButton.layer setCornerRadius:54/4];
    myListButton.selected = YES;
    [myListButton addTarget:self action:@selector(myListButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [myListButton setTitle:@"与我相关" forState:(UIControlStateNormal)];
    [myListButton setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [myListButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [myListButton setBackgroundImage:[UIImage imageWithUIColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    [myListButton setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
    [qieView2 addSubview:myListButton];
    
    
    allListButton = [[UIButton alloc]initWithFrame:CGRectMake(227/2-117/2, 0, 117/2, 54/2)];
    allListButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [allListButton.layer setMasksToBounds:YES];
    [allListButton.layer setCornerRadius:54/4];
    allListButton.selected = NO;
    [allListButton addTarget:self action:@selector(allListButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [allListButton setTitle:@"显示所有" forState:(UIControlStateNormal)];
    [allListButton setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [allListButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [allListButton setBackgroundImage:[UIImage imageWithUIColor:[UIColor clearColor]] forState:(UIControlStateNormal)];
    [allListButton setBackgroundImage:[UIImage imageWithUIColor:kZhuTiColor] forState:(UIControlStateSelected)];
    [qieView2 addSubview:allListButton];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, ((63/2+9)*2), kWindowW, 1)];
    line.backgroundColor = kLineBgColor;
    [searchBg addSubview:line];
    
    self.searchGrayBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kWindowW-20, 63/2)];
    self.searchGrayBg.backgroundColor = kRGBColor(244, 244, 244);
    self.searchGrayBg.layer.cornerRadius = 63/4;
    [self.searchGrayBg.layer setBorderWidth:0.5];
    [self.searchGrayBg.layer setBorderColor:kLineBgColor.CGColor];
    [searchBg addSubview:self.searchGrayBg];
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.searchGrayBg.frame)-25, 5, 20, 20)];
    self.searchImageView.image = DJImageNamed(@"search_gray");
    [self.searchGrayBg addSubview:self.searchImageView];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"search_blue")];
    [self.searchGrayBg addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.searchGrayBg);
        make.width.height.mas_equalTo(32.6/2);
    }];
    
    UILabel *biaoShiLabel = [[UILabel alloc]init];
    biaoShiLabel.textColor = kRGBColor(155, 155, 155);
    biaoShiLabel.text = @"请输入车牌号/手机号/VIN/订单号";
    biaoShiLabel.font = DJSystemFont(14);
    [self.searchGrayBg addSubview:biaoShiLabel];
    [biaoShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-38);
    }];
    
    self.searchButton = [[UIButton alloc] init];
    [self.searchGrayBg addSubview:self.searchButton];
    [self.searchButton addTarget:self action:@selector(searchButtonTiaoZhuanChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-38);
    }];
    
    UIImageView *saoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"扫描")];
    [self.searchGrayBg addSubview:saoImageView];
    [saoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.searchGrayBg);
        make.width.height.mas_equalTo(32.6/2);
    }];
    
    UIButton *saoButton = [[UIButton alloc]init];
    [saoButton addTarget:self action:@selector(saoButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.searchGrayBg addSubview:saoButton];
    [saoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
}

-(void)searchButtonTiaoZhuanChick:(UIButton *)sender
{
    if (self.numberDict) {
        TheWorkbenchSearchViewController *vc = [[TheWorkbenchSearchViewController alloc]init];
        vc.numberDict = self.numberDict;
        vc.channelsArray = self.channelsArray;
        vc.hidesBottomBarWhenPushed = YES;
        if (m_segButtonsView.selectIndex == 0) {
            vc.shiFouWeiXiu = YES;
        }else{
            vc.shiFouWeiXiu = NO;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)shaiXuanBtChick:(UIButton *)sender
{
    if (self.orderDetailShaiXuanView.hidden == NO) {
        [self.orderDetailShaiXuanView yingCangViwe];
        [UIView animateWithDuration:0.2 animations:^{
            shaiXuanJianTou.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
        }];
    }else{
        [self.orderDetailShaiXuanView displayView];
        [UIView animateWithDuration:0.2 animations:^{
            shaiXuanJianTou.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
        }];
    }
    [self.view bringSubviewToFront:self.orderDetailShaiXuanView];
}

-(void)myListButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        allListButton.selected = NO;
    }else{
        allListButton.selected = YES;
    }
    
    if (m_segButtonsView.selectIndex == 0) {
        weixiuMyList = YES;
    }
    if (m_segButtonsView.selectIndex == 1) {
        xiMeiMyList = YES;
    }
    
    [self postrequest_methodDataWithIndex:m_segButtonsView.selectIndex withShuaXin:YES];
}
-(void)allListButtonChick:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        myListButton.selected = NO;
    }else{
        myListButton.selected = YES;
    }
    
    if (m_segButtonsView.selectIndex == 0) {
        weixiuMyList = NO;
    }
    if (m_segButtonsView.selectIndex == 1) {
        xiMeiMyList = NO;
    }
    
    [self postrequest_methodDataWithIndex:m_segButtonsView.selectIndex withShuaXin:YES];
}

-(void)saoButtonChick:(UIButton *)sender
{
    
    
    PlateIDCameraViewController *vc = [[PlateIDCameraViewController alloc]init];
    vc.shiFouHuiDiao = YES;
    kWeakSelf(weakSelf)
    vc.saoMiaoJieGUo = ^(NSString *jieGuo) {
        
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
