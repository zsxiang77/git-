//
//  WorkOrderTypeVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "WorkOrderTypeVC.h"
#import "TheNewWorkOrderVC.h"

@interface WorkOrderTypeVC ()

@end

@implementation WorkOrderTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"工单类型" withBackButton:YES];
    CGFloat viewHeight = (kWindowH - kNavBarHeight)/self.chuanZhiArray.count;
    for (int i = 0; i<self.chuanZhiArray.count; i++) {
        UIView *bujuView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+viewHeight*i, kWindowW, viewHeight)];
        bujuView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bujuView];
        
        UIButton *dianJibt = [[UIButton alloc]init];
        [dianJibt addTarget:self action:@selector(tiaoZhuanChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [bujuView addSubview:dianJibt];
        dianJibt.tag = 2000+i;
        [dianJibt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(bujuView);
            make.width.height.mas_equalTo(150);
        }];
        UIImageView *beiiMage = [[UIImageView alloc]init];
        [bujuView addSubview:beiiMage];
        [beiiMage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bujuView);
            make.top.mas_equalTo(dianJibt.mas_top).mas_equalTo(10);
            make.width.height.mas_equalTo(60);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.textColor = kNavBarColor;
        label1.text = [NSString stringWithFormat:@"%@工单",KISDictionaryHaveKey(self.chuanZhiArray[i], @"channel_name")];
        [bujuView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bujuView);
            make.top.mas_equalTo(beiiMage.mas_bottom).mas_equalTo(10);
        }];
        
        if ([KISDictionaryHaveKey(self.chuanZhiArray[i], @"channel_id") integerValue] == 4) {
            beiiMage.image = DJImageNamed(@"work_weixiu");
            label1.textColor = kNavBarColor;
        }
        if ([KISDictionaryHaveKey(self.chuanZhiArray[i], @"channel_id") integerValue] == 2) {
            beiiMage.image = DJImageNamed(@"work_ximei");
            label1.textColor = kRGBColor(240, 150, 27);
        }
        
        [bujuView bringSubviewToFront:dianJibt];
        
        UILabel *linr = [[UILabel alloc]init];
        linr.backgroundColor = kLineBgColor;
        [bujuView addSubview:linr];
        [linr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    
}


-(void)tiaoZhuanChick:(UIButton *)sender
{
    NSInteger index = sender.tag - 2000;
    if ([KISDictionaryHaveKey(self.chuanZhiArray[index], @"channel_id") integerValue] == 4) {
        TheNewWorkOrderVC *vc = [[TheNewWorkOrderVC alloc]init];
        if (self.userInformetionDict) {
            vc.userInformetionDict = self.userInformetionDict;
        }
        vc.chePaiStr = self.chePaiStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([KISDictionaryHaveKey(self.chuanZhiArray[index], @"channel_id") integerValue] == 2) {
        XiMeiXinZengVC *vc = [[XiMeiXinZengVC alloc]init];
        if (self.userInformetionDict) {
            vc.userInformetionDict = self.userInformetionDict;
        }
        vc.chePaiStr = self.chePaiStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
