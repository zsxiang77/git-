//
//  FillInformationViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "CarColorView.h"
#import "TheNewWorkOrderModel.h"
#import "Car_zongModel.h"
#import "LicenseInformationVC.h"

@interface FillInformationViewController : BaseViewController

@property(nonatomic,strong)XinShiZheng_carsModel *chuanZhiDict;
@property(nonatomic,strong)NSString *officialDate;
@property (strong, nonatomic) NSString *cropImagepath;
@property(nonatomic,strong)CarColorView *carColorView;

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;//最终model跳转必须传

@property(nonatomic,strong)Users_carsModel *zhuModel;

@end


@interface FillInformationViewController (Net)
-(void)postZuiHouQueRenQingQiuWithImage:(NSString *)image;
-(void)postShangChuanTuPianWithImage:(NSArray *)ims;

@end
