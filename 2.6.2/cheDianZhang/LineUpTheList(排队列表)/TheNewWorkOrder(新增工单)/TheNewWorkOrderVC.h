//
//  TheNewWorkOrderVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/6.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "NumberKeyboard.h"
#import "TheNewWorkOrderModel.h"
#import "CarInformeTionCell.h"
#import "CouponsCardVC.h"
#import "Car_TiShiView.h"
#import "Car_zongModel.h"

@interface TheNewWorkOrderVC : BaseViewController
{
    UITextField *phoneTextField;
    UITextField *nameTextField;
    UITextField *qiyeTextField;
    UITextField *songPhoneTextField;
    UITextField *songNameTextField;
    NSMutableArray *jiBenArray;
    NSMutableArray *xinZengArray;
    NSMutableArray *couponsArray;
}
@property(nonatomic,strong)NSDictionary *userInformetionDict;
@property(nonatomic,strong)NSDictionary *postDict;
@property(nonatomic,strong)UITableView *main_tabelView;
@property(nonatomic,assign)BOOL shiFouZhuCe;//yes没有注册。NO注册
@property(nonatomic,assign)BOOL shiFouQiYe;//yes是企业。 NO不是企业

@property(nonatomic,strong)Users_carsModel *xinZengModel;//新增车辆
@property(nonatomic,strong)Car_TiShiView *car_TiShiView;

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@property(nonatomic,strong)NSString *chePaiStr;//是否有车牌

@property(nonatomic,assign)BOOL shiFouTianJian;



@end



@interface TheNewWorkOrderVC (Net)
-(void)postNetWorkPhone:(NSString *)mobile;
-(void)postNetWorkOrder_user:(NSString *)mobile WithName:(NSString *)name;

@end
