//
//  OrderDetailGuZhangQiTaCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailGuZhangQiTaCell : UITableViewCell
{
    UIView  *backView;
}

-(void)refeleseWithXianMuModel:(NSArray *)model;
-(void)refeleseWithPeiJianModel:(NSArray *)model;

-(void)refeleseWithServicesModel:(NSArray *)model;
-(void)refeleseWithCommodsModel:(NSArray *)model;

@end
