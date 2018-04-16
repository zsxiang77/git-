//
//  CustomerInformationYYueCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface CustomerInformationYYueCell : UITableViewCell
{

    UILabel *zuoLabel;
    UILabel *youLabel;
}

-(void)shuxinCellXiangMu:(OrderDetailSubjectsModel*)model;
-(void)shuxinCellPeiJian:(OrderDetailPartsModel*)model;
@end
