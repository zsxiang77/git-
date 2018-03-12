//
//  BOSSSystemWoDeCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"

@interface BOSSSystemWoDeCell : UITableViewCell
{
    UIImageView *touImageView;
    UILabel     *nameLabel;
    UILabel     *neiRongLabel;
    UIView      *huiFuView;
    UILabel     *huiFuLabel;
    
    UILabel     *gengXinDateLabel;
}


-(void)refleshData:(NSDictionary *)dict;

@end
