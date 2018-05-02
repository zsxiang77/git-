//
//  StoreRenYuanCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreRenyuanModel.h"
@interface StoreRenYuanCell : UITableViewCell
{
    UIImageView * touImgview;
    UIImageView * renYuanimgview;
    UILabel * nameLable;
    UILabel * yejiLable;
    UILabel * shunxuLable;
}
-(void)refleshData:(listModel *)dict dieIndex:(NSIndexPath*)index;
@end
