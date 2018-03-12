//
//  TheCustomerCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheCustomerModel.h"

@interface TheCustomerCell : UITableViewCell
{
    UILabel *nameLabel;
    UILabel *zhiWeiLabel;
    UIView  *zhiWeibackView;
    
    UILabel *modileLabel;
}

@property(nonatomic,strong)UILabel *line;

-(void)refleshData:(TheCustomerModel *)model;

@end
