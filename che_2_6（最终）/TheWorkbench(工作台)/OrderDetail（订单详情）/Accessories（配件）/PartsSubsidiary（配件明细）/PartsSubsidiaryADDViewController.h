//
//  PartsSubsidiaryADDViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"


@interface PartsSubsidiaryADDViewController : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *changArray;
    NSMutableArray *fenLeiArray;
    
    
    UIView               *m_searchView;//搜索窗口
    UIView               *m_searchShadowView;//搜索的阴影背景
    UITextField          *m_searchTextField;
}

@property(nonatomic,strong)BaseViewController *suerViewController;

@property(nonatomic, retain)UIView* searchGrayBg;
@property(nonatomic, retain)UITextField* searchText;//搜索内容
@property(nonatomic,strong)UIButton *searchClearBt;
@property(nonatomic,strong)UITableView *seachTableView;
@property(nonatomic,assign)NSInteger   searchIndex;
@property(nonatomic,strong)NSMutableArray *searchArray;
@end
@interface PartsSubsidiaryADDViewController (search)
- (void)buildSearchView;
-(void)searchPeijian:(NSString *)strText;
@end
