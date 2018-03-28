//
//  SwitchRolesCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchRolesCell : UITableViewCell
{
    UIImageView   *touImageView;
    UILabel   *nameLabel;
    UIImageView   *xuanZhongImageView;
}

-(void)refeleseWithModel:(NSDictionary *)dict;

@end
