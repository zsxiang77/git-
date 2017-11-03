//
//  TheWorkbenchViewController.h
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
#import "NetWorkManagerGet.h"
#import "TheWorkbenchNewCell.h"
#import "MJRefresh.h"
#import "OrderDetailViewController.h"
#import "XiMeiDetailViewController.h"

@interface TheWorkbenchViewController : BaseViewController
{
    
    UITableView*        m_myTableView[11];
    UIButton *          m_mySegBtn[11];
    NSMutableArray *main_dataArry[11];
    NSInteger      page[11];
    
    NSInteger      diJiYeIndex;
}
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
-(void)getrequest_methodWithTheWorkModel:(TheWorkModel *)model;



@end
