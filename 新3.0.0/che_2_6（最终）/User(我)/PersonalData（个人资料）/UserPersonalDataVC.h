//
//  UserPersonalDataVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "TheCustomerModel.h"
#import "BJDC_headerTitleView.h"

@interface UserPersonalDataVC : BaseViewController
{
    NSInteger          fenYeIndex;
    BJDC_headerTitleView          *m_scrollPageView;
}

@property(nonatomic,strong)NSDictionary *mainDataDict;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray  *mainDataArray;


@end


@interface UserPersonalDataVC (Net)
-(void)postwork_boardwithShuaXin:(BOOL)shuaX;
@end
