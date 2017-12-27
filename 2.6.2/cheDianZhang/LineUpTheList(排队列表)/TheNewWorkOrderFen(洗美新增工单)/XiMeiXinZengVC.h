//
//  XiMeiXinZengVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "NumberKeyboard.h"
#import "CarInformeTionCell.h"
#import "CouponsCardVC.h"
#import "Car_TiShiView.h"
#import "XiMeiXinZengZuiZongModel.h"
#import "XiMeiXinZengZuiZongModel.h"



@interface XiMeiXinZengVC : BaseViewController
{
    UITextField *phoneTextField;
    UITextField *nameTextField;
    NSMutableArray *jiBenArray;
    NSMutableArray *xinZengArray;
    NSMutableArray *niMingxinZengArray;
    NSMutableArray *couponsArray;
}

@property(nonatomic,strong)NSDictionary *userInformetionDict;

@property(nonatomic,strong)NSDictionary *postDict;
@property(nonatomic,strong)UITableView *main_tabelView;
@property(nonatomic,assign)BOOL shiFouNiMing;//是否匿名
@property(nonatomic,assign)BOOL shiFouZhuCe;//是否注册
@property(nonatomic,assign)BOOL shiFouQiYe;//yes是企业。 NO不是企业

@property(nonatomic,strong)Users_carsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)Car_TiShiView *car_TiShiView;


@property(nonatomic,strong)NSString *chePaiStr;//是否有车牌

@property(nonatomic,strong)XiMeiXinZengZuiZongModel *zuiZongModel;

@property(nonatomic,assign)BOOL shiFouTianJia;



@end


@interface XiMeiXinZengVC (Net)
-(void)postNetWorkPhone:(NSString *)mobile;
-(void)postNetWorkOrder_user:(NSString *)mobile WithName:(NSString *)name;

@end
