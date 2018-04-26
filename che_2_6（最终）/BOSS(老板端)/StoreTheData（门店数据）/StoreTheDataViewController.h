//
//  StoreTheDataViewController.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "UMMobClick/MobClick.h"
#import "StoreTheDataModel.h"
#import "HWCalendar.h"

#import "MJRefresh.h"
#import<WebKit/WebKit.h>
#import "StoreDataHeaderView.h"
#import "StoreShouRuView.h"
#import "StoreRenWuView.h"
#import "StorePeiJianView.h"
#import "StoreRenYuanView.h"
#import "StoreHeaderView.h"
#import "StoreRenyuanModel.h"

@interface StoreTheDataViewController : BOSSBaseViewController<HWCalendarDelegate>
{
    NSInteger page;
    UILabel * lineLable;
    CGFloat widths;
}


@property(nonatomic,strong) StoreRenWuView * renwuView;  //任务
@property(nonatomic,strong)  StoreRenYuanView * renyuanView;//人员
@property(nonatomic,strong) StorePeiJianView * peijianView;//配件
@property(nonatomic,strong) StoreShouRuView * shouruView; //收入

@property(nonatomic,strong)NSString * timeStr;
@property(nonatomic,strong)NSString * dateStr;

@property(nonatomic,strong)NSString * yearStr;
@property(nonatomic,strong)NSString * mouchStr;
@property(nonatomic,strong)StoreTheDataModel *mainModel;


@property (nonatomic, weak) HWCalendar *calendar;//日历
@end


@interface StoreTheDataViewController (Net)


-(void)getrenyuan_list:(BOOL)shuaX;
-(void)getTask_status;
@end

