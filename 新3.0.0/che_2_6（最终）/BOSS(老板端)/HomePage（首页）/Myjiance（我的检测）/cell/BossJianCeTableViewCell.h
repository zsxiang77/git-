//
//  BossJianCeTableViewCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BossJianceModel.h"
@interface BossJianCeTableViewCell : UITableViewCell
{
    UILabel*titleUilable;
    UILabel*codeUIlable;
    
    UIImageView*mainimgView;
    
    UILabel *dateLabel;
}
-(void)refleshData:(BossJianceModel *)dict;
@end
