//
//  MyKeChengTableViewCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyKechengModel.h"
@interface MyKeChengTableViewCell : UITableViewCell
{
    UIImageView*leftuiImgView;
    UILabel *titleUilable;
    UILabel *keshiUilable;
    UILabel *priceUilable;
}
-(void)refleshData:(MyKechengModel *)dict;
@end
