//
//  LineUpTheListVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheWorkbenchCell.h"
#import "MJChiBaoZiHeader.h"
#import "TheWorkModel.h"
#import "UIImageView+WebCache.h"
#import "RTDragCellTableView.h"
#import "NetWorkManagerGet.h"
#import "PushMessageViewController.h"


@interface LineUpTheListVC : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    
    RTDragCellTableView*        m_myTableView[11];
    UIButton *          m_mySegBtn[11];
    NSMutableArray *main_dataArry[11];
    NSInteger      page[11];
    
    
    NSInteger      diJiYeIndex;
    
    UIView               *m_searchView;//搜索窗口
    UIView               *m_searchShadowView;//搜索的阴影背景
    UITextField          *m_searchTextField;
}

@property(nonatomic, retain)UIView* searchGrayBg;
@property(nonatomic, retain)UIImageView* searchImageView;
@property(nonatomic, retain)UITextField* searchText;//搜索内容
@property(nonatomic,strong)UIButton *searchOKbt;
@property(nonatomic,strong)UIButton *searchClearBt;
/**
 表头顺序
 */
@property(nonatomic,strong)NSDictionary *numberDict;
#pragma mark 分栏
- (void)buildMainViewWitharray:(NSArray *)array;

@property(nonatomic,strong)NSArray *yuanDataArray;

@property(nonatomic,strong)NSMutableArray *seachArray;
@property(nonatomic,strong)UITableView *seachTableView;
-(void)resetTableScroll;



@end


@interface LineUpTheListVC (NetWork)
-(void)setNetworkListWithshuaxin:(BOOL)shuaxin withIndex:(NSInteger)index;
-(void)setShanChuDanTiaoDatawithOrdercodevarchar:(TheWorkModel *)model withIndex:(NSInteger)index;
-(void)rEQUEST_METHODsetShanChuDanTiaoDatawithBordercode:(TheWorkModel *)bordercodeModel withAordercode:(TheWorkModel *)aordercodeModel withIndex:(NSInteger)inex;

-(void)rREQUEST_METHODNetwork;

-(void)postQingQiuSearch:(NSString *)str;
@end


@interface LineUpTheListVC (Search)
- (void) buildSearchView;
@end

