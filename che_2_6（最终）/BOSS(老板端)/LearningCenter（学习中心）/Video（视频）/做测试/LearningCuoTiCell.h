//
//  LearningCuoTiCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningZuoCeShiModel.h"
@interface LearningCuoTiCell : UITableViewCell
{
    UIImageView  *xuanZhongImageView;
    UILabel      *titleLabe;
    UIImageView  *duiHaoImageView;
}


-(void)shuaXinData:(NSString *)daAnAtr withZhengQueStr:(NSString *)zhengQueStr withWrongStr:(NSString *)wrongStr witINdex:(NSInteger)row;
@end
