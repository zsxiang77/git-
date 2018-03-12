//
//  MaintenanceHistoryVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "SegmentButtonsView.h"
#import "DuplexTableView.h"

@interface MaintenanceHistoryVC : BaseViewController
{
    UIButton    *m_mySegBtn[2];
    UITableView *main_tableView[2];
    NSInteger   pageIndex[2];
    NSMutableArray *m_dateArray[2];
    SegmentButtonsView *m_segButtonsView;
    DuplexTableView *m_moreTable;
}

@property(nonatomic,assign)BOOL shiFouWeiXiu;//是否维修
@property(nonatomic,strong)NSString *user_id;

@end

@interface MaintenanceHistoryVC (Net)

-(void)postWeiXiuXiangMuQingQiuWithShuXin:(BOOL)shuaXin;
-(void)postWeiXiuPeiJianQingQiuWithShuXin:(BOOL)shuaXin;
-(void)postXiMeiXiangMuQingQiuWithShuXin:(BOOL)shuaXin;
-(void)postXiMeiPeiJianQiuWithShuXin:(BOOL)shuaXin;


@end
