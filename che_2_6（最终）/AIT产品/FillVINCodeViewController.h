//
//  FillVINCodeViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "FillVINCodeHeaderView.h"
#import "VINNewAlertView.h"
#import "VINquedingVIew.h"

@interface FillVINCodeViewController : BaseViewController
{
    NSString     *souSuoNeiRong;
}

@property(nonatomic,strong)NSString *touStr;
@property(nonatomic,strong)FillVINCodeHeaderView  *headerView;

@end
