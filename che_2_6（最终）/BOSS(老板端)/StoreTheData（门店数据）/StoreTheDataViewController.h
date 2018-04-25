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
#import "StoreRiLiView.h"
@interface StoreTheDataViewController : BOSSBaseViewController
{
    NSInteger page;
}
@property(nonatomic,strong)NSString * timeStr;
@property(nonatomic,strong)NSString * dateStr;

@property(nonatomic,strong)NSString * yearStr;
@property(nonatomic,strong)NSString * mouchStr;
@property(nonatomic,strong)StoreTheDataModel *mainModel;
@property(nonatomic,strong)StoreRiLiView * storeViews;
@end
