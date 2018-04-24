//
//  StoreRenWuRenYuanCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTheDataModel.h"
@interface StoreRenWuRenYuanCell : UITableViewCell
{
    UILabel * nameLable;
    UILabel * daodianLable;
    UILabel * yuyueLable;
}

-(void)refleshData:(Staff_listModel *)dict dieIndex:(NSIndexPath*)index;
@end
