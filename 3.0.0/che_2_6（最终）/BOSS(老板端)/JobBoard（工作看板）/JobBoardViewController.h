//
//  JobBoardViewController.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "JobBoardHeaderView.h"
#import "DuplexTableView.h"
#import "JobBoardMenuView.h"
#import "JobBoardModel.h"
#import "UIImageView+WebCache.h"

@interface JobBoardViewController : BOSSBaseViewController
{
    DuplexTableView*        m_moreTable;
    JobBoardHeaderView  *m_headerView;
    
    NSInteger       fenYeIndex;
    JobBoardMenuView         *m_menuView;//菜单
}

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray  *mainDataArray;
@property(nonatomic,strong)NSDictionary *mainDataDict;

@property(nonatomic,strong)NSDictionary  *jiuGongHuiDiaoDict;

@end


@interface JobBoardViewController (Net)
-(void)postwork_boardwithShuaXin:(BOOL)shuaX;
-(void)postCuiBan:(JobBoardModel *)model;

@end
