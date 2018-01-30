//
//  TheCustomerViewController.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "TheCustomerModel.h"
#import "BJDC_headerTitleView.h"

@interface TheCustomerViewController : BOSSBaseViewController
{
    NSInteger          fenYeIndex;
    BJDC_headerTitleView          *m_scrollPageView;
}

@property(nonatomic,strong)NSDictionary *mainDataDict;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray  *mainDataArray;

@end
@interface TheCustomerViewController (Net)

-(void)postwork_boardwithShuaXin:(BOOL)shuaX;

@end
