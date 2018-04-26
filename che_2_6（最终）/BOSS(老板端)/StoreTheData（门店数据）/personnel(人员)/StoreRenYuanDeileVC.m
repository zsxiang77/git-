//
//  StoreRenYuanDeileVC.m
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenYuanDeileVC.h"

@interface StoreRenYuanDeileVC ()

@end

@implementation StoreRenYuanDeileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"员工能力" withBackButton:YES];
    [self getXiangqing_staff_ability];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//人员详情
-(void)getXiangqing_staff_ability
{
    self.yearStrzhi = [NSString stringWithFormat:@"%@",@""];
    self.monthStrzhi = [NSString stringWithFormat:@"%@",@"2"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.yearStrzhi forKey:@"y"];
    [mDict setObject:self.monthStrzhi forKey:@"m"];
    [mDict setObject:self.chaunzhiStr.staff_id forKey:@"staff_id"];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParameters:mDict withUrl:@"user/store_data/staff_ability" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        //[weakSelf.mainModel setdataDict:dataDic];
       // self.renwuView.zhauModel = weakSelf.mainModel;
        
    } failure:^(id error) {
        
    }];
}
@end
