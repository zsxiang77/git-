//
//  WritePersonalViewController.h
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "BaseViewController.h"
#import "XiMeiXinZengZuiZongModel.h"
#import "PopTimePickerView.h"


@interface WritePersonalViewController : BaseViewController
@property(nonatomic,strong)NSDictionary *userInformetionDict;

@property(nonatomic,assign)BOOL shiFouXiMei;
@property(nonatomic,strong)Car_zongModel *zuiZhongModel;
@property(nonatomic,strong)XiMeiXinZengZuiZongModel *xiMeiZuiZhongModel;

@property (nonatomic, copy) NSString *ordercode;
@property (nonatomic, copy) NSString *user_id;

@property(nonatomic,assign)BOOL shiFouQieHuan;//是否切换

@property (nonatomic, strong) PopTimePickerView *timePickerView;

@property(nonatomic,assign)BOOL shiFouKeHu;

@end
