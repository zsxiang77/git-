//
//  DetailPingJiaCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface DetailPingJiaCell : UITableViewCell
{
    UILabel *zhuLabel;
    UIScrollView *zuoYouScrollView;
}

-(void)refleshData:(NSDictionary *)dict;

@end
