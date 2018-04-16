//
//  BossJianCeZiCeViewController.h
//  cheDianZhang
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "BossJianceModel.h"
#import "BossJianCeXiangQingModel.h"
@interface BossJianCeZiCeViewController : BOSSBaseViewController
{
    UIView * bottomView;
    UILabel * textlable ;
}

@property(nonatomic,strong)NSMutableArray *tableViewArray;
@property (nonatomic,strong)UIScrollView * viewScroLLview;
@property(nonatomic,strong)NSString  *exam_id;
@property(nonatomic,assign)NSInteger diJiTi;
@property(nonatomic,strong)BossJianceModel *chuanZhiModel;
@property(nonatomic,strong)NSMutableArray *chuanZhiArray;
@property(nonatomic,strong) NSMutableAttributedString *AttributedStr;
@property(nonatomic,strong)UILabel * daAnLable;
@end
