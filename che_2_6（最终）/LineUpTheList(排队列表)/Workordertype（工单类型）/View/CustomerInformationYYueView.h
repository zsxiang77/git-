//
//  CustomerInformationYYueView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerInformationYYueCell.h"
#import "CustomerInformationYYueModel.h"
#import "CustomerInformationYYueCell2.h"

@interface CustomerInformationYYueView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UILabel*lableJect;
    UILabel*lableTime;
    UILabel*lableShengTime;
}
@property(nonatomic,strong)CustomerInformationYYueModel *mainModel;

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UITableView *mainTableView;

-(void)shouView;
-(void)disMissView;
-(void)shuaXinDaTaShuJu;
@end
