//
//  StoreRenYuanNengLiCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetliModel.h"
@interface StoreRenYuanNengLiCell : UITableViewCell
{

    UILabel * zuoLable;
    UILabel * youLable;
}
-(void)refleshData:(achievementModel *)dict dieIndex:(NSIndexPath*)index;
@end
