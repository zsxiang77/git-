//
//  FoundDetailViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "FoundModel.h"
#import "FoundDetailModel.h"
#import "FoundDetailHeaderView.h"
#import "FoundDetailCell.h"

@interface FoundDetailViewController : BOSSBaseViewController
{
    NSTimer  *m_timer;
    NSInteger page;
    
    UIButton *shiJianBt;//时间筛选
    UIButton *reDuBt;//热度筛选
    BOOL     shaiXuanQieHuan;//Yes热度NO时间
}

@property(nonatomic,strong)FoundDetailModel *foundDetailModel;

@property(nonatomic,strong)NSMutableArray *mainListArrar;

@property(nonatomic,strong)FoundModel *chuanZhiModel;
@property(nonatomic,strong)FoundDetailHeaderView *headerView;

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)UIView *faBuView;//发布View
@property(nonatomic,strong)UITextField *faBuTextField;
@property(nonatomic,strong)FoundDetailListModel *huiFuModel;//回复model

@end


@interface FoundDetailViewController (Net)

-(void)postfind_article_detail;

-(void)postdo_article_praise;

-(void)postpingLunLIst:(BOOL)shuaX;
-(void)postdo_comment_praiseWithmodel:(FoundDetailListModel *)model;
//发布评论文章
-(void)postdo_article_comment;
@end
