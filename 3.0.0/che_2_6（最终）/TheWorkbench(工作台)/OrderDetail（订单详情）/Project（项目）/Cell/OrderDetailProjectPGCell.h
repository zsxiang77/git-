//
//  OrderDetailProjectPGCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaiGongModel.h"
#import "UIImageView+WebCache.h"

@interface OrderDetailProjectPGCell : UITableViewCell
{
    UIImageView         *xuanZhongImageView;
    UIImageView         *touXiangImageView;
    UILabel             *nameLabel;
}
-(void)refeleseWithModel:(PaiGongStaffModel *)model;

@end
