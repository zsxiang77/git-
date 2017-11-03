//
//  XiMeiDetailViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "XiMeiDetailHeaderView.h"
#import "TheWorkModel.h"
#import "OrderDetailModel.h"
#import "UIImageView+WebCache.h"
#import "ErWeiMaView.h"


@interface XiMeiDetailViewController : BaseViewController

@property(nonatomic,assign)BOOL yingCangAnNiu;

@property(nonatomic,strong)NSMutableArray *wenTiArray;

@property(nonatomic,strong)ErWeiMaView *erWeiMaView;

@property(nonatomic,strong)XiMeiDetailHeaderView *xiMeiDetailHeaderView;
@property(nonatomic,strong)XiMeiDetailHeaderView *xiMeiDetailHeaderView2;

@property(nonatomic,strong)UIScrollView *zuoYouScrollView;

@property(nonatomic,strong)TheWorkModel *chuanzhiModel;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,assign)BOOL  kaiGuanButton;
@property(nonatomic,strong)OrderDetailModel *zhuModel;
@property(nonatomic,strong)NSString *anNiuStr;

-(void)zuoYouScrollViewBuju;

@end


@interface XiMeiDetailViewController (Net)
-(void)setrequest_methodwithOrdercodevarchar:(TheWorkModel *)model;

-(void)shuaXinHeaderView2;

-(void)postjieSuoWithModel:(TheWorkModel *)model;
-(void)postSuoDanWithModel:(TheWorkModel *)model;
-(void)postZuiHouTiJiao:(TheWorkModel *)model;
-(void)shangChuanVideos:(NSData *)adta withUrl:(NSURL *)url;
-(void)shangtuPian:(NSArray *)adtaArray withImage:(UIImage *)image;
- (CGFloat) getVideoLength:(NSURL *)URL;

-(void)shanChuShiGongTuPian:(TheWorkModel *)model withImage:(NSString *)str;
-(void)shangChuanShiGongTuPian:(TheWorkModel *)model withImage:(NSString *)str;

@end
