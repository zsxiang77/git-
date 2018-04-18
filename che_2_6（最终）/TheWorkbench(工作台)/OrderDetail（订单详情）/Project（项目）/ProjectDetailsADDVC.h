//
//  ProjectDetailsADDVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"
#import "ProjecAddProjectSanModel.h"

@interface ProjectDetailsADDVC : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *changArray;
    NSArray *fenLeiArray;
}

@property(nonatomic,strong)BaseViewController *suerViewController;
@property(nonatomic,strong)NSString *tiaoZhuanordercode;

@property(nonatomic, retain)UIView* searchGrayBg;
@property(nonatomic, retain)UITextField* searchText;//搜索内容
@property(nonatomic,strong)UIButton *searchClearBt;
@property(nonatomic,strong)UITableView *seachTableView;
@property(nonatomic,assign)NSInteger   searchIndex;
@property(nonatomic,strong)NSMutableArray *searchArray;

@property(nonatomic,strong)NSString    *dianJiClass;




@end
@interface ProjectDetailsADDVC (search)
- (void)buildSearchView;
-(void)searchPeijian:(NSString *)strText;
@end
