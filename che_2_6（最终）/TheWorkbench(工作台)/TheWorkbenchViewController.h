//
//  TheWorkbenchViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/8/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "MJChiBaoZiHeader.h"
#import "TheWorkModel.h"
#import "UIImageView+WebCache.h"
#import "NetWorkManagerGet.h"
#import "TheWorkbenchWeiXiuCell.h"
#import "MJRefresh.h"
#import "OrderDetailViewController.h"
#import "UIImage+ImageWithColor.h"
#import "DuplexTableView.h"
#import "SegmentButtonsView.h"
#import "OrderDetailShaiXuanView.h"

@interface TheWorkbenchViewController : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    
    UITableView*        m_myTableView[11];
    UIButton *          m_mySegBtn[11];
    NSMutableArray *main_dataArry[11];
    NSInteger      page[11];
    
    NSInteger      diJiYeIndex;
    
    
    
    UIView               *m_searchView;//搜索窗口
    UIView               *m_searchShadowView;//搜索的阴影背景
    UITextField          *m_searchTextField;
    
    
    UIButton             *myListButton;
    UIButton             *allListButton;
    
    
    DuplexTableView*    m_moreTable;
    SegmentButtonsView* m_segButtonsView;
    
    
    BOOL                weixiuMyList;
    BOOL                xiMeiMyList;
    
    UIImageView        *shaiXuanImageView;
    UILabel            *shaiXuanTitle;
    UIImageView        *shaiXuanJianTou;
}

@property(nonatomic,strong)NSArray  *channelsArray;

@property(nonatomic, retain)UIButton             *myListSearchButton;
@property(nonatomic, retain)UIButton             *allListSearchButton;

@property(nonatomic, retain)UIView* searchGrayBg;
@property(nonatomic, retain)UIImageView* searchImageView;
@property(nonatomic, retain)UITextField* searchText;//搜索内容
@property(nonatomic,strong)UIButton *searchOKbt;
@property(nonatomic,strong)UIButton *searchClearBt;
@property(nonatomic,strong)NSMutableArray *seachArray;
@property(nonatomic,strong)UITableView *seachTableView;
@property(nonatomic,assign)NSInteger   searchIndex;

@property(nonatomic,strong)OrderDetailShaiXuanView *orderDetailShaiXuanView;//筛选View

-(void)resetTableScroll;

/**
 表头顺序
 */
@property(nonatomic,strong)NSDictionary *numberDict;
#pragma mark 分栏
- (void)buildMainViewWitharray:(NSArray *)array;


@end


@interface TheWorkbenchViewController (Net)

-(void)rREQUEST_METHODNetwork;
-(void)postrequest_methodDataWithIndex:(NSInteger )index withShuaXin:(BOOL)shuaX;
-(void)postSearchrequest_methodDatawithShuaXin:(BOOL)shuaX;
@end


@interface TheWorkbenchViewController (Search)

- (void)buildSearchView;

@end

