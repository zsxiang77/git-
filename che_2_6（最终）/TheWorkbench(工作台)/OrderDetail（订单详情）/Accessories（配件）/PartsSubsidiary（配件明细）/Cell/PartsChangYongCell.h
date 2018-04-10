//
//  PartsChangYongCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface PartsChangYongCell : UITableViewCell
{
    UILabel * titleLable;
    UILabel * bianhaoLable;
    UILabel * kucunLable;
    UILabel * danweiLable;
    UILabel * danjiaLable;
}
-(void)refelesePeiJianWithModel:(OrderDetailPartsModel *)model;
@end
