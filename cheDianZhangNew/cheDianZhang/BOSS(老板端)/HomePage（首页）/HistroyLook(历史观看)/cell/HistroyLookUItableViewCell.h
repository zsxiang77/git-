//
//  HistroyLookUItableViewCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistroyModel.h"
@interface HistroyLookUItableViewCell : UITableViewCell
{
    UILabel*titleUilable;
    UILabel*studyUilable;
    UILabel*keshiUilable;
    UILabel*timeLongLable;
    UIImageView*mainimgView;
}
-(void)refleshData:(HistroyModel *)dict;
@end
