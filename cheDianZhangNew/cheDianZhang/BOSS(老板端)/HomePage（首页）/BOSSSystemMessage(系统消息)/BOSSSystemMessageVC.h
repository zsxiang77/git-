//
//  BOSSSystemMessageVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "SegmentButtonsView.h"
#import "DuplexTableView.h"

@interface BOSSSystemMessageVC : BOSSBaseViewController
{
    UIButton         *m_mySegBtn[3];
    SegmentButtonsView*m_segButtonsView;
    
    NSMutableArray  *date_dataArray[3];
    UITableView  *m_myTableView[3];
    
    DuplexTableView  *m_moreTable;
}

@end
