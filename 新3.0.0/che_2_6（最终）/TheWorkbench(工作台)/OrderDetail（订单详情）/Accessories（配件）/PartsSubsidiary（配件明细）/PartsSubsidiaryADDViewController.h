//
//  PartsSubsidiaryADDViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/26.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailModel.h"


@interface PartsSubsidiaryADDViewController : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *changArray;
    NSMutableArray *fenLeiArray;
    
}

@property(nonatomic,strong)BaseViewController *suerViewController;


@end

