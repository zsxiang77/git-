//
//  BOSSSystemKeChengCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/29.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOSSSystemKeChengCell : UITableViewCell
{
    UIImageView*leftuiImgView;
    UILabel *titleUilable;
    UILabel *keshiUilable;
    UILabel *priceUilable;
    
    UILabel     *gengXinDateLabel;
}
-(void)refleshData:(NSDictionary *)dict;

@end
