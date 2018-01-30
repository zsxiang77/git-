//
//  OrderDetailViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/4.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheWorkModel.h"
#import "OrderDetailModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "OrderDetailHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "CarInspectionModel.h"
#import "UIImage+Video.h"
#import "ProjectDetailsViewController.h"
#import "ConstructionPersonnelViewController.h"
#import "PartsSubsidiaryViewController.h"
#import "ErWeiMaView.h"
#import "SuccessfulOrderViewController.h"
#import "ZXingObjC.h"
#import "MJChiBaoZiHeader.h"


@interface OrderDetailViewController : BaseViewController
{
    NSMutableArray *_xiangMuMingXiArray;
    NSMutableArray *_peiJianMingXiArray;
    NSMutableArray *_xiangMuMingXiArrayCun;
    NSMutableArray *_peiJianMingXiArrayCun;
    
    //展合
    BOOL         _xiangMuMingXiibool;
    BOOL         _peiJianMingXibool;
}


@property(nonatomic,strong)NSMutableArray *bengDiArray;


@property(nonatomic,assign)BOOL shiFouKeXiugai;

//@property(nonatomic,strong)NSMutableArray *wenTiArray;

@property(nonatomic,strong)OrderDetailHeaderView *orderDetailHeaderView;


@property(nonatomic,strong)TheWorkModel *chuanzhiModel;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,assign)BOOL  kaiGuanButton;
@property(nonatomic,strong)OrderDetailModel *zhuModel;
@property(nonatomic,strong)UIScrollView *zuoYouScrollView;
@property(nonatomic,strong)ErWeiMaView *erWeiMaView;
@property(nonatomic,strong)NSString *repairmileStr;
@property(nonatomic,strong)NSString *tiaoZhuanordercode;

-(void)zuoYouScrollViewBuju;

@end


@interface OrderDetailViewController (Net)

/**
 配件明细

 @param model <#model description#>
 @param tiao <#tiao description#>
 @param viewColler <#viewColler description#>
 */
-(void)postpeiJianMingXiWithModel:(TheWorkModel *)model withTiaoZhua:(BOOL)tiao With:(BaseViewController *)viewColler;

/**
 项目明细

 @param model <#model description#>
 @param tiao <#tiao description#>
 @param viewColler <#viewColler description#>
 */
-(void)postrequest_methodMingXiWithModel:(TheWorkModel *)model withTiaoZhua:(BOOL)tiao With:(BaseViewController *)viewColler;
-(void)postRequest_methodWithModel:(TheWorkModel *)model;

-(void)setrequest_methodwithOrdercodevarchar:(TheWorkModel *)model;

-(void)postSuoDanWithModel:(TheWorkModel *)model;
-(void)postjieSuoWithModel:(TheWorkModel *)model;
-(void)shangChuanVideos:(NSData *)adta withUrl:(NSURL *)url;
-(void)shangtuPian:(NSArray *)adtaArray withImage:(UIImage *)image;
- (CGFloat) getVideoLength:(NSURL *)URL;
-(void)shanChuShiGongTuPian:(TheWorkModel *)model withImage:(NSString *)str;


@end
