//
//  CustomerInformationVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/31.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "XiMeiXinZengZuiZongModel.h"

@interface CustomerInformationVC : BaseViewController

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;
@property(nonatomic,strong)XiMeiXinZengZuiZongModel *xiMeiZuiZhongModel;

@property(nonatomic,strong)NSDictionary *userInformetionDict;

@property(nonatomic,assign)BOOL shiFouWeiXiu;//是否维修

@end
