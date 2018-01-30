//
//  BOSSSystemXiTongCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOSSSystemXiTongCell : UITableViewCell
{
    UILabel     *gengXinDateLabel;
    UILabel     *titleLabel;
    UILabel     *neiRongLabel;
}

-(void)refleshData:(NSDictionary *)dict;

@end
