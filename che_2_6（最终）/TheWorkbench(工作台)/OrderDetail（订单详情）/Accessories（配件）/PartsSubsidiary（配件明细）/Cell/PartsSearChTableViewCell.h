//
//  PartsSearChTableViewCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface PartsSearChTableViewCell : UITableViewCell
{
    UILabel * titleLable;
    UILabel * bianhaoLable;
    UILabel * kucunLable;
    UILabel * danweiLable;
    UILabel * danjiaLable;
}
-(void)refelesePeiJianWithModel:(NSDictionary *)model;
@end
