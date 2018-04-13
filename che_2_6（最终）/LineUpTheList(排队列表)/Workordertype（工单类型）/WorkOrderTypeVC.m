//
//  WorkOrderTypeVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "WorkOrderTypeVC.h"
#import "CustomerInformationVC.h"
#import "kehuXuQiuViewController.h"
#import "WritePersonalViewController.h"
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
        label1.textColor = kZhuTiColor;
        label1.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.chuanZhiArray[i], @"channel_name")];
        [bujuView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bujuView);
            make.top.mas_equalTo(beiiMage.mas_bottom).mas_equalTo(10);
        }];
        
        if ([KISDictionaryHaveKey(self.chuanZhiArray[i], @"channel_id") integerValue] == 4) {
            beiiMage.image = DJImageNamed(@"work_weixiu");
            label1.textColor = kZhuTiColor;
        }
        if ([KISDictionaryHaveKey(self.chuanZhiArray[i], @"channel_id") integerValue] == 2) {
            beiiMage.image = DJImageNamed(@"work_ximei");
            label1.textColor = kRGBColor(98, 172, 73);
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
    [UserInfo shareInstance].chuanCheArrayStr = self.chePaiStr;
    if (self.userInformetionDict) {
        [UserInfo shareInstance].userInformetionDict = self.userInformetionDict;
    }else{
        [UserInfo shareInstance].userInformetionDict = nil;
    }
    
    if ([KISDictionaryHaveKey(self.chuanZhiArray[index], @"channel_id") integerValue] == 4) {//维修
        if ([self.userInformetionDict isKindOfClass:[NSDictionary class]]) {
            Car_zongModel *zuiZhongModel = [[Car_zongModel alloc]init];
            zuiZhongModel.car_Color = self.chePaiColorStr;
            zuiZhongModel.car_number = self.chePaiStr;
            if (self.userInformetionDict) {
                NSDictionary *users_details = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
                if ([users_details isKindOfClass:[NSDictionary class]]) {
                    zuiZhongModel.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"user_id")];
                    zuiZhongModel.mobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"mobile")];
                    zuiZhongModel.realname = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"realname")];
                    
                    
                }
            }else{
                zuiZhongModel.user_id = @"0";
                zuiZhongModel.mobile = @"";
                zuiZhongModel.realname = @"";
            }
            
            
            CustomerInformationVC *vc = [[CustomerInformationVC alloc]init];
            vc.userInformetionDict = self.userInformetionDict;
            vc.zuiZhongModel = zuiZhongModel;
            vc.shiFouWeiXiu = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            TianRuXXViewController *kehuXuQiu = [TianRuXXViewController new];
            kehuXuQiu.shiFouWeiXiu = YES;
            [self.navigationController pushViewController:kehuXuQiu animated:YES];
        }
    }
    
    if ([KISDictionaryHaveKey(self.chuanZhiArray[index], @"channel_id") integerValue] == 2) {//洗美
        XiMeiXinZengZuiZongModel *zuiZhongModel = [[XiMeiXinZengZuiZongModel alloc]init];
        zuiZhongModel.car_number = self.chePaiStr;
        zuiZhongModel.plate_color = self.chePaiColorStr;
        if (self.userInformetionDict) {
            NSDictionary *users_details = KISDictionaryHaveKey(self.userInformetionDict, @"users_details");
            if ([users_details isKindOfClass:[NSDictionary class]]) {
                zuiZhongModel.user_id = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"user_id")];
                zuiZhongModel.mobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"mobile")];
                zuiZhongModel.realname = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"realname")];
                zuiZhongModel.send_mobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"mobile")];
                zuiZhongModel.send_name = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_details, @"realname")];
            }
            
            NSArray *users_cars = KISDictionaryHaveKey(self.userInformetionDict, @"users_cars");
            if ([users_cars isKindOfClass:[NSArray class]] && users_cars.count>0) {
                NSDictionary *users_carsDict = users_cars[0];
                zuiZhongModel.car_brand = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_carsDict, @"car_brand")];
                zuiZhongModel.car_type = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_carsDict, @"car_type")];
                if ([NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_carsDict, @"plate_color")].length>0) {
                    zuiZhongModel.plate_color = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(users_carsDict, @"plate_color")];
                }
            }
        }else{
            zuiZhongModel.user_id = @"0";
            zuiZhongModel.mobile = @"";
            zuiZhongModel.realname = @"";
        }
        
        if ([self.userInformetionDict isKindOfClass:[NSDictionary class]]) {
//            NSArray *order_listArray = KISDictionaryHaveKey(self.userInformetionDict, @"order_list");
            CustomerInformationVC *vc = [[CustomerInformationVC alloc]init];
            vc.userInformetionDict = self.userInformetionDict;
            vc.shiFouWeiXiu = NO;
            vc.xiMeiZuiZhongModel = zuiZhongModel;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            TianRuXXViewController *vc = [TianRuXXViewController new];
            vc.xiMeiZuiZhongModel = zuiZhongModel;
            vc.shiFouWeiXiu = NO;
            [self.navigationController pushViewController:vc animated:YES];
            
//            WritePersonalViewController *vc = [WritePersonalViewController new];
//            vc.xiMeiZuiZhongModel = zuiZhongModel;
//            vc.shiFouXiMei = YES;
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}




@end
