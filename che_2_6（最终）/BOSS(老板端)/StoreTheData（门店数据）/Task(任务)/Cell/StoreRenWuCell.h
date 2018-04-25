//
//  StoreRenWuCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/21.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTheDataModel.h"
@interface StoreRenWuCell : UITableViewCell
{
   UILabel * fenleiLable;
   UILabel * yiwanChengLable;
   UILabel * weiWanchengLable;
   UILabel * guoqiLable;
   UILabel * zongshuLable;
   UILabel * yuyueLable;
}

-(void)refleshData:(Task_listModel *)dict dieIndex:(NSIndexPath*)index;
@end
