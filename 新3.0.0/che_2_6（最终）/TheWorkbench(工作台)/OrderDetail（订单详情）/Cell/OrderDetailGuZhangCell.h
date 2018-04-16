//
//  OrderDetailGuZhangCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailGuZhangCell : UITableViewCell
{
    UILabel *dateLabel;
    UILabel *titleLabel;
}

-(void)refeleseWithModel:(NSDictionary *)model;
@end
